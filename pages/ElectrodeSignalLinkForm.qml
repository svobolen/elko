import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls 2.0

Controls.SplitView {
    property var name
    property var electrodes
    property int maxSpikes: 0
    property int minSpikes: 0

    property alias elecRep: elecRep
    property alias dragRep: dragRep
    property alias xmlModels: xmlModels

    Flickable {
        contentHeight:source.height + 150
        contentWidth: source.width
        Layout.minimumWidth: 1.5 * source.width
        Layout.maximumWidth: 1.5 * source.width
        boundsBehavior: Flickable.OvershootBounds

//        Rectangle {
//            color: "white"
//            width: parent.parent.width
//            height: source.height + 150

            Column {
                id: source
                width: 100
                spacing: 30
                padding: 30
                Repeater {
                    id: dragRep
                    model: xmlModels.trackModel
                    DragTrack {
                        trackName: label.replace(/\s+/g, '') //without whitespaces
                        trackId: index
                    }
                }
            }

            XmlModels {id: xmlModels }
//        }
        ScrollIndicator.vertical: ScrollIndicator { }
    }

    Flickable {
        contentHeight: destination.height + 300
        contentWidth: destination.width + 150
        width: 4/5 * parent.width
        Layout.minimumWidth: 2/3 * parent.width
        boundsBehavior: Flickable.OvershootBounds

        Column {
            id: destination
            spacing: 30
            padding: 30

            Repeater {
                id: elecRep
                model: electrodes
                Row {
                    property alias bElectrode: bElectrode
                    spacing: 20
                    Label {
                        text: rows + "x" + columns
                        font.pixelSize: 40
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    BasicElectrode {
                        id: bElectrode
                        size: 80
                        columnCount: columns
                        rowCount: rows
                        droppingEnabled: true
                    }
                }
            }
        }


        ScrollIndicator.vertical: ScrollIndicator { }
        ScrollIndicator.horizontal: ScrollIndicator { }
    }
}
