import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property int humidity: 0
    property int maxHumidity: 100
    property real animatedHumidity: 0
    onAnimatedHumidityChanged: wheelHumidity.requestPaint()

    DropShadow {
        anchors.fill: rectangle
        source: rectangle
        horizontalOffset: 2
        verticalOffset: 2
        radius: 8
        samples: 16
        color: "#44000000"
    }

    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: "#1F3D78"

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
                id: currentHumidity
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                radius: 20

                Column {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 15

                    Item {
                        id: labelWrapper
                        width: parent.width
                        height: labelHumidity2.implicitHeight

                        Label {
                            id: labelHumidity2
                            text: "Current Humidity :"
                            font.pixelSize: 20
                            font.family: myInter.name
                            color: "#151D2D"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.fill: parent
                        }

                        DropShadow {
                            anchors.fill: labelHumidity2
                            source: labelHumidity2
                            horizontalOffset: 1
                            verticalOffset: 1
                            radius: 4
                            samples: 16
                            color: "#80000000"
                        }
                    }

                    Item {
                        id: canvasWrapper
                        anchors.fill: parent
                        anchors.topMargin: 10

                        Canvas {
                            id: wheelHumidity
                            anchors.fill: parent
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.reset();
                                var centerX = width / 2;
                                var centerY = height / 2;
                                var radius = Math.min(width, height) / 2 - 40;

                                ctx.beginPath();
                                ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
                                ctx.fillStyle = "#151D2D";
                                ctx.fill();

                                var startAngle = -Math.PI / 2;
                                var endAngle = startAngle + (2 * Math.PI) * (root.animatedHumidity / root.maxHumidity);

                                ctx.beginPath();
                                ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
                                ctx.lineWidth = 20;
                                ctx.strokeStyle = "#1F3D78";
                                ctx.stroke();

                                ctx.fillStyle = "white";
                                ctx.font = "bold 40px '" + myInter.name + "'";
                                ctx.textAlign = "center";
                                ctx.textBaseline = "middle";
                                ctx.fillText(Math.round(root.animatedHumidity) + "%", centerX, centerY);
                            }
                        }

                        DropShadow {
                            anchors.fill: wheelHumidity
                            source: wheelHumidity
                            horizontalOffset: 2
                            verticalOffset: 2
                            radius: 8
                            samples: 16
                            color: "#44000000"
                        }
                    }
                }
            }

            NumberAnimation {
                id: animHumidity
                target: root
                property: "animatedHumidity"
                duration: 1000
                easing.type: Easing.InOutQuad
            }

            ColumnLayout {
                spacing: 25
                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle {
                    id: humidityHistory
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    radius: 20

                    Column {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 15

                        Item{
                            id: labelWrapperHistory
                            width: parent.width
                            height: 40

                            Label {
                                id:labelHistory
                                text: "History :"
                                font.pixelSize: 20
                                font.family: myInter.name
                                color: "#151D2D"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                            }
                            Button {
                                text:"Delete History"
                                height: 35
                                width: 130
                                font.pixelSize: 16
                                font.family: myInter.name
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                background: Rectangle {
                                    color:"#151D2D"
                                    radius: 20
                                }
                                onClicked: {
                                    //tutaj usuwanie histori wilgotnosci
                                }
                            }
                            DropShadow {
                                anchors.fill: labelHistory
                                source: labelHistory
                                horizontalOffset: 1
                                verticalOffset: 1
                                radius: 4
                                samples: 16
                                color: "#80000000"
                            }
                        }
                        ScrollView{
                            width: parent.width
                            height: parent.height -50
                            clip: true

                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                            ListView {
                                width: parent.width
                                height: parent.height
                                //tutaj model
                            }
                        }
                    }
                }
                Rectangle {
                    id: humidityAlarm
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    radius: 20

                    Column {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 15

                        Item {
                            id: labelWrapperAlarm
                            anchors.left: parent.left
                            anchors.right: parent.right
                            height: 40

                            Label {
                                id: labelAlarm
                                text: "Alarms :"
                                font.pixelSize: 20
                                font.family: myInter.name
                                color: "#151D2D"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                            }

                            Button {
                                text: "Delete Alarms"
                                height: 35
                                width: 130
                                font.pixelSize: 16
                                font.family: myInter.name
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                background: Rectangle {
                                    color:"#151D2D"
                                    radius:20
                                }
                            }

                            DropShadow {
                                anchors.fill: labelAlarm
                                source: labelAlarm
                                horizontalOffset: 1
                                verticalOffset: 1
                                radius: 4
                                samples: 16
                                color: "#80000000"
                            }
                        }
                        ScrollView {
                            width: parent.width
                            height: parent.height - 50
                            clip: true

                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                            ListView {
                                width: parent.width
                                height: parent.height
                                model: blank //tu bedzie nowy model !!!

                                delegate: Column {
                                    width: ListView.view.width

                                    Text {
                                        text: model.display
                                        font.pixelSize: 21
                                        color: "#151D2D"
                                        anchors.left: parent.left
                                        anchors.leftMargin: 10
                                        font.family: myInter.name
                                    }

                                    Rectangle {
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.rightMargin: 15
                                        height: 1
                                        width: 430
                                        color: "#151D2D"
                                        opacity: 0.5
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Connections {
        target: humiditySensor
        function onHumidityChange(newHumidity) {
            root.humidity = newHumidity
            animHumidity.to = newHumidity
            animHumidity.start()
        }
    }
}
