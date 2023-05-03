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
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 20
            font.pointSize: 24
            font.family: "Times New Roman"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: map_page_container
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: label.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 10

            Loader {
                id: map_loader
                anchors.fill: parent
                source: "../MapTest.qml"
            }
        }
    }
}
