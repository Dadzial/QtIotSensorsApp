import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    width: 1000
    height: 680
    visible: true
    title: qsTr("Sensors")
    color: "#1F3D78"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ToolBar {
            Layout.fillWidth: true
            height: 55
            background: Rectangle {
                color: "#151D2D"
            }

            RowLayout {
                anchors.fill: parent

                Image {
                    source: "./icons/signal_icon.svg"
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                }

                Item { Layout.fillWidth: true }

                ToolButton {
                    icon.source: "./icons/bxs_home.png"
                    icon.width: 40
                    icon.height: 40
                    background: null
                    onClicked: stackView.pop(null)
                }

                Item { Layout.fillWidth: true }

                ToolButton {
                    icon.source: "./icons/material-symbols_settings.png"
                    icon.width: 40
                    icon.height: 40
                    background: null
                }
            }
        }
        StackView {
            id: stackView
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: "HomePage.qml"
        }
    }
}
