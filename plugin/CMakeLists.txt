add_definitions(-DTRANSLATION_DOMAIN="plasma_applet_org.kde.plasma.ultimategmailfeed")
option (USE_QT6 "Use Qt6 instead of Qt5" ON)

find_package(Qt6 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS Network)
find_package(KF6Notifications)

set(ultimategmailfeedplugin_SRCS
    ultimategmailfeedplugin.cpp
    networkstatus.cpp
    notification.cpp
)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/kde/plasma/private/ultimategmailfeed)
add_library(ultimategmailfeedplugin SHARED ${ultimategmailfeedplugin_SRCS})

target_link_libraries(ultimategmailfeedplugin
                        Qt6::Quick
                        Qt6::Network
                        KF6::Notifications
                        )

install(TARGETS ultimategmailfeedplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/plasma/private/ultimategmailfeed)
