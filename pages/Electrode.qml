import QtQuick 2.6
import QtQuick.Controls 2.0


Item {
    id: root
    property int columnCount
    property int rowCount
    property int size: 20
    property alias color: electrode.color
    property int indexNumber
    property bool draggable: true
    property bool flickable: true
    property alias basicE: electrode
    property alias mouseArea: mouseArea
    property ListModel linkList
    property int yPosition: 0

    width: columnCount*size; height: rowCount*size;

    Rectangle {
        id: sourceBorder;
        anchors.fill: parent;
        border.color: (color == "#ffffff") ? "black" : color
        radius: size/2
    }
    onColorChanged: {
        sourceBorder.border.color = color
    }

    Flickable {
        id: flick
        enabled: flickable

        BasicElectrode {
            id: electrode
            columnCount: root.columnCount
            rowCount: root.rowCount
            size: root.size
            droppingEnabled: false
            linkedTracks: linkList
            parent: root

            Behavior on scale { NumberAnimation { duration: 200 } }
            Behavior on x { NumberAnimation { duration: 0 } }
            Behavior on y { NumberAnimation { duration: 0 } }

            Drag.active: mouseArea.drag.active


            PinchArea {
                enabled: draggable
                anchors.fill: parent
                pinch.target: electrode
                pinch.minimumRotation: -360
                pinch.maximumRotation: 360
                pinch.minimumScale: 0.5
                pinch.maximumScale: 10
                pinch.dragAxis: Pinch.XAndYAxis
                onSmartZoom: {
                    if (pinch.scale > 0) {
                        electrode.rotation = 0;
                        electrode.scale = Math.min(root.width, root.height) / Math.max(electrode.sourceSize.width, electrode.sourceSize.height) * 0.85
                        electrode.x = flick.contentX + (flick.width - electrode.width) / 2
                        electrode.y = flick.contentY + (flick.height - electrode.height) / 2
                    } else {
                        electrode.rotation = pinch.previousAngle
                        electrode.scale = pinch.previousScale
                        electrode.x = pinch.previousCenter.x - electrode.width / 2
                        electrode.y = pinch.previousCenter.y - electrode.height / 2
                    }
                }
                MouseArea {
                    id: mouseArea
                    hoverEnabled: true
                    anchors.fill: parent
                    anchors.centerIn: parent
                    drag.target: electrode
                    scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                    onPressAndHold: {
                        menu.open()
                    }
                    onPressed: {
                        electrodePlacement.currIndex = root.indexNumber
                    }
                    onWheel: {
                        if (draggable) {
                            if (wheel.modifiers & Qt.ControlModifier) {
                                electrode.rotation += wheel.angleDelta.y / 120 * 5;
                                if (Math.abs(electrode.rotation) < 4)
                                    electrode.rotation = 0;
                            } else {
                                electrode.rotation += wheel.angleDelta.x / 120;
                                if (Math.abs(electrode.rotation) < 0.6)
                                    electrode.rotation = 0;
                                var scaleBefore = electrode.scale;
                                electrode.scale += electrode.scale * wheel.angleDelta.y / 120 / 10;
                            }
                        }
                    }
                    onReleased: {
                        var previousParent = electrode.parent
                        electrode.parent = (electrode.Drag.target === null) ?  root : electrode.Drag.target

                        if (previousParent == root & electrode.parent != root ) {
                            electrode.x = electrode.x + electrode.parent.width + electrodePlacement.electrodeRep.itemAt(root.indexNumber).elec.x
                            electrode.y = electrode.y + root.yPosition - electrodePlacement.column.height*electrodePlacement.scrollIndicator.position
                        } else if (electrode.parent == root){
                            electrode.x = 0
                            electrode.y = 0
                            electrode.scale = 1
                        } //else nothing (just moving with mouse)
                    }
                    Menu {
                        id: menu
                        x: mouseArea.mouseX
                        y: mouseArea.mouseY
                        width: 150

                        MenuItem {
                            text: qsTr("Fix position")
                            onTriggered: {
                                draggable = false
                                mouseArea.drag.target = null
                            }
                        }
                        MenuItem {
                            text: qsTr("Change position")
                            onTriggered: {
                                draggable = true
                                mouseArea.drag.target = electrode
                            }
                        }
                        MenuItem {
                            text: qsTr("Change color...")
                            onTriggered: colorMenu.open()

                            Menu {
                                id: colorMenu
                                x: parent.width
                                y: 0
                                width: 150
                                title: qsTr("Change color...")
                                closePolicy: Popup.CloseOnPressOutside

                                signal menuClicked(color itemColor)
                                onMenuClicked: {
                                    electrode.color = itemColor
                                    sourceBorder.border.color = itemColor
                                    root.parent.color = itemColor
                                    menu.close()
                                }

                                MenuItem {
                                    Rectangle {anchors.fill: parent; color: "purple"}
                                    onTriggered: colorMenu.menuClicked("purple")
                                }
                                MenuItem {
                                    Rectangle {anchors.fill: parent; color: "blue"}
                                    onTriggered: colorMenu.menuClicked("blue")
                                }
                                MenuItem {
                                    Rectangle {anchors.fill: parent; color: "green"}
                                    onTriggered: colorMenu.menuClicked("green")
                                }
                                MenuItem {
                                    Rectangle {anchors.fill: parent; color: "yellow"}
                                    onTriggered: colorMenu.menuClicked("yellow")
                                }
                                MenuItem {
                                    Rectangle {anchors.fill: parent; color: "orange"}
                                    onTriggered: colorMenu.menuClicked("orange")
                                }
                                MenuItem {
                                    Rectangle {anchors.fill: parent; color: "red"}
                                    onTriggered: colorMenu.menuClicked("red")
                                }
                                MenuItem {
                                    text: "default"
                                    onTriggered: colorMenu.menuClicked("white")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
