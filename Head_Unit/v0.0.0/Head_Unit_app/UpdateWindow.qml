import QtQuick 2.0

Rectangle {
    id: updateBackground
    color: "#CC000000"
    anchors.fill: parent

    Rectangle {
        id: updateWindow
        width: 400
        height: 160
        color: "#000000"
        radius: 5

        anchors.centerIn: parent

        Rectangle {
            id: topBar
            width: parent.width
            height: parent.height * 0.15
            color: "#373737"

            Text {
                id: updateTitle
                color: "#FFFFFF"
                font.pixelSize: 12
                text: "Update"

                anchors.centerIn: parent
            }

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: updateContext
            color: "#FFFFFF"
            font.pixelSize: 16
            font.bold: true
            text: "Would you like to update to a new version?"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: topBar.bottom
            anchors.topMargin: 30
        }

        Row {
            id: buttonRow
            spacing: 40

            Rectangle {
                id: yesButton
                width: 100
                height: 30
                color: "#373737"

                Text {
                    id: yesText
                    color: "#FFFFFF"
                    font.pixelSize: 12
                    text: "Yes"

                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        otaUpdate.setUpdateResponse(1)
                        otaUpdate.setUpdateRequest(0)
                        updateBackground.visible = false
                    }
                    z: -1
                }
            }

            Rectangle {
                id: noButton
                width: 100
                height: 30
                color: "#373737"

                Text {
                    id: noText
                    color: "#FFFFFF"
                    font.pixelSize: 12
                    text: "No"

                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        otaUpdate.setUpdateResponse(0)
                        otaUpdate.setUpdateRequest(0)
                        updateBackground.visible = false
                    }
                    z: -1
                }
            }

            anchors.top: updateContext.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            updateBackground.visible = false
        }
        z: -1
    }

}
