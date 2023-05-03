import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: left_column_button
    text: "Left Menu Text"

    // Custom Properties
    property color color_default: "#c71541"
    property color color_mouse_over: "#c24262"
    property color color_pressed: "#2c0303"
    property url button_icon_source: "../../images/svg_images/home_icon.svg"
    property int icon_width: 18
    property int icon_height: 18
    property color active_menu_color: "#c6ed2e"
    property color active_menu_color_right: "#161430"
    property bool is_active_menu: false

    QtObject{
        id: internal // for functions changing the button color

        property var dynamic_color: if(left_column_button.down){
                                        color_pressed
                                    }else{
                                        left_column_button.hovered ? color_mouse_over : color_default
                                    }
    }


    implicitWidth: 250
    implicitHeight: 60

    background: Rectangle{
        id: button_bg
        color: internal.dynamic_color

        Rectangle {
            id: left_menu_active_sign
            width: 3
            color: active_menu_color
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            visible: is_active_menu
        }

        Rectangle {
            id: left_menu_active_right
            width: 5
            color: active_menu_color_right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            visible: is_active_menu
        }
    }

    contentItem: Item {
        anchors.fill: parent
        id: left_column_button_content
        Image {
            id: left_column_button_icon
            sourceSize.height: icon_height
            sourceSize.width: icon_width
            width: icon_width
            height: icon_height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: button_icon_source
            anchors.leftMargin: 26
            fillMode: Image.PreserveAspectFit
            antialiasing: true
        }

        ColorOverlay{
            anchors.fill: left_column_button_icon
            source: left_column_button_icon
            color: "#ffffff"
            width: icon.width
            height: icon.height
            antialiasing: true
        }

        Text {
            id: left_column_button_text
            text: left_column_button.text
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: left_column_button_icon.right
            font.family: "Times New Roman"
            anchors.leftMargin: 40
        }


    }



}
