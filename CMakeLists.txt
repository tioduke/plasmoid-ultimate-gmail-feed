project(ultimategmailfeed)

cmake_minimum_required(VERSION 3.5.0)

option(BUILD_WITH_QT6 "Use Qt6 instead of Qt5" ON)

set(QT_MIN_VERSION "6.6.2")
set(KF6_MIN_VERSION "6.0.0")

find_package(ECM 0.0.11 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

include(KDEInstallDirs6)
include(KDECMakeSettings)
include(KDECompilerSettings)

find_package(Qt6 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Quick)
find_package(Plasma ${KF6_MIN_VERSION} REQUIRED COMPONENTS Plasma)

plasma_install_package(package org.kde.plasma.ultimategmailfeed)

add_subdirectory( plugin )
add_subdirectory( icons )

set(KNOTIFYRC_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/share/knotifications6)

install(FILES ultimategmailfeed.notifyrc DESTINATION ${KNOTIFYRC_INSTALL_DIR})

add_subdirectory( po )
