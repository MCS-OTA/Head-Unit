import QtQuick 2.0

Item {
    id: topLayer
    width: 1024
    height: 110

    Text{
        id: timeInfo
        text: Clock.currentTime_short
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 40
        font.pixelSize: 40
        color: "#FFFFFF"    //carInfoController.modeColor
    }

    Connections{
        target: Clock
        onTimeChanged: timeInfo.text = Clock.currentTime_short
    }

    Text{
        id: dateInfo
        text: Clock.today_date
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: timeInfo.left
        anchors.bottom: timeInfo.top
        anchors.bottomMargin: -35
        font.pixelSize: 25
        color: "#FFFFFF"    //carInfoController.modeColor
    }

    Connections{
        target: Clock
        onTimeChanged: dateInfo.text = Clock.today_date
    }

    Text {
        id: seame
        text: "S     E     A     M     E"
        font.pixelSize: 40
        color: carInfoController.modeColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image {
        id: weatherImage
        width: 30
        height: 30
        visible: false

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 40
    }

    Text {
        id: tempInfo

        font.pixelSize: 25
        color: "white"

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: weatherImage.left
        anchors.rightMargin: 20
    }

    Text {
        id: region
        text: "Wolfsburg"
        font.pixelSize: 25
        color: "white"

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: tempInfo.left
        anchors.rightMargin: 20

        Component.onCompleted: {
                weather.fetchWeatherData(region.text)
            }
    }

    Timer {
        id: updateTimer
        interval: 10000
        running: true
        repeat: true

        onTriggered: {
            weather.fetchWeatherData(region.text)
        }
    }

    Connections {
        target: weather

        function onWeatherDataReceived(cityName, temperature, weatherDescription, iconPath) {
            weatherImage.source = iconPath
            weatherImage.visible = true
            tempInfo.text = temperature + " °C"
        }
    }

    Component.onCompleted:  {
        updateTimer.start();
    }
}
