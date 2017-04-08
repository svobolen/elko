import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2


Controls.SplitView {
    id: electrodePlacement

    property alias zoomSwitch: zoomSwitch
    property alias fixButton: fixButton
    property alias resetButton: resetButton
    property alias comboBox: comboBox
    property alias exportButton: exportButton
    property alias electrodeRep: electrodeRep
    property alias fileDialog: fileDialog
    property alias electrodePlacement: electrodePlacement
    property alias statisticsButton: statisticsButton

    property var name
    property int zHighest: 1
    property int currIndex: -1
    property bool zoomEnabled: false
    property var images: []
    property int minSpikes: 0
    property int maxSpikes: 0
    property ListModel electrodes: ListModel {}
    orientation: Qt.Horizontal

    Item {
        id: imageArea
        width: 3/4*parent.width
        height: parent.height
        Layout.minimumWidth: 3/4*parent.width

        Rectangle {
            anchors.fill: parent
            color: "white"

            Grid {
                id: imagesGrid
                rows: images == null ? 0 : Math.round(images.length/2)
                spacing: 10
                padding: 5
                Repeater {
                    model: images
                    Image {
                        source: modelData
                        fillMode: Image.PreserveAspectFit
                        width: (imagesGrid.rows == 1 && images.length !== 1) ? (imageArea.width-20)/(imagesGrid.rows+1) : imageArea.width/imagesGrid.rows
                        height: (imageArea.height-20)/imagesGrid.rows
                    }
                }
            }
            PinchArea {
                enabled: zoomEnabled
                anchors.fill: parent
                pinch.target: imageArea
                pinch.minimumScale: 1
                pinch.maximumScale: 10
                pinch.dragAxis: Pinch.XAndYAxis
                onSmartZoom: imageArea.scale = pinch.scale
                onPinchFinished: {
                    imageArea.scale = 1
                    imageArea.x = 0
                    imageArea.y = 0
                }
            }
        }
    }

    Flickable {
        Layout.minimumWidth: 100
        contentHeight: column.height
        contentWidth: column.width
        boundsBehavior: Flickable.OvershootBounds

        Rectangle {
            id: rect
            width: 1/4*electrodePlacement.width
            height: electrodePlacement.height
            Layout.minimumWidth: 100
            color: "white"
            Column {
                id: column
                spacing: 10
                padding: 5

                Switch {
                    id: zoomSwitch
                    text: qsTr("Image zoom")
                    checked: false
                }
                Switch {
                    id: fixButton
                    text: qsTr("Fix positions")
                    checked: false
                }
                ComboBox {
                    id: comboBox
                    model: ["indexes", "track names", "indexes + tracks"]
                    currentIndex: 2
                    displayText: "Display: " + currentText
                }
                Button {
                    id: statisticsButton
                    text: qsTr("Show spikes statistics")
                }
                Item {
                    height: 20
                    width: 250
                    Label {
                        x: 0
                        text: qsTr("min")
                    }
                    Rectangle {
                        width: 20
                        height: 200
                        x: 111
                        y: -90
                        clip: true
                        rotation: -90
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "indigo" }
                            GradientStop { position: 0.2; color: "blue"}
                            GradientStop { position: 0.4; color: "green"}
                            GradientStop { position: 0.6; color: "yellow"}
                            GradientStop { position: 0.8; color: "orange"}
                            GradientStop { position: 1.0; color: "red" }
                        }
                    }
                    Label {
                        x: 223
                        text: qsTr("max")
                    }
                }
                Item{
                    id: gradientLabels
                    height: 20
                    width: 200
                    Label {
                        x:18
                        text: minSpikes
                    }
                    Label {
                        x: 68
                        text: (maxSpikes - minSpikes)/4
                    }
                    Label {
                        x:118
                        text: (maxSpikes - minSpikes)/2
                    }
                    Label {
                        x: 168
                        text: 3*(maxSpikes - minSpikes)/4
                    }
                    Label {
                        x:218
                        text: maxSpikes
                    }
                }
                Button {
                    id: resetButton
                    text: qsTr("Reset")
                }
                Button {
                    id: exportButton
                    text: qsTr("Export image")
                    FileDialog {
                        id: fileDialog
                        folder: shortcuts.documents
                        selectExisting: false
                        nameFilters: [ "JPEG Image (*.jpg)", "PNG Image (*.png)", "Bitmap Image (*.bmp)", "All files (*)" ]
                    }
                }
                Repeater {
                    id: electrodeRep
                    model: electrodes
                    delegate: Row {
                        id: elRow
                        property alias elec: electrode
                        padding: 5
                        spacing: 5

                        Label {
                            text: rows + "x" + columns
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button {
                            id: plusButton
                            text: "+"
                            background: Rectangle {
                                implicitWidth: 20
                                implicitHeight: 20
                                color: plusButton.down ? "#d6d6d6" : "#f6f6f6"
                                border.color: "black"
                                border.width: 1
                                radius: 20
                            }
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                if(electrode.basicE.x !== 0 & electrode.basicE.y !== 0) {
                                    var component = Qt.createComponent("qrc:/pages/Electrode.qml")
                                    var sameElec = component.createObject(electrode, {"columnCount": columns, "rowCount": rows, "linkList": links, "color": electrode.basicE.color});
                                    console.log("New view on electrode " + rows + "x" + columns + " added.")
                                }
                                for (var i = 0; i < electrode.children.length; i++) {
                                    if(electrode.children[i].columnCount != null) {
                                        console.log(electrode.children[i].columnCount);
                                    }
                                }
                            }

                        }
                        Electrode {
                            id: electrode
                            columnCount: columns
                            rowCount: rows
                            indexNumber: index
                            linkList: links
                        }
                    }
                }
            }

        }
        ScrollIndicator.vertical: ScrollIndicator { }
        ScrollIndicator.horizontal: ScrollIndicator { }
    }

    onCurrIndexChanged: { electrodeRep.itemAt(currIndex).z = ++zHighest }
}
