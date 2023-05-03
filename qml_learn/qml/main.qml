import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import "controls"

Window {
    id: main_window
    width: 1250
    height: 680
    opacity: 1
    visible: true
    color: "#00ffffff"
    minimumHeight: 400
    minimumWidth: 800
    title: qsTr("SimpleGUI")

    // removing the standard title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    onVisibilityChanged: if(main_window.visibility == 4){
                             window_status = 1
                             internal.update_max_restore_icon()
                             bottom_resize_edge.visible = false
                             right_resize_edge.visible = false
                         }else{
                             bottom_resize_edge.visible = true
                             right_resize_edge.visible = true
                         }

    // properties
    property int window_status: 0 // 0: normal, 1: maximized
    property url maximize_restore_icon: "../images/svg_images/maximize_icon.svg"


    property alias actual_page: content_stack.currentItem

    // Internal functions
    QtObject{
        id: internal

        function maximize_restore(){
            if(window_status == 0){
                main_window.showMaximized()
                window_status = 1
            }
            else{
                main_window.showNormal()
                window_status = 0
            }
        }

        function update_max_restore_icon(){
            if(window_status == 1){
                maximize_restore_icon = "../images/svg_images/restore_icon.svg"
            }else{
                maximize_restore_icon = "../images/svg_images/maximize_icon.svg"
            }
        }
    }

    Rectangle {
        id: bg
        color: "#161430"
        border.color: "#0f0e23"
        border.width: 10
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        z: 1
        Rectangle {
            id: app_container
            color: "#00ffffff"
            anchors.fill: parent
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: top_bar
                height: 60
                color: "#0e0d23"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                //                Button {
                //                    id: toggle_button
                //                    width: 70
                //                    height: 60
                //                    text: qsTr("Toggle")
                //                    anchors.left: parent.left
                //                    anchors.top: parent.top
                //                    anchors.leftMargin: 0
                //                    anchors.topMargin: 0
                //                }
                CustomButton{
                    id: toggle_button
                    width: 70
                    height: 60
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    onClicked: menu_animation.running = true

                }

                Rectangle {
                    id: top_bar_description
                    y: 37
                    height: 25
                    color: "#232143"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: description_text
                        color: "#ab9ea7"
                        text: qsTr("Application Description")
                        anchors.fill: parent
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Times New Roman"
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                    }

                    Label {
                        id: description_text_right
                        x: -60
                        y: -35
                        color: "#ab9ea7"
                        text: qsTr("|HOME")
                        anchors.left: description_text.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0
                        font.family: "Times New Roman"
                    }
                }

                Rectangle {
                    id: title_bar
                    height: 35
                    color: "#00ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    // TODO: Not fully understood
                    DragHandler{
                        // The tutorial way
                        onActiveChanged: if(active){
                                             main_window.startSystemMove()
                                             window_status = 0
                                             internal.update_max_restore_icon()
                                         }
                        // My way
                        //                        onActiveChanged: main_window.startSystemMove()
                    }

                    Image {
                        id: app_icon
                        width: 35
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/icon_app_top.svg"
                        anchors.leftMargin: 5
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: title_text
                        color: "#efe5eb"
                        text: qsTr("Simple GUI application")
                        anchors.left: app_icon.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.italic: true
                        font.bold: true
                        font.family: "Times New Roman"
                        anchors.leftMargin: 10
                    }
                }

                Row {
                    id: row_buttons
                    x: 1871
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    //                    Button {
                    //                        id: minimize_button
                    //                        width: 35
                    //                        height: 35
                    //                        text: qsTr("Button")
                    //                    }
                    CustomButton{
                        id: minimize_button
                        width: 35
                        height: 35
                        button_icon_source: "../images/svg_images/minimize_icon.svg"
                        onClicked: {
                            main_window.showMinimized()
                            window_status = 0
                            internal.update_max_restore_icon()
                        }
                    }

                    CustomButton {
                        id: maximize_button
                        width: 35
                        height: 35
                        color_default: "#9dee1d"
                        color_mouse_over: "#b6e668"
                        color_pressed: "#26380a"
                        button_icon_source: maximize_restore_icon
                        onClicked: {
                            internal.maximize_restore()
                            internal.update_max_restore_icon()
                        }
                    }

                    CustomButton {
                        id: close_button
                        width: 35
                        height: 35
                        color_mouse_over: "#4f2d88"
                        color_default: "#37058a"
                        color_pressed: "#1c0b38"
                        button_icon_source: "../images/svg_images/close_icon.svg"
                        onClicked: main_window.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: top_bar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: left_menu
                    width: 70
                    color: "#0e0d23"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    PropertyAnimation{
                        id: menu_animation
                        // TODO: search about this warning
                        property variant end_width: (left_menu.width === 70) ? 250 : 70
                        target: left_menu
                        property: "width"
                        to: end_width
                        duration: 500
                        easing{
                            type: Easing.InOutQuint
                        }
                    }

                    Column {
                        id: menu_column
                        anchors.fill: parent
                        anchors.bottomMargin: 90

                        Left_column_button {
                            id: home_button
                            width: left_menu.width
                            text: qsTr("Home")
                            is_active_menu: true
                            onClicked: {
                                home_button.is_active_menu = true
                                settings_button.is_active_menu = false
                                backend.getUsername(true)
                                content_stack.push(Qt.resolvedUrl("pages/HomePage.qml"), {"setUser": testuser})
//                                pages_view.setSource(Qt.resolvedUrl("pages/HomePage.qml"))
                            }
                        }

                        Left_column_button {
                            id: open_button
                            width: left_menu.width
                            text: qsTr("Open")
                            button_icon_source: "../images/svg_images/open_icon.svg"
                            onPressed: {
                                fileOpen.open()
                            }
                            FileDialog{
                                id: fileOpen
                                title: "Please Choose a file to edit"
                                folder: shortcuts.home
                                selectMultiple: false
                                nameFilters: ["Text Files (*.txt)"]
                                onAccepted: {
                                    backend.openFile(fileOpen.fileUrl)
                                }
                            }
                        }

                        Left_column_button {
                            id: save_button
                            width: left_menu.width
                            text: qsTr("Save")
                            button_icon_source: "../images/svg_images/save_icon.svg"
                            onPressed: {
                                fileSave.open()
                            }
                            FileDialog{
                                id: fileSave
                                title: "Save File"
                                folder: shortcuts.home
                                selectMultiple: false
                                selectExisting: false
                                nameFilters: ["Text Files (*.txt)"]
                                onAccepted: {
                                    backend.getTextFile(actual_page.getText)
                                    backend.writeFile(fileSave.fileUrl)
                                }
                            }
                        }
                    }

                    Left_column_button {
                        id: settings_button
                        x: 2
                        y: 2
                        width: left_menu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        button_icon_source: "../images/svg_images/settings_icon.svg"
                        onClicked: {
                            home_button.is_active_menu = false
                            settings_button.is_active_menu = true
                            backend.saveUsername(actual_page.username)
                            content_stack.push(Qt.resolvedUrl("pages/SettingsPage.qml"))
//                            pages_view.setSource(Qt.resolvedUrl("pages/SettingsPage.qml"))

                        }
                    }
                }

                Rectangle {
                    id: content_pages
                    color: "#161430"
                    anchors.left: left_menu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.bottomMargin: 25
                    anchors.leftMargin: 0

                    StackView {
                        id: content_stack
                        anchors.fill: parent
//                        initialItem: Qt.resolvedUrl("pages/HomePage.qml")
                        initialItem: Qt.resolvedUrl("pages/TextEditor.qml")

                    }
//                    Loader{
//                        id: pages_view
//                        anchors.fill: parent
//                        source: Qt.resolvedUrl("pages/HomePage.qml")
//                    }
                }

                Rectangle {
                    id: bottom_bar
                    color: "#232143"
                    anchors.left: left_menu.right
                    anchors.right: parent.right
                    anchors.top: content_pages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0

                    Label {
                        id: bottom_bar_description
                        x: -60
                        y: -993
                        color: "#ab9ea7"
                        text: qsTr("Application Description")
                        anchors.fill: parent
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 30
                        anchors.leftMargin: 10
                        font.family: "Times New Roman"
                    }

                    Image {
                        id: corner_resize_image
                        x: 1155
                        y: 0
                        visible: true
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/resize_icon.svg"
                        antialiasing: false
                        smooth: true
                        anchors.bottomMargin: 0
                        z: 0
                        sourceSize.height: 18
                        sourceSize.width: 18
                    }
                }
            }
        }
    }

    DropShadow{
        anchors.fill: bg
        source: bg
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        //        z: 0
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
    }

    MouseArea {
        id: bottom_resize_edge
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 25
        anchors.leftMargin: 10
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 main_window.startSystemResize(Qt.BottomEdge)
                             }
        }
    }

    MouseArea {
        id: right_resize_edge
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 35
        anchors.bottomMargin: 25
        anchors.rightMargin: 0
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            // below line is not necessary since I commented in and out and nothing happend
            target: null
            onActiveChanged: if(active){
                                 main_window.startSystemResize(Qt.RightEdge)
                             }
        }
    }

    MouseArea {
        id: rb_resize_corner
        width: 25
        height: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        cursorShape: Qt.SizeFDiagCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 main_window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                             }
        }
    }
    property string testuser
    Connections {
        target: backend

        function onReadText(text){
            actual_page.setText = text
        }

        function onSetUser(user){
            testuser = user
            console.log(user)
        }
    }

}
