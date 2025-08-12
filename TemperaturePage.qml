import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Item {
    id: root
    property int temperature: 0
    property int maxTemperature: 100
    property real animatedTemperature: 0
    onAnimatedTemperatureChanged: wheelTemperature.requestPaint()

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
            id: labelTemp
            text: "Temperature"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 15
            font.pixelSize: 19
            font.family: myInter.name
        }

        Rectangle {
            id: dividerTemp
            anchors.top: labelTemp.bottom
            anchors.topMargin: 2
            anchors.left: parent.left
            anchors.right: parent.right
            height: 1
            color: "white"
            opacity: 0.2
        }

        RowLayout {
            id: mainRowTemp
            anchors.top: dividerTemp.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            spacing: 25

            Rectangle {
                id:currenttemp
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
                        height: labelTemp2.implicitHeight

                        Label {
                            id: labelTemp2
                            text: "Current Temperature :"
                            font.pixelSize: 20
                            font.family: myInter.name
                            color: "#151D2D"
                            horizontalAlignment: Text.AlignHCenter
                            anchors.fill: parent
                        }

                        DropShadow {
                            anchors.fill: labelTemp2
                            source: labelTemp2
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
                            id: wheelTemperature
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
                                var endAngle = startAngle + (2 * Math.PI) * (root.animatedTemperature / root.maxTemperature);

                                ctx.beginPath();
                                ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
                                ctx.lineWidth = 20;
                                ctx.strokeStyle = "#1F3D78";
                                ctx.stroke();

                                ctx.fillStyle = "white";
                                ctx.font = "bold 40px '" + myInter.name + "'";
                                ctx.textAlign = "center";
                                ctx.textBaseline = "middle";
                                ctx.fillText(Math.round(root.animatedTemperature) + "°C", centerX, centerY);
                            }
                        }

                        DropShadow {
                            anchors.fill: wheelTemperature
                            source: wheelTemperature
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
                id: animTemperature
                target: root
                property: "animatedTemperature"
                duration: 1000
                easing.type: Easing.InOutQuad
            }

            ColumnLayout {
                spacing: 25
                Layout.fillWidth: true
                Layout.fillHeight: true

                Rectangle {
                    id:tempHistory
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    radius: 20

                    Column {
                        anchors.fill: parent
                        anchors.margins: 15
                        spacing: 15

                        Item {
                            id: labelWrapperHistory
                            width: parent.width
                            height: labelHistory.implicitHeight

                            Label {
                                id: labelHistory
                                text: "Current Temperature :"
                                font.pixelSize: 20
                                font.family: myInter.name
                                color: "#151D2D"
                                horizontalAlignment: Text.AlignHCenter
                                anchors.fill: parent

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

                        ScrollView {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: labelWrapperHistory.bottom
                            anchors.bottom: parent.bottom
                            clip: true

                            Column {
                                width: parent.width
                                spacing: 8

                                //wpisy tutaj
                            }
                        }
                    }
                }
                Rectangle {
                    id:tempAlarm
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                    radius: 20
                }
            }
        }
    }

    Connections {
        target: tempSensor
        function onTempChange(newTemperature) {
            root.temperature = newTemperature
            animTemperature.to = newTemperature
            animTemperature.start()
        }
    }
}
