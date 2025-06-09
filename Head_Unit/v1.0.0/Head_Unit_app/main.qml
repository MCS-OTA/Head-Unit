import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: mainWindow
    width: 1024
    height: 600
    visible: true
    color: "#000000"
    title: qsTr("Head Unit")

    property bool showGearBox: false
    property bool showMenu: false

    StackView {
        id: stackView
        anchors.fill: parent

        Image {
            id: bgSport
            source: "./image/bg_sport.png"
            visible: carInfoController.modeColor === "red" ? true : false
        }

        initialItem: Item {
            TopLayer {
                id: topLayer
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            BottomLayer {
                id: bottomLayer
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            CarInfo {
                id: carInfo
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MapWidget {
                id: map_widget
                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        stackView.push("qrc:/MapApplication.qml")
                    }
                }
            }

            AppWidget {
                id: spareWidget
                width: 280
                height: 240
                anchors.right: parent.right
                anchors.rightMargin: 40
                anchors.verticalCenter: parent.verticalCenter

            }
        }
    }

    GearBoxWindow {
        visible: showGearBox
    }

    MenuWindow {
        visible: showMenu
    }

    ParkingWindow {
        visible: gearController.selectedButton === "R" ? true : false
    }

    StartScreen {
        id: startScreen
        anchors.centerIn: parent
    }
}
