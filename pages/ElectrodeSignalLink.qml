import QtQuick 2.7


ElectrodeSignalLinkForm {

    confirmButton.onClicked: {
        readXml()
        fillLinkedElectrodesList()
        listView.currentIndex = 3   //index v listview
        titleLabel.text = "Electrode Placement"
        stackView.push( "qrc:/pages/ElectrodePlacement.qml", {"electrodes": linkedElectrodesList, "images": window.images,"name": "Electrode Placement",
                       "minSpikes": minSpikes, "maxSpikes": maxSpikes} )
    }

    ListModel { id: linkedElectrodesList } //ListElement { rows: rowCount, columns: columnCount, links: links}

    function fillLinkedElectrodesList() {
        linkedElectrodesList.clear()

        for (var i = 0; i < elecRep.count; i++) {
            linkedElectrodesList.append({ rows: elecRep.itemAt(i).bElectrode.rowCount,
                                            columns: elecRep.itemAt(i).bElectrode.columnCount,
                                            links: elecRep.itemAt(i).bElectrode.linkedTracks})
        }
        return linkedElectrodesList
    }

    function readXml() {
        var spikes, min, max = 0

        for (var i = 0; i < xmlModels.trackModel.count; i++) {
            spikes = 0
            dragRep.itemAt(i).spikes = 0    //////////////
            for (var j = 0; j < xmlModels.eventModel.count; j++) {
                if (i == xmlModels.eventModel.get(j).channel) {
                    spikes++
                }
            }
            if (i === 0) { min = spikes }
            if (spikes < min) { min = spikes }
            if (spikes > max) { max = spikes }

            dragRep.itemAt(i).spikes = spikes
            console.log(xmlModels.trackModel.get(i).label.replace(/\s+/g, '') + " (" + i + ") has " + spikes + " spike(s).")
        }
        console.log("Minimum is " + min + " spike(s).")
        console.log("Maximum is " + max + " spikes.")
        minSpikes = min
        maxSpikes = max
    }
}

