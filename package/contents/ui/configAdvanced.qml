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
    id: generalPage
    
    width: childrenRect.width
    height: childrenRect.height
    
    property alias cfg_leftclickCheck: leftclickCheckCheckbox.checked
    property alias cfg_invertMailList: invertMailListCheckbox.checked
    property alias cfg_middleClickMail: middleClickMailCheckbox.checked
    property alias cfg_popupHeight: popupHeight.value
    property alias cfg_popupWidth: popupWidth.value
    property alias cfg_lineHeight: lineHeight.value
    property alias cfg_lineWidth: lineWidth.value
    
    Kirigami.FormLayout {    
        ColumnLayout {
            
            QtControls.CheckBox {
                id: invertMailListCheckbox
                text: i18n("Invert mail list order")                            
            }
    
            QtControls.CheckBox {
                id: leftclickCheckCheckbox
                text: i18n("Check mailbox on left click")
            }
        
            QtControls.CheckBox {
                id: middleClickMailCheckbox
                text: i18n("Middle click open inbox application/link")                            
            }
        
            Kirigami.FormLayout { 
                RowLayout {
                    QtControls.Label {
                        text: i18n("Popup height (work outside system tray) : ")
                    }
    
                    QtControls.SpinBox {
                        id: popupHeight
                        editable: true
                        validator: RegularExpressionValidator {
                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                        }
                        textFromValue: function(value) {
                            return value+"px";
                        }
                        valueFromText: function(text) {
                            return text.split(" ")[0].split("px")[0];
                        }
                        from: 1
                        to: 9999
                    }
                }
            
                RowLayout {
                    QtControls.Label {
                        text: i18n("Popup width (work outside system tray) : ")
                    }

                    QtControls.SpinBox {
                        id: popupWidth
                        editable: true
                        validator: RegularExpressionValidator {
                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                        }
                        textFromValue: function(value) {
                            return value+"px";
                        }
                        valueFromText: function(text) {
                            return text.split(" ")[0].split("px")[0];
                        }
                        from: 1
                        to: 9999
                    }
                }
        
                RowLayout {
                    QtControls.Label {
                        text: i18n("Mail line height : ")
                    }

                    QTCotrols.SpinBox {
                        id: lineHeight
                        editable: true
                        validator: RegularExpressionValidator {
                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                        }
                        textFromValue: function(value) {
                            return value+"px";
                        }
                        valueFromText: function(text) {
                            return text.split(" ")[0].split("px")[0];
                        }
                        from: 1
                        to: 9999
                    }
                }
        
                RowLayout {
                    QtControls.Label {
                        text: i18n("Mail line width : ")
                    }
                    
                    Kirigami.FormLayout {
                        ColumnLayout {
                            
                            QtControls.CheckBox {
                                id: invertMailListCheckbox
                                text: i18n("Invert mail list order")                            
                            }
                    
                            QtControls.CheckBox {
                                id: leftclickCheckCheckbox
                                text: i18n("Check mailbox on left click")
                            }
                        
                            QtControls.CheckBox {
                                id: middleClickMailCheckbox
                                text: i18n("Middle click open inbox application/link")                            
                            }
                        
                            Kirigami.FormLayout {
                                RowLayout {
                                    QtControls.Label {
                                        text: i18n("Popup height (work outside system tray) : ")
                                    }

                                    QtControls.SpinBox {
                                        id: popupHeight
                                        editable: true
                                        validator: RegularExpressionValidator {
                                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                                        }
                                        textFromValue: function(value) {
                                            return value+"px";
                                        }
                                        valueFromText: function(text) {
                                            return text.split(" ")[0].split("px")[0];
                                        }
                                        from: 1
                                        to: 9999
                                    }
                                }
                            
                                RowLayout {
                                    QtControls.Label {
                                        text: i18n("Popup width (work outside system tray) : ")
                                    }

                                    QtControls.SpinBox {
                                        id: popupWidth
                                        editable: true
                                        validator: RegularExpressionValidator {
                                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                                        }
                                        textFromValue: function(value) {
                                            return value+"px";
                                        }
                                        valueFromText: function(text) {
                                            return text.split(" ")[0].split("px")[0];
                                        }
                                        from: 1
                                        to: 9999
                                    }
                                }
                        
                                RowLayout {
                                    QtControls.Label {
                                        text: i18n("Mail line height : ")
                                    }

                                    QTCotrols.SpinBox {
                                        id: lineHeight
                                        editable: true
                                        validator: RegularExpressionValidator {
                                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                                        }
                                        textFromValue: function(value) {
                                            return value+"px";
                                        }
                                        valueFromText: function(text) {
                                            return text.split(" ")[0].split("px")[0];
                                        }
                                        from: 1
                                        to: 9999
                                    }
                                }
                        
                                RowLayout { 
                                    QtControls.Label {
                                        text: i18n("Mail line width : ")
                                    }

                                    QTCotrols.SpinBox {
                                        id: lineWidth
                                        editable: true
                                        validator: RegularExpressionValidator {
                                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                                        }
                                        textFromValue: function(value) {
                                            return value+"px";
                                        }
                                        valueFromText: function(text) {
                                            return text.split(" ")[0].split("px")[0];
                                        }
                                        from: 1
                                        to: 9999
                                    }
                                }
                            }
                        }
                    }

                    QTCotrols.SpinBox {
                        id: lineWidth
                        editable: true
                        validator: RegularExpressionValidator {
                            regularExpression: /[0-9]?[0-9]{3}[ ]?px/
                        }
                        textFromValue: function(value) {
                            return value+"px";
                        }
                        valueFromText: function(text) {
                            return text.split(" ")[0].split("px")[0];
                        }
                        from: 1
                        to: 9999
                    }
                }
            }
        }
    }
} 

