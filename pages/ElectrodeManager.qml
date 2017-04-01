import QtQuick 2.7
import QtQuick.Controls 2.0

ElectrodeManagerForm {

    confirmB.onClicked: {
        var chosenElecs = getChosenElectrodes()
        if (chosenElecs.count === 0) {
            console.log("User did not choose any electrode.")
        } else {
            listView.currentIndex = 3   //index v listview
            titleLabel.text = "Link Signal with Electrode"
            stackView.push( "qrc:/pages/ElectrodeSignalLink.qml", {"electrodes": chosenElecs, "name": "Link Signal with Electrode"} )
        }
    }
    addB.onClicked: addDialog.open()
    resetB.onClicked: resetChoice()

    function resetChoice() {
        // reset strips choice
        for (var i = 0; i < stripR.count; i++) {
            stripR.itemAt(i).count = 0
        }
        //reset grids choice
        for (var j = 0; j < gridR.count; j++) {
            gridR.itemAt(j).count = 0
        }
    }

    function getChosenElectrodes() {
        console.log("User chose following electrodes: ")
        chosenElectrodesList.clear()

        for (var i = 0; i < stripR.count; i++) {
            if (stripR.itemAt(i).count !== 0) {
                for (var k = 0; k < stripR.itemAt(i).count; k++) {
                    chosenElectrodesList.append({ columns: stripR.itemAt(i).stripColumns, rows: 1 })
                }
                console.log(stripR.itemAt(i).count + "x strip 1x" + stripR.itemAt(i).stripColumns)
            }
        }
        for (var j = 0; j < gridR.count; j++) {
            if (gridR.itemAt(j).count !== 0) {
                for (var l = 0; l < gridR.itemAt(j).count; l++) {
                    chosenElectrodesList.append({ columns: gridR.itemAt(j).gridColumns, rows: gridR.itemAt(j).gridRows })
                }
                console.log(gridR.itemAt(j).count + "x grid " + gridR.itemAt(j).gridRows + "x" + gridR.itemAt(j).gridColumns)
            }
        }
        return chosenElectrodesList
    }

    ListModel {
        id: chosenElectrodesList
        //        ListElement { columns: 0; rows: 0}
    }
    ElectrodeAddingDialog {id: addDialog}
}


