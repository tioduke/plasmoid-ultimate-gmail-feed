/*
 * Copyright (C) 2019 by intika <intika@librefox.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation;
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>
 */
import QtQuick
import QtQuick.Controls as QtControls
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami

KCM.SimpleKCM {
    id: configPageUpdater
    
    property alias cfg_checkUpdateStartup: checkUpdateStartupBox.checked
    
    Kirigami.FormLayout { 
        ColumnLayout {
            QtControls.Label {
                text: i18n("Updater")
                font.weight: Font.Bold
            }
            QtControls.Label {
                text: i18n("Plasmoid: Ultimate Gmail Feed\n")
            }
            QtControls.Label {
                text: i18n("Version: 2.2")
            }
            QtControls.Label {
                text: i18n("Author: TioDuke")
            }
            QtControls.TextField {
                Layout.minimumWidth: 450
                text: 'https://github.com/tioduke/plasmoid-ultimate-gmail-feed/'
            }
            QtControls.CheckBox {
                id: checkUpdateStartupBox
                text: i18n("Notify for update on startup (checked once on github, 5 min after startup)")
            }
        }
    }
}


 
