import QtQuick 2.0

Item {
    id: settingMenuButton

    width: 100
    height: 30

    property string menuName: ""
    property bool showing: false

    Rectangle {
        id: settingButton
        width: parent.width
        height: parent.height
        anchors.fill: parent
        color: "black"
        radius: 30

        visible: settingMenuButton.showing
    }

    Text {
        text: settingMenuButton.menuName
        font.pixelSize: 15
        color: settingButton.visible ? carInfoController.modeColor: "black"
        anchors.centerIn: settingButton
    }

}
