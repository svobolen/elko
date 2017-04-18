import QtQuick 2.0
import QtQuick.Controls 2.0

MenuItem {
    id: control
    width: 600
    height: 150

    contentItem: Text {
        text: control.text
        font.pixelSize: 30
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        anchors.fill: parent
        color: control.down ? "aliceblue" : "whitesmoke"
        border.color: control.down ? "skyblue" : "grey"
        border.width: 1
        radius: 2
    }
}
