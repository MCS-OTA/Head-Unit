import QtQuick 2.0

Item {
    id: carInfo
    width: 380
    height: 300

    Image {
        id: carImage
        width: 270 * 1.2
        height: 150 * 1.2
        source: "./image/img_revuelto.png"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -15
        anchors.verticalCenter: parent.verticalCenter
    }

    GearText{
        id:pButton
        buttonSize: 60
        gearLevel: "P"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    GearText{
        id:rButton
        buttonSize: 60
        gearLevel: "R"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: pButton.right
        anchors.leftMargin: 25
    }

    GearText{
        id:nButton
        buttonSize: 60
        gearLevel: "N"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: rButton.right
        anchors.leftMargin: 25
    }

    GearText{
        id:dButton
        buttonSize: 60
        gearLevel: "D"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: nButton.right
        anchors.leftMargin: 25
    }

    Image {
        id: batteryBar
        source: "./image/Battery.png"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    Rectangle {
        id: batteryGauge
        width: (batteryBar.width - 16) * (carInfoController.batteryValue / 100.0)
        height: batteryBar.height - 10
        color: "light green"
        radius: 1

        anchors.left: batteryBar.left
        anchors.leftMargin: 4
        anchors.verticalCenter: batteryBar.verticalCenter
    }

    Text {
        id: batteryNum
        text: carInfoController.batteryValue || "No Data"//carInfoController.batteryLevel + " %"
        anchors.centerIn: batteryBar
        color: "white"
    }

    Image {
        id: leftSignOrigin
        source:"./image/left_origin.png"

        anchors.verticalCenter: batteryBar.verticalCenter
        anchors.right: batteryBar.left
        anchors.rightMargin: 30
    }

    Image {
        id: rightSignOrigin
        source: "./image/right_origin.png"

        anchors.verticalCenter: batteryBar.verticalCenter
        anchors.left: batteryBar.right
        anchors.leftMargin: 30
    }
    Image {
        id: leftSign
        source: "./image/left_green.png"
        visible:  (carInfoController.blinkDirection === "left" || carInfoController.blinkDirection === "emergency") && blinking

        anchors.verticalCenter: batteryBar.verticalCenter
        anchors.right: batteryBar.left
        anchors.rightMargin: 30
    }

    Image {
        id: rightSign
        source: "./image/right_green.png"
        visible:  (carInfoController.blinkDirection === "right" || carInfoController.blinkDirection === "emergency" ) && blinking
        anchors.verticalCenter: batteryBar.verticalCenter
        anchors.left: batteryBar.right
        anchors.leftMargin: 30
    }
    Timer{
        id: blinkTimer
        interval : 500
        repeat: true
        running: true
        onTriggered: {
            blinking = !blinking
        }
    }
}
