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
import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5 as QQC2
import org.kde.kcmutils as KCM
import org.kde.kirigami 2.5 as Kirigami

KCM.SimpleKCM {
    id: configPageUpdater
    
    property alias cfg_checkUpdateStartup: checkUpdateStartupBox.checked
    
    Kirigami.FormLayout {    
        ColumnLayout {
            QQC2.Label {
                text: i18n("\nUpdater")
                font.weight: Font.Bold
            }
            QQC2.Label {
                text: i18n("Plasmoid: Ultimate Gmail Feed\n")
            }
            QQC2.Label {
                text: i18n("Version: 2.2")
            }
            QQC2.Label {
                text: i18n("Author: TioDuke")
            }
            QQC2.TextField {
                Layout.minimumWidth: 450
                text: 'https://github.com/tioduke/plasmoid-ultimate-gmail-feed/'
            }
            QQC2.CheckBox {
                id: checkUpdateStartupBox
                text: i18n("Notify for update on startup (checked once on github, 5 min after startup)")
            }
        }
    }
}


 
