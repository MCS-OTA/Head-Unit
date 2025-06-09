import QtQuick 2.0

Item {
    id: bottomLayer
    width: 1024
    height: 110

    Image {
        id: icon_menu
        width: 55
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "./image/icon_menu.png"
        opacity: carInfoController.modeColor === "#A2F2D9" ? 1 : 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.showMenu = true;
            }
        }
    }

    Image {
        width: 55
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "./image/icon_menu2.png"
        opacity: carInfoController.modeColor === "red" ? 1 : 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.showMenu = true;
            }
        }
    }

    Image {
        width: 55
        height: width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "./image/icon_menu3.png"
        opacity: carInfoController.modeColor === "white" ? 1 : 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.showMenu = true;
            }
        }
    }

    Image {
        id: icon_music
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: icon_youtube.left
        anchors.rightMargin: 40
        source: "./image/icon_music.png"
        visible: carInfoController.modeColor === "white" ? false : true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stackView.push("qrc:/MusicApplication.qml")
            }
        }
    }

    Image {
        id: icon_youtube
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: icon_menu.left
        anchors.rightMargin: 40
        source: "./image/icon_youtube.png"
        visible: carInfoController.modeColor === "white" ? false : true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stackView.push("qrc:/VideoApplication.qml")
            }
        }
    }

    Image {
        id: icon_weather
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: icon_menu.right
        anchors.leftMargin: 40
        source: "./image/icon_weather.png"
        visible: carInfoController.modeColor === "white" ? false : true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stackView.push("qrc:/WeatherApplication.qml")
            }
        }
    }

    Image {
        id: icon_mode
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: icon_weather.right
        anchors.leftMargin: 40
        source: "./image/icon_mode.png"
        visible: carInfoController.modeColor === "white" ? false : true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                stackView.push("qrc:/SettingApplication.qml")
            }
        }
    }

}
