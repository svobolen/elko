import QtQuick 2.7

ImageManagerForm {

    a.addButton.onClicked: {
        swipe.addItem()
        swipe.currentIndex++
        console.log("Page " + swipe.currentIndex + " was added to swipe. (Counting from zero.)")
    }

    a.deleteButton.onClicked: {
        if(swipe.count !== 2) {
            console.log("Page " + swipe.currentIndex + " was removed from swipe. (Counting from zero.)")
            swipe.removeItem(swipe.currentIndex)
        } else {
            console.log("There have to be at least 2 pages in swipe.")
        }
    }
    a.confirmButton.onClicked: {
        var checkedImages = getCheckedImages()
        console.log("User chose " + checkedImages.length + " image(s): " + checkedImages.toString())
        window.images = checkedImages
        window.changePage("Electrode Manager", "qrc:/pages/ElectrodeManager.qml", 2)
    }

    a.resetButton.onClicked: { resetChoice() }

    function resetChoice() {
        for (var k = 0; k < swipe.count; k++) {
            for (var i = 0; i < swipe.itemAt(k).images.count; i++) {
                swipe.itemAt(k).images.itemAt(i).imgChecked = false
            }
        }
    }

    function getCheckedImages() {
        var sourceArray = []
        for (var k = 0; k < swipe.count; k++) {
            for (var i = 0; i < swipe.itemAt(k).images.count; i++) {
                if (swipe.itemAt(k).images.itemAt(i).imgChecked) {
                    sourceArray.push(swipe.itemAt(k).images.itemAt(i).sourceImg)
                }
            }
        }
        return sourceArray
    }

    Connections {
        target: swipe
        onCurrentIndexChanged: console.log(swipe.count)
    }


    Loader {
        id: loader

    }
}
