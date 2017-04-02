import QtQuick 2.7


ElectrodeSignalLinkForm {

    confirmButton.onClicked: {
        fillLinkedElectrodesList()
        console.log("a")
        listView.currentIndex = 3   //index v listview
        console.log("b")
        titleLabel.text = "Electrode Placement"
        console.log("c")
        stackView.push( "qrc:/pages/ElectrodePlacement.qml", {"electrodes": linkedElectrodesList, "images": window.images,"name": "Electrode Placement"} )
        console.log("d")
    }

    ListModel { id: linkedElectrodesList } //ListElement { rows: rowCount, columns: columnCount, links: links}

    function fillLinkedElectrodesList() {
        linkedElectrodesList.clear()

        for (var i = 0; i < elecRep.count; i++) {
            linkedElectrodesList.append({ rows: elecRep.itemAt(i).bElectrode.rowCount, columns: elecRep.itemAt(i).bElectrode.columnCount, links: elecRep.itemAt(i).bElectrode.links})
            console.log(i)
        }
        return linkedElectrodesList
    }
}
