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
import QtQuick
import QtQuick.Controls as QtControls
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: configPageGeneral
    
    width: childrenRect.width
    height: childrenRect.height
    
    property alias cfg_pollinterval: spinbox.value
    property alias cfg_manualCheck: manualCheckCheckbox.checked
    property alias cfg_multiLine: multiLineCheckbox.checked
    property alias cfg_openURLInsteadMail: openURLInsteadMail.checked
    property alias cfg_openURLInsteadMain: openURLInsteadMain.checked
    property alias cfg_userName: userName.text
    property alias cfg_realM: realM.text
    property alias cfg_serverURL: serverURL.text
    property alias cfg_serverQuery: serverQuery.text
    property alias cfg_transProt: transProt.text
    property alias cfg_commandOpen: commandOpen.text
    property alias cfg_commandOpenMail: commandOpenMail.text
    
    ColumnLayout {

        Kirigami.FormLayout {

            RowLayout {          
                QtControls.Label {
                    text: i18n("Email account : ")
                }
                QtControls.TextField {
                    id: userName
                    Layout.fillWidth: true
                    text: i18n(cfg_userName)
                }
                QtControls.Label {
                    text: i18n("@")
                }
                QtControls.TextField {
                    id: realM
                    Layout.fillWidth: true
                    text: i18n(cfg_realM)
                }             
            }
            
        }
            
        Kirigami.FormLayout {

            QtControls.TextField {
                id: transProt
                Kirigami.FormData.label: i18nc("@label", "Transfer Protocol :")
                Layout.fillWidth: true
                text: i18n(cfg_transProt)
            }
                        
            QtControls.TextField {
                id: serverURL
                Kirigami.FormData.label: i18nc("@label", "RSS Server :")
                Layout.fillWidth: true
                text: i18n(cfg_serverURL)
            }
            
            QtControls.TextField {
                id: serverQuery
                Kirigami.FormData.label: i18nc("@label", "Server Query :")
                Layout.fillWidth: true
                text: i18n(cfg_serverQuery)
            }
            
            QtControls.TextField {
                id: commandOpen
                Kirigami.FormData.label: i18nc("@label", "Command to run on 'Open inbox' :")
                Layout.fillWidth: true
                text: i18n(cfg_commandOpen)
            }
            
            QtControls.TextField {
                id: commandOpenMail
                Kirigami.FormData.label: i18nc("@label", "Command to run on 'eMail click' :")
                Layout.fillWidth: true
                text: i18n(cfg_commandOpenMail)
            }
            
            QtControls.SpinBox {
                id: spinbox
                Kirigami.FormData.label: i18nc("@label", "Polling interval :")
                Layout.fillWidth: true
                from: 1
                to: 999999
                textFromValue: function(value, locale) {
                    return qsTr("%1 min").arg(value);
                }   
            }
            
        }
            
        Kirigami.FormLayout {

            QtControls.CheckBox {
                id: manualCheckCheckbox
                text: i18n("Check mailbox manually only (ignore polling interval)")
            }
            
            QtControls.CheckBox {
                id: multiLineCheckbox
                text: i18n("Display message subject in a new line")                            
            }
                
            QtControls.CheckBox {
                id: openURLInsteadMail
                text: i18n("Open email link instead of a command on 'eMail click'")
            }
            
            QtControls.CheckBox {
                id: openURLInsteadMain
                text: i18n("Open email link instead of a command on 'Open inbox'")
            }
            
        }
    }
} 

