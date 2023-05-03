import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: custom_button

    // Custom Properties
    property color color_default: "#c71541"
    property color color_mouse_over: "#c24262"
    property color color_pressed: "#2c0303"
    property url button_icon_source: "../../images/svg_images/menu_icon.svg"
    icon.width: 24
    flat: false
    font.bold: false

    QtObject{
        id: internal // for functions changing the button color

        property var dynamic_color: if(custom_button.down){
                                        color_pressed
                                    }else{
                                        custom_button.hovered ? color_mouse_over : color_default
                                    }
    }


//    text: qsTr("Custom Button")
//    font.family: "Times New Roman"
//    icon.color: "#111010"
    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle{
        id: button_bg
        color: internal.dynamic_color
//        color: "#c71541"
//        radius: 10

        Image {
            id: button_icon
            width: 16
            height: 16
            anchors.verticalCenter: parent.verticalCenter
            source: button_icon_source
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay{
            anchors.fill: button_icon
            source: button_icon
            color: "#ffffff"
            antialiasing: false
        }
    }

//    contentItem: Item {
//        id: button_content
//        Text {
//            id: text_button
//            text: custom_button.text
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            font.bold: true
//            color: "#e1f902"

//        }
//    }
}
