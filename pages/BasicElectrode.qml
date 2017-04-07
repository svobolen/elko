import QtQuick 2.6
import QtQuick.Controls 2.0

Item {
    id: root
    property int columnCount
    property int rowCount
    property int size: 20
    property bool droppingEnabled: false
    property string color: "white"
    property ListModel linkedTracks: ListModel { }

    width: columnCount*size; height: rowCount*size;

    Rectangle {
        id: electrode
        width: columnCount*size; height: rowCount*size; radius: size/2
        opacity: 0.8
        border.color: "grey"

        Column {
            id: column
            Repeater {
                id: rowRep
                model: rowCount
                Row {
                    id: row
                    property alias colRep: columnRep
                    Repeater {
                        id: columnRep
                        model: columnCount

                        DropArea {
                            id: dropArea
                            readonly property int defaultName: columnCount * ( rowCount - row.getIndex() ) + ( modelData + 1 )
                            property alias name: electrodeText.text
                            property string trackName: ""
                            property bool alreadyContainsDrag: false
                            property var signalData
                            property bool nameToChange: true

                            width: size; height: size
                            enabled: droppingEnabled

                            Rectangle {
                                id: dropRectangle
                                opacity: 0.8
                                width: size; height: size; radius: size/2
                                border.color: "grey"

                                states: [
                                    State {
                                        when: dropArea.containsDrag && dropArea.alreadyContainsDrag === false
                                        PropertyChanges {
                                            target: dropRectangle
                                            color: "green"
                                        }
                                    },
                                    State {
                                        when: dropArea.containsDrag && dropArea.alreadyContainsDrag === true
                                        PropertyChanges {
                                            target: dropRectangle
                                            color: "red"
                                        }
                                    }
                                ]
                                Text {
                                    id: electrodeText
                                    text: dropArea.defaultName
                                    anchors.fill: parent
                                    horizontalAlignment:Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }

                            onTrackNameChanged: {
                                if (nameToChange) {
                                    if (trackName === "") {
                                        for (var i = 0; i < linkedTracks.count; i++) {
                                            if (linkedTracks.get(i).electrodeNumber === defaultName) {
                                                linkedTracks.remove(i)
                                                break
                                            }
                                        }
                                    } else {
                                        linkedTracks.append( { electrodeNumber: defaultName, wave: name})
                                    }
                                }
                            }

                            Component.onCompleted: {
                                if (linkedTracks !== null) {
                                    nameToChange = false
                                    for (var i = 0; i < linkedTracks.count; i++) {
                                        if (linkedTracks.get(i).electrodeNumber === defaultName) {
                                            name = linkedTracks.get(i).wave
                                            trackName = linkedTracks.get(i).wave
                                            electrodeText.font.bold = true
                                        }
                                    }
                                }
                                nameToChange = true
                            }
                        }
                    }
                    Rectangle {
                        id: tail
                        opacity: 0.8
                        width: size + 5; height: 6; radius: 3
                        y: size / 2 - height / 2
                        border.color: "grey"
                        color: root.color
                    }
                    function getIndex() {
                        return index + 1
                    }
                }
            }
        }
    }

    function changeNames(comboBoxValue) {
        for (var k = 0; k < rowCount; k++) {
            for (var l = 0; l < columnCount; l++) {
                switch (comboBoxValue) {
                case 0: // only default name
                    rowRep.itemAt(k).colRep.itemAt(l).name = rowRep.itemAt(k).colRep.itemAt(l).defaultName;
                    break;
                case 1: // only wave names (non-linked are empty)
                    rowRep.itemAt(k).colRep.itemAt(l).name = rowRep.itemAt(k).colRep.itemAt(l).trackName
                    break;
                default: // wave names, non-linked default name
                    rowRep.itemAt(k).colRep.itemAt(l).name =
                            (rowRep.itemAt(k).colRep.itemAt(l).trackName === "") ?
                                rowRep.itemAt(k).colRep.itemAt(l).defaultName : rowRep.itemAt(k).colRep.itemAt(l).trackName
                    break;
                }
            }
        }
    }
}

