/**********************************************************************************
 *  Copyright (c) 2014 Anthony Vital <anthony.vital@gmail.com>                    *
 *  Copyright (c) 2018 intika <intika.dev@gmail.com>                              *
 *                                                                                *
 *  This file is part of Ultimate Gmail Feed.                                     *
 *                                                                                *
 *  Ultimate Gmail Feed is free software: you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by          *
 *  the Free Software Foundation, either version 3 of the License, or             *
 *  (at your option) any later version.                                           *
 *                                                                                *
 *  Ultimate Gmail Feed is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of                *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 *
 *  GNU General Public License for more details.                                  *
 *                                                                                *
 *  You should have received a copy of the GNU General Public License             *
 *  along with Ultimate Gmail Feed. If not, see <http://www.gnu.org/licenses/>.   *
 *********************************************************************************/

import QtQuick 2.0
import QtQml.XmlListModel
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.plasmoid
import org.kde.plasma.private.ultimategmailfeed

PlasmoidItem {
    id: mainItem
    
    // Updater 1/3 ==================================================================================================================================
    property string updateResponse;
    property string currentVersion: '2.2';
    property bool checkUpdateStartup: Plasmoid.configuration.checkUpdateStartup
    // ==============================================================================================================================================
    
    property string subtext: ""
    property string title: Plasmoid.title
        
    toolTipSubText: subtext
    Plasmoid.icon: xmlModel.count > 0 ? "mail-unread-new" : "mail-unread"
    compactRepresentation: CompactRepresentation {}
    fullRepresentation: FullRepresentation {}
    switchWidth: units.gridUnit * 8
    switchHeight: units.gridUnit * 8
    
    Plasma5Support.DataSource {
            id: executable
            engine: "executable"
            connectedSources: []
            onNewData: {
                var exitCode = data["exit code"]
                var exitStatus = data["exit status"]
                var stdout = data["stdout"]
                var stderr = data["stderr"]
                exited(exitCode, exitStatus, stdout, stderr)
                disconnectSource(sourceName) // cmd finished
            }
            function exec(cmd) {
                connectSource(cmd)
            }
            signal exited(int exitCode, int exitStatus, string stdout, string stderr)
    }
    
    NetworkStatus {
        id: networkStatus
        onIsOnlineChanged: checkMailOneShotTimer.start()
    }
    
    Timer {
        id: checkMailOneShotTimer
        interval: 1000
        onTriggered: polltimer.restart()
    }
    
    Notification {
        id: notification
    }
    
    XmlListModel {
        id: xmlModel
        
        property int newMailCount: 0
        property int newMailId: -1

        source: ""
        query: "/"
        //namespaceDeclarations: "declare default element namespace 'http://purl.org/atom/ns#';"
        
        XmlListModelRole { name: "author"; elementName: "author/name" }
        XmlListModelRole { name: "title"; elementName: "title" }
        XmlListModelRole { name: "link"; elementName: "link"; attributeName: "href" }
        XmlListModelRole { name: "id"; elementName: "id" }
        
        onRowsInserted: {
            newMailCount += last-first+1
            newMailId = first
        }
        
        onStatusChanged: {
            switch (status) {
                case XmlListModel.Null:
                    mainItem.subtext = "Offline - " + plasmoid.configuration.userName
                    break
                case XmlListModel.Ready:
                    plasmoid.status = (xmlModel.count > 0) ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.PassiveStatus
                    if (xmlModel.count > 0) {
                        mainItem.subtext = i18np("1 unread message", "%1 unread messages - " + plasmoid.configuration.userName, xmlModel.count)
                    } else {
                        mainItem.subtext = i18n("No unread messages - " + plasmoid.configuration.userName)
                    }
                    if (newMailCount > 0) {
                        var message
                        if (newMailCount == 1) 
                            message = "<b>"+get(newMailId).author+": "+"</b>"+get(newMailId).title
                        else 
                            if (newMailCount == 20) {message =  i18np("1 new message", "%1 new messages at least", newMailCount)} 
                            else {message =  i18np("1 new message", "%1 new messages", newMailCount)}
                        notification.send("new-mail-arrived", mainItem.title, message, "ultimategmailfeed", "ultimategmailfeed")
                        newMailCount = 0
                    }
                    break
                case XmlListModel.Loading:
                    mainItem.subtext = i18n("Checking for new messages...")
                    break
                case XmlListModel.Error:
                    mainItem.subtext = errorString()
                    break
                default:
                    console.log(status)
                    break
            }
        }
    }
        
    Timer {
        id: polltimer
        repeat: true
        triggeredOnStart: true
        interval: plasmoid.configuration.pollinterval * 60000
        onTriggered: autoOrNot()
    }
    
    function manuelCheck() {
    
        if (plasmoid.configuration.multiLine) {
            plasmoid.configuration.multiLineCode = "br/"
            plasmoid.configuration.multiLineCodeHeight = 30
        }
        else {
            plasmoid.configuration.multiLineCode = ""
            plasmoid.configuration.multiLineCodeHeight = 10
        }
    
        xmlModel.source = plasmoid.configuration.transProt 
                          + plasmoid.configuration.userName 
                          + "%40" 
                          + plasmoid.configuration.realM 
                          + "@"
                          + plasmoid.configuration.serverURL
        xmlModel.query = plasmoid.configuration.serverQuery
        xmlModel.reload()
    }
    
    function autoOrNot() {
        if (plasmoid.configuration.manualCheck == false) {
            networkStatus.isOnline ? manuelCheck() : mainItem.subtext = i18n("Offline - " + plasmoid.configuration.userName)
        }
    }
    
    function action_openInboxMail() {
        executable.exec(plasmoid.configuration.commandOpenMail)
    }
    
    // Updater 2/3 ==================================================================================================================================
    
    Plasma5Support.DataSource {
        id: executableNotification
        engine: "executable"
        onNewData: disconnectSource(sourceName) // cmd finished
        function exec(cmd) {
            connectSource(cmd)
        }
    }
    
    Timer {
        id:timerStartUpdater
        interval: 300000
        onTriggered: updaterNotification(false)
    }
    
    function availableUpdate() {
        var notificationCommand = "notify-send --icon=ultimategmailfeed 'Plasmoid Ultimate Gmail Feed' 'An update is available \n<a href=\"https://www.opendesktop.org/p/1248550/\">Update link</a>' -t 30000";
        executableNotification.exec(notificationCommand);
    }

    function noAvailableUpdate() {
        var notificationCommand = "notify-send --icon=ultimategmailfeed 'Plasmoid Ultimate Gmail Feed' 'Your current version is up to date' -t 30000";
        executableNotification.exec(notificationCommand);
    }
    
    function updaterNotification(notifyUpdated) {
        var xhr = new XMLHttpRequest;
        xhr.responseType = 'text';
        xhr.open("GET", "https://raw.githubusercontent.com/intika/Ultimate-Gmail-Feed/master/version");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                updateResponse = xhr.responseText;
                console.log('.'+updateResponse+'.');
                console.log('.'+currentVersion+'.');
                //console.log('.'+xhr.status+'.');
                //console.log('.'+xhr.statusText+'.');
                if (updateResponse.localeCompare(currentVersion) && updateResponse.localeCompare('') && updateResponse.localeCompare('404: Not Found\n')) {
                    availableUpdate();
                } else if (notifyUpdated) {
                    noAvailableUpdate();
                }
            }
        };
        xhr.send();
    }
    
    function action_checkUpdate() {
        updaterNotification(true);
    }
    // ==============================================================================================================================================
    
    function action_checkMail() {
        networkStatus.isOnline ? manuelCheck() : mainItem.subtext = i18n("Offline - " + plasmoid.configuration.userName)
    }
    
    function action_openInbox() {
    
        if (plasmoid.configuration.openURLInsteadMain) {
            Qt.openUrlExternally(plasmoid.configuration.transProt + "mail.google.com")
        }
        else {
            executable.exec(plasmoid.configuration.commandOpen)
        }
        
    }
    
    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Open inbox")
            icon.name: "folder-mail"
            onTriggered: action_openInbox()
        },
        PlasmaCore.Action {
            text: i18n("Check mail")
            icon.name: "mail-receive"
            onTriggered: action_checkMail()
        },
        PlasmaCore.Action {
            id: separator1
            isSeparator: true
        },
        // Updater 3/3 ==============================================================================================================================
        PlasmaCore.Action {
            text: i18n("Check for updates on github")
            icon.name: "view-grid"
            onTriggered: action_checkUpdate()
        },
        PlasmaCore.Action {
            id: separator2
            isSeparator: true
        }
        // ==========================================================================================================================================
    ]
    
    Component.onCompleted: { 
        plasmoid.status = PlasmaCore.Types.PassiveStatus

        // Updater 3/3 ==============================================================================================================================
        if (checkUpdateStartup) {timerStartUpdater.start();}
        // ==========================================================================================================================================
        
        if (plasmoid.configuration.manualCheck == false) {
            polltimer.start()
        }
    }
    
}

