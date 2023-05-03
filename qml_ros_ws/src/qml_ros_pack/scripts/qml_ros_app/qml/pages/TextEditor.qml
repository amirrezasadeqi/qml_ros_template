import QtQuick 2.15
import QtQuick.Controls 2.15

Item {

    property string getText: editor_text_area.text
    property string setText: ""
    Rectangle{
        id: text_editor_bg
        anchors.fill: parent
        color: "#0d0933"

        Flickable {
            id: editor_flick
            anchors.fill: parent
            clip: true


            TextArea.flickable: TextArea{
                id: editor_text_area
                padding: 10
                wrapMode: Text.WordWrap
                textFormat: Text.AutoText
                selectByMouse: true
                selectedTextColor: "#ffffff"
                selectionColor: "#ff007f"
                color: "#ffffff"
                font.pointSize: 12
                text: setText
            }

            ScrollBar.vertical: ScrollBar{}
        }
    }
}
