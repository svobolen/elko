import QtQuick 2.4

ElectrodeAddingDialogForm {
    okB.onClicked: {
        addElectrode(columnSpinBox.value, rowSpinBox.value)
        addDialog.close()
    }
    cancelB.onClicked: addDialog.close()



    function addElectrode(columnCount, rowCount) {

        //for strips rows = 1
        if (columnCount === 1 && rowCount !== 1) {
            columnCount = rowCount
            rowCount = 1
        }
        if (rowCount === 1) {
            //create strip
            stripM.append({ columns: columnCount })
            tabBar.currentIndex = 0
        } else {
            //create grid
            gridM.append({ columns: columnCount, rows: rowCount })
            tabBar.currentIndex = 1
        }
        console.log("New electrode " + rowCount + "x" + columnCount + " was added.")
    }
}
