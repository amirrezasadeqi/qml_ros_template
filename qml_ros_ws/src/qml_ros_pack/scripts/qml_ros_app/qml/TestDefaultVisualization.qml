import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    implicitWidth: 1000
    implicitHeight: 500

    Rectangle {
        id: bg
        color: "#c72424"
        anchors.fill: parent

        Rectangle {
            id: appContainer
            color: "#00ffffff"
            anchors.fill: parent

            Rectangle {
                id: buttonBar
                width: 100
                color: "#33588c"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0

                Button {
                    id: dataBtn
                    y: 69
                    text: qsTr("data")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        formLoader2.visible = false
                        formLoader1.visible = true
                    }
                }

                Button {
                    id: plotBtn
                    y: 166
                    text: qsTr("3d plot")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        formLoader2.visible = true
                        formLoader1.visible = false
                    }
                }
            }

            Rectangle {
                id: viewContainer
                color: "#00ffffff"
                anchors.left: buttonBar.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0

                Loader{
                    id: formLoader1
                    sourceComponent: testField
                    anchors.centerIn: parent
                }

                Loader{
                    id: formLoader2
                    sourceComponent: testField2
                    anchors.centerIn: parent
                    visible: false
                }

            }

            Component {
                id: testField
                TextField{
                    id: testTextField
                    placeholderText: qsTr("Type something first")
                }
            }

            Component {
                id: testField2
                TextField{
                    id: testTextField
                    placeholderText: qsTr("Type something second")
                }
            }
        }
    }


}
