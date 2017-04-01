import QtQuick 2.7
import QtQuick.XmlListModel 2.0

Item {
    property alias trackModel: xmlModel

    XmlListModel {
        id: xmlModel
        source: "qrc:/xmls/sample.gdf.mont"
        query: "/document/montageTable/montage/trackTable/track"

        XmlRole { name: "label"; query: "@label/string()" }
//        XmlRole { name: "code"; query: "code/string()" }
    }
}
