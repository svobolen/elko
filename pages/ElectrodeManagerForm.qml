import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Page {
    id: item
    property var name
    property alias confirmB: confirmButton
    property alias resetB: resetButton
    property alias addB: addButton
    property alias stripR: stripRep
    property alias gridR: gridRep
    property alias stripT: stripTab
    property alias gridT: gridTab
    property alias stripM: stripModel
    property alias gridM: gridModel
    property alias tabBar: bar

    footer: TabBar {
        id: bar
        width: parent.width
        TabButton { text: qsTr("Strips") }
        TabButton { text: qsTr("Grids") }
    }

    StackLayout {
        id: stack
        width: parent.width
        height: parent.height
        currentIndex: bar.currentIndex
        Flickable {
            contentHeight: stripTab.height
            contentWidth: stripTab.width
            boundsBehavior: Flickable.OvershootBounds

            Item {
                id: stripTab
                width: stripColumn.width * 1.1
                height: stripColumn.height * 1.1
                Column {
                    id: stripColumn
                    spacing: 10
                    padding: 10

                    ListModel {
                        id: stripModel
                        ListElement { columns: 4 }
                        ListElement { columns: 5 }
                        ListElement { columns: 6 }
                        ListElement { columns: 7 }
                        ListElement { columns: 8 }
                        ListElement { columns: 9 }
                        ListElement { columns: 10 }
                    }

                    Repeater {
                        id: stripRep
                        model: stripModel
                        delegate: Row {
                            spacing: 10
                            property alias count: stripSpin.value
                            property alias stripColumns: strip.columnCount
                            SpinBox {
                                id: stripSpin
                                value: 0
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Label {
                                text: strip.rowCount + "x" + strip.columnCount
                                font.pixelSize: 12
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            BasicElectrode {
                                id: strip
                                columnCount: model.columns
                                rowCount: 1
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
            ScrollIndicator.vertical: ScrollIndicator { }
            ScrollIndicator.horizontal: ScrollIndicator { }
        }

        Flickable {
            contentHeight: gridTab.height
            contentWidth: gridTab.width
            boundsBehavior: Flickable.OvershootBounds

            Item {
                id: gridTab
                width: gridColumn.width * 1.1
                height: gridColumn.height * 1.1

                Column {
                    id: gridColumn
                    spacing: 10
                    padding: 10

                    ListModel {
                        id: gridModel
                        ListElement { columns: 4; rows: 4 }
                        ListElement { columns: 5; rows: 5 }
                        ListElement { columns: 6; rows: 5 }
                        ListElement { columns: 7; rows: 3 }
                        ListElement { columns: 8; rows: 5 }
                        ListElement { columns: 9; rows: 2 }
                        ListElement { columns: 10; rows: 3 }
                    }

                    Repeater {
                        id: gridRep
                        model: gridModel
                        delegate: Row {
                            spacing: 10
                            property alias count: gridSpin.value
                            property alias gridRows: grid.rowCount
                            property alias gridColumns: grid.columnCount
                            SpinBox {
                                id: gridSpin
                                value: 0
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Label {
                                text: grid.rowCount + "x" + grid.columnCount
                                font.pixelSize: 12
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            BasicElectrode {
                                id: grid
                                columnCount: model.columns
                                rowCount: model.rows
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
            ScrollIndicator.vertical: ScrollIndicator { }
            ScrollIndicator.horizontal: ScrollIndicator { }
        }
    }

    Button {
        id: addButton
        text: qsTr("Add new type of strip or grid")
        x: (parent.width - width) / 2
        anchors.bottom: parent.bottom
        anchors.right: confirmButton.left
        anchors.margins: 15
    }
    Button {
        id: confirmButton
        text: qsTr("Confirm")
        anchors.bottom: parent.bottom
        anchors.left: addButton.right
        anchors.margins: 15
    }
    Button {
        id: resetButton
        text: qsTr("Reset choice")
        anchors.bottom: parent.bottom
        anchors.left: confirmButton.right
        anchors.margins: 15
    }
}