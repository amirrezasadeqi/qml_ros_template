import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import "controls"

Window {
    id: mainWindow
    width: 1250
    height: 680
    visible: true
    color: "#00000000"
    minimumHeight: 400
    minimumWidth: 800
    title: qsTr("Funny Wing Sketch")

    flags: Qt.Window | Qt.FramelessWindowHint

    property int bgMargin: 10

    QtObject{
        id: internal
        // define convenient functions here
        function maximizeRestore(){
            if(mainWindow.visibility !== 4){
                mainWindow.showMaximized()
            }
            else{
                mainWindow.showNormal()
            }
        }
    }

    onVisibilityChanged: if(mainWindow.visibility === 4){
                             mainWindow.bgMargin = 0
                         }else{
                             mainWindow.bgMargin = 10
                         }

    Rectangle {
        id: bg
        color: "#191d21"
        anchors.fill: parent
        anchors.rightMargin: mainWindow.bgMargin
        anchors.leftMargin: mainWindow.bgMargin
        anchors.bottomMargin: mainWindow.bgMargin
        anchors.topMargin: mainWindow.bgMargin
        z: 1
        Rectangle {
            id: appContainer
            x: 0
            y: 0
            color: "#00ffffff"
            anchors.fill: parent

            Rectangle {
                id: topBar
                height: 70
                color: "#070f18"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                CustomButton{
                    id: toggleBtn
                    width: 70
                    height: 70
                    anchors.left: parent.left
                    anchors.top: parent.top
                    colorPressed: "#0d1b2e"
                    colorMouseOver: "#98a8bb"
                    colorDefault: "#2f67b3"
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                    onClicked: {
                        defDataVisualizationPanelAnimation.running = true
                    }
                }

                Row {
                    id: rowBtn
                    x: 1871
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 8

                    anchors.rightMargin: 0
                    spacing: 7
                    property real customSize: 28

                    CustomButton{
                        id: minimizeBtn
                        width: rowBtn.customSize
                        height: rowBtn.customSize
                        btnRadius: rowBtn.customSize / 2
                        colorPressed: "#191a19"
                        colorMouseOver: "#575a58"
                        colorDefault: "#3f4240"
                        btnIconSource: "../images/svg_images/minimize_icon.svg"
                        onClicked: {
                            mainWindow.showMinimized()
                        }
                    }

                    CustomButton {
                        id: maximizeBtn
                        width: rowBtn.customSize
                        height: rowBtn.customSize
                        btnRadius: rowBtn.customSize / 2
                        colorPressed: "#0d1b2e"
                        colorMouseOver: "#98a8bb"
                        colorDefault: "#2f67b3"
                        btnIconSource: if(mainWindow.visibility !== 4){
                                           "../images/svg_images/maximize_icon.svg"
                                       }else{
                                           "../images/svg_images/restore_icon.svg"
                                       }

                        onClicked: {
                            internal.maximizeRestore()
                        }
                    }

                    CustomButton {
                        id: closeBtn
                        width: rowBtn.customSize
                        height: rowBtn.customSize
                        btnRadius: rowBtn.customSize / 2
                        colorMouseOver: "#cc1b47"
                        colorDefault: "#c24262"
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }
                Rectangle{
                    id: appIconBg
                    width: 50
                    height: width
                    color: iconBgColor
                    radius: width / 2
                    anchors.left: toggleBtn.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    property url switchBlade: "../images/svg_images/switchblade_launch_icon.svg"
                    property color iconBgColor: "#98A8BB"

                    MouseArea{
                        id: appIconMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            appIconBg.switchBlade = "../images/svg_images/switchblade_inair_icon.svg"
                            appIconBg.iconBgColor = "#bbb6a3"
                        }
                        onExited: {
                            appIconBg.switchBlade = "../images/svg_images/switchblade_launch_icon.svg"
                            appIconBg.iconBgColor = "#98A8BB"
                        }
                    }

                    Image {
                        id: appIcon
                        anchors.fill: parent
                        source: appIconBg.switchBlade
                        sourceSize.height: 512
                        sourceSize.width: 512
                        fillMode: Image.PreserveAspectFit

                        ColorOverlay{
                            anchors.fill: parent
                            source: appIcon
                            color: "#675F51"
                        }
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00ffffff"
                    anchors.left: appIconBg.right
                    anchors.right: rowBtn.left
                    anchors.top: parent.top
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.topMargin: 0

                    Label {
                        id: appTitle
                        color: "#c8d4e0"
                        text: qsTr("Funny Wing Sketch App")
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 13
                        font.bold: true
                        font.family: "Times New Roman"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    DragHandler{
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                         }
                    }
                }
            }

            Rectangle {
                id: topContent
                height: parent.height / 2
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                Rectangle {
                    id: defDataVisualizationPanel
                    x: 70
                    y: 0
                    width: parent.width / 2.8
                    color: "#0e1721"
                    anchors.left: topSideBar.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    PropertyAnimation{
                        id: defDataVisualizationPanelAnimation
                        property variant endWidth: (defDataVisualizationPanel.width === 0) ? topContent.width / 2.8 : 0
                        target: defDataVisualizationPanel
                        property: "width"
                        to: endWidth
                        duration: 500
                        easing{
                            type: Easing.InOutQuint
                        }
                    }

                    Loader{
                        id: defaultPage
                        anchors.fill: parent
                        sourceComponent: testComponent
                        visible: true
                        onLoaded: {
                            item.customColor = "blue"
                        }
                    }

                    Loader{
                        id: pathPlotPage
                        anchors.fill: parent
                        sourceComponent: testComponent
                        visible: false
                        onLoaded: {
                            item.customColor = "purple"
                        }
                    }

                    Loader{
                        id: xyPathPlotPage
                        anchors.fill: parent
                        sourceComponent: testComponent
                        visible: false
                        onLoaded: {
                            item.customColor = "yellow"
                        }
                    }

                    Component{
                        id: testComponent
                        Item {
                            id: rootItem
                            property alias customColor: testRect.color
                            Rectangle{
                                id: testRect
                                anchors.fill: parent
                                color: "#ee3e00"
                            }
                        }

                    }
                }

                Rectangle {
                    id: mapContainer
                    x: 514
                    y: 5
                    color: "#00ffffff"
                    anchors.left: defDataVisualizationPanel.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 5
                    anchors.leftMargin: 5
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    MapView{
                        id: map
                        anchors.fill: parent
                    }
                }

                Rectangle {
                    id: topSideBar
                    x: 0
                    y: 0
                    width: 70
                    color: "#070f18"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.leftMargin: 0

                    Column {
                        id: topSideBarBtnColumn
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 50
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                        spacing: 5

                        CustomButton{
                            id: defaultDataBtn
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.75
                            height: 52.5
                            btnRadius: width / 3
                            anchors.horizontalCenterOffset: -3
                            colorPressed: "#0d1b2e"
                            colorMouseOver: "#98a8bb"
                            colorDefault: "#2f67b3"
                            //                            btnIconSource:
                            onClicked: {
                                defaultPage.visible = true
                                pathPlotPage.visible = false
                                xyPathPlotPage.visible = false
                            }
                        }

                        CustomButton{
                            id: pathPlotBtn
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.75
                            height: 52.5
                            btnRadius: width / 3
                            anchors.horizontalCenterOffset: -3
                            colorPressed: "#0d1b2e"
                            colorMouseOver: "#98a8bb"
                            colorDefault: "#2f67b3"
                            //                            btnIconSource:
                            onClicked: {
                                defaultPage.visible = false
                                pathPlotPage.visible = true
                                xyPathPlotPage.visible = false
                            }
                        }

                        CustomButton{
                            id: xypathPlotBtn
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.75
                            height: 52.5
                            btnRadius: width / 3
                            anchors.horizontalCenterOffset: -3
                            colorPressed: "#0d1b2e"
                            colorMouseOver: "#98a8bb"
                            colorDefault: "#2f67b3"
                            //                            btnIconSource:
                            onClicked: {
                                defaultPage.visible = false
                                pathPlotPage.visible = false
                                xyPathPlotPage.visible = true
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: bottomContent
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topContent.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0

                Rectangle {
                    id: bottomSideBar
                    width: 70
                    color: "#070f18"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Column {
                        id: bottomSideBarBtnColumn
                        anchors.fill: parent
                        anchors.topMargin: 10
                        anchors.bottomMargin: 50
                        spacing: 5

                        CustomButton{
                            id: toggleBottomContentBtn
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.75
                            height: 52.5
                            btnRadius: width / 3
                            anchors.horizontalCenterOffset: -3
                            colorPressed: "#0d1b2e"
                            colorMouseOver: "#98a8bb"
                            colorDefault: "#2f67b3"
                            //                            btnIconSource:
                            onClicked: {
                                defaultPage.visible = true
                                pathPlotPage.visible = false
                                xyPathPlotPage.visible = false
                            }
                        }

                        CustomButton{
                            id: navigationPageBtn
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.75
                            height: 52.5
                            btnRadius: width / 3
                            anchors.horizontalCenterOffset: -3
                            colorPressed: "#0d1b2e"
                            colorMouseOver: "#98a8bb"
                            colorDefault: "#2f67b3"
                            //                            btnIconSource:
                            onClicked: {
                                defaultPage.visible = true
                                pathPlotPage.visible = false
                                xyPathPlotPage.visible = false
                            }
                        }

                        CustomButton{
                            id: chartsPageBtn
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.75
                            height: 52.5
                            btnRadius: width / 3
                            anchors.horizontalCenterOffset: -3
                            colorPressed: "#0d1b2e"
                            colorMouseOver: "#98a8bb"
                            colorDefault: "#2f67b3"
                            //                            btnIconSource:
                            onClicked: {
                                defaultPage.visible = true
                                pathPlotPage.visible = false
                                xyPathPlotPage.visible = false
                            }
                        }
                    }
                }

                Rectangle {
                    id: bottomContainer
                    color: "#00ffffff"
                    anchors.left: bottomSideBar.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0

                    Rectangle {
                        id: bottomBar
                        y: 38
                        height: 20
                        color: "#070d13"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                    }

                    Rectangle {
                        id: bottomFoldingRectangle
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: bottomBar.top
                        anchors.bottomMargin: 0

                        Rectangle {
                            id: bottomContentToolBar
                            x: 0
                            y: 0
                            height: 20
                            color: "#070d13"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.topMargin: 0
                        }

                        Rectangle {
                            id: navMonitorContainer
                            x: 0
                            y: 20
                            color: "#00ffffff"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: bottomContentToolBar.bottom
                            anchors.bottom: bottomBar.top
                            anchors.bottomMargin: 0
                            anchors.topMargin: 0
                        }
                    }
                }
            }
        }
    }

    DropShadow{
        id: shadowRect
        color: "#c7191d21"
        anchors.fill: bg
        verticalOffset: 4
        horizontalOffset: 4
        radius: 8
        samples: 20
        source: bg
        z: 0
    }
}

