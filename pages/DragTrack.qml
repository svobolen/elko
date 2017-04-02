import QtQuick 2.7

DragTrackForm {

    mouseArea.onReleased: {
        mouseArea.parent = (tile.Drag.target === null || tile.Drag.target.alreadyContainsDrag) ?  root : tile.Drag.target
        if (tile.Drag.target !== null) {
            tile.Drag.target.alreadyContainsDrag = true
            tile.Drag.target.name = trackName
            tile.Drag.target.trackName = trackName
        }
    }

    mouseArea.onPressed: {
        if (mouseArea.parent !== root) {
            mouseArea.parent.alreadyContainsDrag = false
            mouseArea.parent.name = mouseArea.parent.defaultName
            mouseArea.parent.trackName = ""
        }
    }
    tile.states: State {
        when: mouseArea.drag.active
        ParentChange {
            target: tile
            parent: root
        }
        //aby se to pohybovalo s mysi
        AnchorChanges {
            target: tile
            anchors.verticalCenter: undefined
            anchors.horizontalCenter: undefined
        }
    }
}
