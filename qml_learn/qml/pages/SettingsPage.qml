import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
//    width: 1180
//    height: 595
//    anchors.fill: parent

    Rectangle {
        id: content_bg
        color: "#062812"
        anchors.fill: parent

        Label {
            id: label
            color: "#ecf2f7"
            text: qsTr("Settings Page")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 24
            font.family: "Times New Roman"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
