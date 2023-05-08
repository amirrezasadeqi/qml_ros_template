import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"

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
            onClicked: {
                foldingAnimation.running = true
            }
        }

        Rectangle {
            id: foldingRectangle
            color: "#e512e4"
            height: 180
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: toggleBtn.bottom
            clip: true
            anchors.topMargin: 10
//            rotation: 180
            PropertyAnimation {
                id: foldingAnimation
                target: foldingRectangle
                property variant endHeight: (foldingRectangle.height === 0) ? 180 : 0
                duration: 500
                property: "height"
                to: endHeight
                easing{
                    type: Easing.InOutQuint
                }
            }

            Column {
                id: btnColumn
                anchors.fill: parent

                CustomButton {
                    id: toggleBtn1
                }

                CustomButton {
                    id: toggleBtn2
                }
            }

        }

    }
}
