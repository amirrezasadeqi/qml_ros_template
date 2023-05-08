import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"
import QtQuick.Layouts 1.11

Item {
    id: root
    implicitWidth: 70
    implicitHeight: 500
    Rectangle {
        id: bg
        anchors.fill: parent
        color: "#100b43"

        CustomButton {
            id: toggleBtn
            x: 0
            y: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            onClicked: {
                foldingAnimation.running = true
            }
        }

        Rectangle {
            id: foldingContainer
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: toggleBtn.top
            clip: false
            anchors.bottomMargin: 10
            anchors.topMargin: 50

            Rectangle {
                id: foldingRect
                color: "#003b33c2"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: folderRect.bottom
                anchors.bottom: parent.bottom
                clip: true
                anchors.topMargin: 0

                ColumnLayout {
                    id: columnLayout
                    anchors.fill: parent

                    CustomButton {
                        id: toggleBtn1
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                    }

                    CustomButton {
                        id: toggleBtn2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: toggleBtn1.top
                        anchors.bottomMargin: 0
                    }
                }
            }

            Rectangle {
                id: folderRect
                height: 10
                color: "#00100b43"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                PropertyAnimation {
                    id: foldingAnimation
                    target: folderRect
                    property: "height"
                    duration: 300
                    property variant endHeight: (folderRect.height === 10) ? foldingContainer.height : 10
                    to: endHeight
                    easing {
                        type: Easing.InOutQuint
                    }
                }
            }
        }

    }
}
