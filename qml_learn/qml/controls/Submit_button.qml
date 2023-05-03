import QtQuick 2.15
import QtQuick.Controls 2.15

Button{
    id: submit_button

    property color default_color: "#6bcad7"
    property color hovered_color: "#21c5db"
    property color pressed_color: "#054952"

    implicitHeight: 50
    implicitWidth: 300

    QtObject{
        id: internal

        property var dynamic_color: if(submit_button.down){
                                        pressed_color
                                    }else{
                                        submit_button.hovered ? hovered_color : default_color
                                    }
    }

    background: Rectangle{
        id: button_bg
        color: internal.dynamic_color
        radius: 10
    }

    contentItem: Item {
        id: button_content
        anchors.fill: parent
        Text {
            id: button_text
            text: qsTr("Submit Name")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pointSize: 12
            font.family: "Tahoma"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


}
