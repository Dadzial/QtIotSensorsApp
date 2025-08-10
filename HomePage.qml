import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {

    property StackView stackView

    Label {
        id: labelHome
        text: "Choose device :"
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.top: parent.top
        anchors.topMargin: 5
        font.pixelSize: 19
        font.family: myInter.name
    }

    FontLoader{
        id: myInter
        source: "./fonts/Inter_28pt-Light.ttf"
    }

    Rectangle {
        id:divider
        anchors.top: labelHome.bottom
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: "white"
        opacity: 0.2
    }

    Grid{
        id:buttonGrid
        columns: 4
        spacing: 15
        anchors.top: divider.top
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.topMargin: 16


        Repeater {
            model: [
                { text: "Temperature", icon : "./icons/temperature.png" , page: "TemperaturePage.qml"},
                { text: "Humidity", icon : "./icons/humidity.png" , page: "HumidityPage.qml"}
            ]

            delegate: Button {
                width: 150
                height: 50

                background:Rectangle{
                    radius: 10
                    color: "#151D2D"
                }

                contentItem: Row {
                    spacing: 8
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height

                    Image {
                        source: modelData.icon
                        width: 30
                        height: 30
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: modelData.text
                        font.pixelSize: 16
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                property real normalY: y
                Component.onCompleted: normalY = y

                property real hoverOffset: -4

                Behavior on y {
                    NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
                }

                hoverEnabled: true
                onHoveredChanged: {
                    y = hovered ? normalY + hoverOffset : normalY
                }
                onClicked: {
                    var sv = parent
                    while (sv && !sv.push) sv = sv.parent
                    if (sv) sv.push(modelData.page)
                }
            }
        }
    }
}
