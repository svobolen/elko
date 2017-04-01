import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2


Controls.SplitView {
    id: electrodePlacement

    property alias zoomSwitch: zoomSwitch
    property alias fixButton: fixButton
    property alias comboBox: comboBox
    property alias exportButton: exportButton
    //property alias elecList: elecList
    property alias fileDialog: fileDialog
    property alias electrodePlacement: electrodePlacement

    property var name
    property int zHighest: 1
    property int currListIndex: -1
    property bool zoomEnabled: false
    property var images: []
    property ListModel electrodes: ListModel {
//        ListElement {columns: 5; rows: 2}
//        ListElement {columns: 5; rows: 3}
//        ListElement {columns: 5; rows: 4}
//        ListElement {columns: 5; rows: 2}
//        ListElement {columns: 5; rows: 3}
//        ListElement {columns: 5; rows: 4}
//        ListElement {columns: 5; rows: 2}
//        ListElement {columns: 5; rows: 3}
//        ListElement {columns: 20; rows: 4}
//        ListElement {columns: 5; rows: 2}
//        ListElement {columns: 5; rows: 3}
//        ListElement {columns: 5; rows: 4}
    }
    orientation: Qt.Horizontal

    DropArea {
        id: imageArea
        width: 3/4*parent.width
        height: parent.height
        Layout.minimumWidth: 100
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

    Controls.SplitView {
        orientation: Qt.Vertical
        resizing: false

        Rectangle {
            width: secondColumn.width
            height: secondColumn.height
            Layout.minimumWidth: 100
            color: "white"
            z:2
            Column {
                id: secondColumn
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
                    model: ["indexes", "wave names", "indexes + waves"]
                    currentIndex: 2
                    displayText: "Display: " + currentText
                }
                Button {
                    id: resetButton
                    text: qsTr("Reset positions")
                }
                Button {
                    id: exportButton
                    text: qsTr("Export image")
                }
                FileDialog {
                    id: fileDialog
                    folder: shortcuts.documents
                    selectExisting: false
                    nameFilters: [ "JPEG Image (*.jpg)", "PNG Image (*.png)", "Bitmap Image (*.bmp)", "All files (*)" ]
                }
            }
        }

        Flickable {
            Layout.minimumWidth: 100
            contentHeight: electrodeColumn.height
            contentWidth: electrodeColumn.width
            boundsBehavior: Flickable.OvershootBounds

            Rectangle {
                width: electrodeColumn.width
                height: electrodeColumn.height
                Layout.minimumWidth: 100
                color: "white"
                Column {
                    id: electrodeColumn
                    spacing: 10
                    padding: 5

                    Repeater {
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
                                    electrodes.insert(index + 1, { columns: columns, rows: rows, links: links})
                                }
                            }
                            Electrode {
                                id: electrode
                                columnCount: columns
                                rowCount: rows
                                indexNumber: index
                                linksList: links
                                //                draggable: true
                            }
                        }
                    }
                }
            }
            ScrollIndicator.vertical: ScrollIndicator { }
            ScrollIndicator.horizontal: ScrollIndicator { }
        }
    }
}



//    onCurrListIndexChanged: {
//        elecList.currentIndex = currListIndex
//        elecList.currentItem.z = ++zHighest
//    }
// }









