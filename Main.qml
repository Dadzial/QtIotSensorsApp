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
}

