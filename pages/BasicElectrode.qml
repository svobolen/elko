import QtQuick 2.6
import QtQuick.Controls 2.0

Item {
    id: root
    property int columnCount
    property int rowCount
    property int size: 20
    property bool droppingEnabled: false
    property string color: "white"
    property ListModel linkedTracks: ListModel { }  //ListElement {electrodeNumber: defaultName, wave: name, spikes: 0})

    property alias rowRep: rowRep

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
                            property int columnCount: root.columnCount  //for console logs (signal link)
                            property int rowCount: root.rowCount        //for console logs (signal link)
                            property string trackName: ""
                            property bool alreadyContainsDrag: false
                            property int trackId: -1
                            property bool nameToChange: true
                            property alias colorFill: dropRectangle.color
                            property int spikes: 0

                            width: size; height: size
                            enabled: droppingEnabled

                            Rectangle {
                                id: dropRectangle
                                opacity: 0.8
                                width: size; height: size; radius: size/2
                                border.color: "grey"
                                color: "white"

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
                                        linkedTracks.append( { electrodeNumber: defaultName, wave: name, spikes: 0})
                                    }
                                }
                            }

                            onSpikesChanged: {
                                console.log(linkedTracks.count + " " + spikes, defaultName)
                                for (var i = 0; i < linkedTracks.count; i++) {
                                    if (linkedTracks.get(i).electrodeNumber === defaultName) {
                                        linkedTracks.get(i).spikes = spikes
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
                                            spikes = linkedTracks.get(i).spikes
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
}

