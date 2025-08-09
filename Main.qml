import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
ApplicationWindow {
    width: 1000
    height: 680
    visible: true
    title: qsTr("Sensors")
    color: "#1F3D78"

    //Toolbar
    header: ToolBar {
        background: Rectangle {
            color: "#151D2D"
            height: 55
        }

        RowLayout {
            anchors.fill: parent

            Image{
                source: "./icons/signal_icon.svg"
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
            }

            Item {
                Layout.fillWidth: true
            }

            ToolSeparator {
                    contentItem: Rectangle {
                    implicitWidth: parent.vertical ? 1 : 24
                    implicitHeight: parent.vertical ? 24 : 1
                    color: "white"
                }
            }

            ToolButton {
                icon.source: "./icons/bxs_home.png"
                icon.width: 40
                icon.height: 40
                height: parent.height

                onClicked: console.log("Home")

                background: Item {
                    id: bg
                    width: parent.width
                    height: parent.height

                    Rectangle {
                        id: shadowSource
                        width: parent.width
                        height: parent.height
                        radius: 20
                        color: "white"
                        opacity: 0
                        visible: true
                    }

                    DropShadow {
                        anchors.fill: shadowSource
                        source: shadowSource
                        horizontalOffset: 0
                        verticalOffset: 0
                        radius: 20
                        samples: 24
                        color: "white"
                        opacity: shadowSource.opacity
                    }
                }
            }

            ToolSeparator {
                    contentItem: Rectangle {
                    implicitWidth: parent.vertical ? 1 : 24
                    implicitHeight: parent.vertical ? 24 : 1
                    color: "white"
                }
            }
            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                icon.source: "./icons/material-symbols_settings.png"
                icon.width: 40
                icon.height: 40
                background: null
            }
        }
    }
    //Toolbar End

    //Home view

    Label {
        id: label
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
        anchors.top: label.bottom
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: "white"
        opacity: 0.2
    }

    Grid{
        columns: 4
        spacing: 15
        anchors.top: divider.top
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.topMargin: 16


        Repeater {
            model: [
                { text: "Temperature", icon : "./icons/temperature.png" },
                { text: "Humidity", icon : "./icons/humidity.png" }
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
            }
        }
    }
}

