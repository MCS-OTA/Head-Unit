import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: settingApplication
    width: 1024
    height: 600

    TopBar {
        id: topBar
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: buttonBackground
        width: 250
        height: 40
        radius: 40
        color: "white"

        anchors.top: topBar.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
    }



    Row {
        id: menuRow
        spacing: 5
        anchors.centerIn: buttonBackground

        property int menuNum: 0

        SettingMenuButton {
            id: modebutton
            menuName: "Mode"
            showing: menuRow.menuNum === 0 ? true : false

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuRow.menuNum = 0
                }
            }
        }

        SettingMenuButton {
            id: versionbutton
            menuName: "Version"
            showing: menuRow.menuNum === 1 ? true : false

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    menuRow.menuNum = 1
                }
            }
        }
    }

    Row {
        spacing: 30
        anchors.centerIn: parent
        visible: menuRow.menuNum === 0 ? true : false

        AppWidget {
            id: normalMode
            widthData: 250
            heightData: 250

            Image {
                source: "./image/normal_mode.jpg"
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
            }

            Text {
                text: "NORMAL"
                anchors.centerIn: parent
                font.pixelSize: 50
                font.bold: true
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    carInfoController.setModeColor("#A2F2D9")
                }
            }
        }

        AppWidget {
            id: sportsMode
            widthData: 250
            heightData: 250

            Image {
                source: "./image/sports_mode.jpg"
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
            }

            Text {
                text: "SPORTS"
                anchors.centerIn: parent
                font.pixelSize: 50
                font.bold: true
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    carInfoController.setModeColor("red")
                }
            }
        }

        AppWidget {
            id: simpleMode
            widthData: 250
            heightData: 250

            Image {
                source: "./image/simple_mode.jpg"
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop
            }

            Text {
                text: "SIMPLE"
                anchors.centerIn: parent
                font.pixelSize: 50
                font.bold: true
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    carInfoController.setModeColor("white")
                }
            }
        }
    }

    HomeWidget {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
    }

}
