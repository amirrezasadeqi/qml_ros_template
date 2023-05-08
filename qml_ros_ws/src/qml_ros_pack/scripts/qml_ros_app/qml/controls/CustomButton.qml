import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: customBtn

    // Custom Properties
    property color colorDefault: "#c71541"
    property color colorMouseOver: "#c24262"
    property color colorPressed: "#2c0303"
    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property real btnRadius: 0
    icon.width: 24
    flat: false
    font.bold: false

    QtObject{
        id: internal // for functions changing the button color

        property var dynamicColor: if(customBtn.down){
                                        colorPressed
                                    }else{
                                        customBtn.hovered ? colorMouseOver : colorDefault
                                    }
    }

    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle{
        id: btnBg
        color: internal.dynamicColor
        radius: customBtn.btnRadius
        Image {
            id: btnIcon
            width: 16
            height: 16
            anchors.verticalCenter: parent.verticalCenter
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay{
            anchors.fill: btnIcon
            source: btnIcon
            color: "#ffffff"
            antialiasing: false
        }
    }
}
