import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.15
import QtQuick.Controls.Material 2.15
import "../controls"

Item {
//    width: 1180
//    height: 595
//    anchors.fill: parent
    property string username: username_text_field.text
    property string setUser
    Rectangle {
        id: content_bg
        color: "#161149"
        anchors.fill: parent

        Rectangle {
            id: top_rectangle
            height: 82
            color: "#2f2c53"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 40
            anchors.leftMargin: 40
            anchors.topMargin: 40

            GridLayout {
                anchors.fill: parent
                anchors.rightMargin: 23
                anchors.leftMargin: 22
                rows: 1
                columns: 3

                CustomTextField{
                    id: username_text_field
                    width: 500
                    placeholderTextColor: "#deddf2"
                    padding: 10
                    topPadding: 8
                    leftPadding: 12
                    Layout.margins: 10
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    Layout.preferredWidth: 600
                    text: setUser
                    Keys.onReturnPressed: {
                        backend.welcome_text(username_text_field.text)
                    }
                    Keys.onEnterPressed: {
                        backend.welcome_text(username_text_field.text)
                    }

                }

                Submit_button{
                    id: submit_button
                    width: 400
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    Layout.preferredWidth: 300
                    onClicked: {
                        backend.welcome_text(username_text_field.text)
                    }
                }

                Switch {
                    // TODO: customize the switch to have nice colors
                    id: test_switch
//                    Material.accent: Material.Blue
                    width: 80
                    text: qsTr("")
                    checked: true
                    display: AbstractButton.IconOnly
                    wheelEnabled: false
                    Layout.leftMargin: 0
                    Layout.fillHeight: false
                    Layout.preferredWidth: -1
                    Layout.fillWidth: true

                    onToggled: {
                        backend.showHideRectangle(test_switch.checked)
                    }
                }
            }

        }

        Rectangle {
            id: bottom_rectangle
            color: "#0d0933"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: top_rectangle.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
            anchors.rightMargin: 40
            anchors.leftMargin: 40
            anchors.bottomMargin: 40

            Label {
                id: welcom_label
                x: 509
                color: "#e2e0f4"
//                text: qsTr("Welcome")
                text: if(setUser === ""){
                          qsTr("Welcome")
                      }else{
                          qsTr("Welcome" + ", " + setUser)
                      }

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.topMargin: 30
                font.bold: true
                font.pointSize: 20
                font.family: "Tahoma"
            }

            Label {
                id: date_label
                x: 509
                color: "#00f5e2"
                text: qsTr("Date")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: welcom_label.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.topMargin: 10
                font.pointSize: 16
                font.bold: true
                font.family: "Tahoma"
            }

            ScrollView {
                id: home_page_scroll_view
                // This is because if the text is too long, it will not go outside of the
                // scroll view frame and we can scroll down to see the rest of the text.
                clip: true
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: date_label.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                anchors.topMargin: 20

                Text {
                    id: home_page_scroll_view_text
                    color: "#e8e6f6"
                    text: "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n<html><head><meta name=\"qrichtext\" content=\"1\" /><meta charset=\"utf-8\" /><style type=\"text/css\">\np, li { white-space: pre-wrap; }\nhr { height: 1px; border-width: 0; }\nli.unchecked::marker { content: \"\\2610\"; }\nli.checked::marker { content: \"\\2612\"; }\n</style></head><body style=\" font-family:'Fira Sans Semi-Light'; font-size:10pt; font-weight:400; font-style:normal;\">\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:600;\">GNU GENERAL PUBLIC LICENSE</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt;\">Version 3, 29 June 2007</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'MS Shell Dlg 2'; font-size:8.25pt;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt;\">Copyright (c) 2020 </span><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:600;\">Wanderson M. Pimenta</span></p>\n<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:600;\"><br /></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:600; color:#55aaff;\">Attention</span><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt;\">: this project was created with the Open Souce tools from Qt Company,</span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt;\">this project can be used for studies or personal non-commercial projects. </span></p>\n<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:600;\">If you are going to use it for </span><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:600; color:#55aaff;\">commercial use</span><span style=\" font-family:'MS Shell Dlg 2'; font-size:8.25pt; font-weight:600;\">, you need to purchase a license at &quot;https://www.qt.io&quot;.</span></p></body></html>"
                    anchors.fill: parent
                    font.bold: true
                    font.family: "Tahoma"
                    font.pointSize: 22
                    textFormat: Text.RichText
                }
            }
        }
    }

    Connections {
        target: backend

        function onSetName(name){
            welcom_label.text = name
        }

        function onPrintDate(date){
            date_label.text = date
        }

        function onIsVisible(visible){
            bottom_rectangle.visible = visible
        }
    }

}
