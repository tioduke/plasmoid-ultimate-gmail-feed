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
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid

PlasmaExtras.ListItem {
    id: listItem
    enabled: true
    
    property int lineWidth: Plasmoid.configuration.lineWidth
    property int lineHeight: Plasmoid.configuration.lineHeight
    
    height: lineHeight
    width: lineWidth
    
    PlasmaComponents.Label {
        id: label
        anchors.left: parent.left
        anchors.right: parent.right
        elide: Text.ElideRight
        
        height: plasmoid.configuration.multiLineCodeHeight 
        text: i18nc("Message delegate, author: title", "<b>%1 : </b><" + plasmoid.configuration.multiLineCode + ">%2", author, title)        
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: activate()
    }
    
    function activate() {
        if (plasmoid.configuration.openURLInsteadMail) {
            Qt.openUrlExternally(link)
        }
        else {
            mainItem.action_openInboxMail()
        }
    }
}
