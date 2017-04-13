import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls 2.0

Controls.SplitView {
    property var name
    property var electrodes
    property int maxSpikes: 0
    property int minSpikes: 0

    property alias confirmButton: confirmButton
    property alias elecRep: elecRep
    property alias dragRep: dragRep
    property alias xmlModels: xmlModels

    Flickable {
        contentHeight: destItem.height
        contentWidth: destItem.width
        width: 4/5 * parent.width
        Layout.minimumWidth: 1/2 * parent.width + confirmButton.width / 2
        boundsBehavior: Flickable.OvershootBounds

        Item {
            id: destItem
            width: destination.width + 150
            height: destination.height + 300

            Column {
                id: destination
                spacing: 10
                padding: 10

                Repeater {
                    id: elecRep
                    model: electrodes
                    Row {
                        property alias bElectrode: bElectrode
                        spacing: 10
                        Label {
                            text: rows + "x" + columns
                            font.pixelSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        BasicElectrode {
                            id: bElectrode
                            size: 40
                            columnCount: columns
                            rowCount: rows
                            droppingEnabled: true
                        }
                    }
                }
            }
            Button {
                id: confirmButton
                text: qsTr("Confirm")
                x: (window.width - width)/2
                anchors.top: destination.bottom
                anchors.margins: 20
            }
        }
        ScrollIndicator.vertical: ScrollIndicator { }
        ScrollIndicator.horizontal: ScrollIndicator { }
    }
    Flickable {
        contentHeight: sourceItem.height
        contentWidth: sourceItem.width
        Layout.minimumWidth: 50
        Layout.maximumWidth: 1/2 * parent.width - confirmButton.width / 2
        boundsBehavior: Flickable.OvershootBounds

        Rectangle {
            color: "white"
            width: parent.parent.width
            height: sourceItem.height

            Item {
                id: sourceItem
                width: source.width
                height: source.height + 150
                Column {
                    id: source
                    width: 50
                    Layout.minimumWidth: 50
                    spacing: 10
                    padding: 10
                    Repeater {
                        id: dragRep
                        model: xmlModels.trackModel
                        DragTrack {
                            size: 40
                            trackName: label.replace(/\s+/g, '') //without whitespaces
                            trackId: index
                        }
                    }
                }
            }
            XmlModels {id: xmlModels }
        }
        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
