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
    id: configPageAdvanced
    
    width: childrenRect.width
    height: childrenRect.height
    
    property alias cfg_leftclickCheck: leftclickCheckCheckbox.checked
    property alias cfg_invertMailList: invertMailListCheckbox.checked
    property alias cfg_middleClickMail: middleClickMailCheckbox.checked
    property alias cfg_popupHeight: popupHeight.value
    property alias cfg_popupWidth: popupWidth.value
    property alias cfg_lineHeight: lineHeight.value
    property alias cfg_lineWidth: lineWidth.value
    
    ColumnLayout {

        Kirigami.FormLayout {    
            
            QtControls.CheckBox {
                id: invertMailListCheckbox
                text: i18nc("@option:check", "Invert mail list order")
            }

            QtControls.CheckBox {
                id: leftclickCheckCheckbox
                text: i18nc("@option:check", "Check mailbox on left click")
            }
            
            QtControls.CheckBox {
                id: middleClickMailCheckbox
                text: i18nc("@option:check", "Middle click open inbox application/link")
            }

        }

        Kirigami.FormLayout {
            
            QtControls.SpinBox {
                id: popupHeight
                Kirigami.FormData.label: i18nc("@label", "Popup height (work outside system tray) : ")
                from: 1
                to: 9999
                textFromValue: function(value, locale) {
                    return qsTr("%1 px").arg(value);
                }
            }
            
            QtControls.SpinBox {
                id: popupWidth
                Kirigami.FormData.label: i18nc("@label", "Popup width (work outside system tray) : ")
                from: 1
                to: 9999
                textFromValue: function(value, locale) {
                    return qsTr("%1 px").arg(value);
                }
            }
            
            QtControls.SpinBox {
                id: lineHeight
                Kirigami.FormData.label: i18nc("@label", "Mail line height : ")
                from: 1
                to: 9999
                textFromValue: function(value, locale) {
                    return qsTr("%1 px").arg(value);
                }
            }
            
            QtControls.SpinBox {
                id: lineWidth
                Kirigami.FormData.label: i18nc("@label", "Mail line width : ")
                from: 1
                to: 9999
                textFromValue: function(value, locale) {
                    return qsTr("%1 px").arg(value);
                }
            }
        }
    }
} 

