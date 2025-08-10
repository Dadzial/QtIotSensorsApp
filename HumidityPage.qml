import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    Rectangle {
        anchors.fill: parent
        color: "#1F3D78"
    }

    FontLoader {
        id: myInter
        source: "./fonts/Inter_28pt-Light.ttf"
    }

    Label {
        id: labelHumidity
        text: "Humidity"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 15
        font.pixelSize: 19
        font.family: myInter.name
        color: "white"
    }

    Rectangle {
        id: dividerHumidity
        anchors.top: labelHumidity.bottom
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: "white"
        opacity: 0.2
    }

    RowLayout {
        id: mainRowHumidity
        anchors.top: dividerHumidity.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        spacing: 25

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "white"
            radius: 10
        }

        ColumnLayout {
            spacing: 25
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                radius: 10
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                radius: 10
            }
        }
    }
}
