import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15
import "controls"
import "pages"

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
    property bool defaultVisualizationPanelOpened: true
    property bool navMonitorPanelOpened: true

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

    onVisibilityChanged: {
        if(mainWindow.visibility === 4){
            mainWindow.bgMargin = 0
        }else{
            mainWindow.bgMargin = 10
        }
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
                        defaultVisualizerPanelAnimation.running = true
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
                id: sideBarContainer
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: sideBar
                    width: 70
                    color: "#070f18"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Rectangle {
                        id: defBtnContent
                        height: parent.height / 2
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top

                        Column {
                            id: defBtnColumn
                            x: 0
                            y: 10
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 0
                            anchors.bottomMargin: 50
                            anchors.rightMargin: 0
                            anchors.topMargin: 10
                            spacing: 5

                            CustomButton {
                                id: defDataVisualBtn
                                width: parent.width * 0.75
                                height: 52.5
                                colorPressed: "#0d1b2e"
                                anchors.horizontalCenter: parent.horizontalCenter
                                btnRadius: width / 3
                                onClicked: {
                                    defaultPage.visible = true
                                    pathPlotPage.visible = false
                                    xyPathPlotPage.visible = false
                                }
                                anchors.horizontalCenterOffset: -3
                                colorDefault: "#2f67b3"
                                colorMouseOver: "#98a8bb"
                            }

                            CustomButton {
                                id: pathPlotBtn
                                width: parent.width * 0.75
                                height: 52.5
                                colorPressed: "#0d1b2e"
                                anchors.horizontalCenter: parent.horizontalCenter
                                btnRadius: width / 3
                                onClicked: {
                                    defaultPage.visible = false
                                    pathPlotPage.visible = true
                                    xyPathPlotPage.visible = false
                                }
                                anchors.horizontalCenterOffset: -3
                                colorDefault: "#2f67b3"
                                colorMouseOver: "#98a8bb"
                            }

                            CustomButton {
                                id: xyPathPlotBtn
                                width: parent.width * 0.75
                                height: 52.5
                                colorPressed: "#0d1b2e"
                                anchors.horizontalCenter: parent.horizontalCenter
                                btnRadius: width / 3
                                onClicked: {
                                    defaultPage.visible = false
                                    pathPlotPage.visible = false
                                    xyPathPlotPage.visible = true
                                }
                                anchors.horizontalCenterOffset: -3
                                colorDefault: "#2f67b3"
                                colorMouseOver: "#98a8bb"
                            }
                        }
                    }

                    Rectangle {
                        id: navMonitorBtnContent
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: defBtnContent.bottom
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 0

                        CustomButton {
                            id: navMonitorToggleBtn
                            x: 0
                            y: 0
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            onClicked: {
                                bottomContainerFoldAnimation.running = true
                            }
                        }

                        Rectangle {
                            id: foldingContainer
                            color: "#00ffffff"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: navMonitorToggleBtn.top
                            anchors.bottomMargin: 5

                            Rectangle {
                                id: foldingRect
                                color: "#003b33c2"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: folderRect.bottom
                                anchors.bottom: parent.bottom
                                clip: true
                                anchors.topMargin: 0

                                Column {
                                    id: navMonitorBtnColumn
                                    anchors.fill: parent
                                    anchors.bottomMargin: 0
                                    spacing: 5
                                    CustomButton {
                                        id: navDashboardBtn
                                        width: parent.width * 0.75
                                        height: 52.5
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 5
                                        btnRadius: width / 3
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.horizontalCenterOffset: -3
                                        colorPressed: "#0d1b2e"
                                        colorDefault: "#2f67b3"
                                        colorMouseOver: "#98a8bb"
                                        onClicked: {
                                            navMonitorDashLoader.visible = true
                                            chartMonitorLoader.visible = false
                                        }
                                    }
                                    CustomButton {
                                        id: chartMonitorBtn
                                        width: parent.width * 0.75
                                        height: 52.5
                                        anchors.bottom: navDashboardBtn.top
                                        anchors.bottomMargin: 3
                                        btnRadius: width / 3
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.horizontalCenterOffset: -3
                                        colorPressed: "#0d1b2e"
                                        colorDefault: "#2f67b3"
                                        colorMouseOver: "#98a8bb"
                                        onClicked: {
                                            navMonitorDashLoader.visible = false
                                            chartMonitorLoader.visible = true
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                id: folderRect
                                height: (mainWindow.navMonitorPanelOpened) ? 10 : foldingContainer.height
                                color: "#00100b43"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top

                                PropertyAnimation {
                                    id: btnFoldingAnimation
                                    target: folderRect
                                    property: "height"
                                    duration: 400
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

                Rectangle {
                    id: bottomBarContent
                    color: "#00ffffff"
                    anchors.left: sideBar.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0

                    Rectangle {
                        id: bottomBar
                        y: 121
                        height: 20
                        color: "#070f18"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                    Rectangle {
                        id: appContentContainer
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: bottomBar.top
                        anchors.bottomMargin: 0

                        Rectangle {
                            id: bottomContainer
                            y: 245
                            height: (mainWindow.navMonitorPanelOpened) ? appContentContainer.height / 2 : 0
                            color: "#00ffffff"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            clip: true
                            anchors.bottomMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0

                            PropertyAnimation {
                                id: bottomContainerFoldAnimation
                                target: bottomContainer
                                property: "height"
                                property variant endHeight: (bottomContainer.height === 0) ? appContentContainer.height / 2 : 0
                                to: endHeight
                                duration: 400
                                easing {
                                    type: Easing.InOutQuint
                                }
                                onFinished: {
                                    mainWindow.navMonitorPanelOpened = !mainWindow.navMonitorPanelOpened
                                }
                                onStarted: {
                                    btnFoldingAnimation.running = true
                                }
                            }

                            Rectangle {
                                id: bottomToolBar
                                height: 30
                                color: "#070f18"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                            }

                            Rectangle {
                                id: navigationMonitorContent
                                color: "#00ffffff"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: bottomToolBar.bottom
                                anchors.bottom: parent.bottom
                                anchors.topMargin: 0

                                Loader{
                                    id: navMonitorDashLoader
                                    anchors.fill: parent
                                    sourceComponent: testComponent
                                    visible: True
                                    onLoaded: {
                                        item.customColor = "#313648"
                                        item.customTitle = qsTr("Navigatio and Control Dashboard")
                                    }
                                }

                                Loader{
                                    id: chartMonitorLoader
                                    anchors.fill: parent
                                    sourceComponent: testComponent
                                    visible: false
                                    onLoaded: {
                                        item.customColor = "#313648"
                                        item.customTitle = qsTr("Monitoring and Charts Page")
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: topContainer
                            color: "#00ffffff"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: bottomContainer.top
                            anchors.bottomMargin: 0
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                            anchors.topMargin: 0

                            Rectangle {
                                id: defaultVisualizerPanel
                                width: (mainWindow.defaultVisualizationPanelOpened) ? topContainer.width / 2.8 : 0
                                color: "#11386f"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                clip: true
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                anchors.bottomMargin: 0

                                PropertyAnimation{
                                    id: defaultVisualizerPanelAnimation
                                    property variant endWidth: (defaultVisualizerPanel.width === 0) ? topContainer.width / 2.8 : 0
                                    target: defaultVisualizerPanel
                                    property: "width"
                                    to: endWidth
                                    duration: 400
                                    easing{
                                        type: Easing.InOutQuint
                                    }
                                    onFinished: {
                                        mainWindow.defaultVisualizationPanelOpened = !mainWindow.defaultVisualizationPanelOpened
                                    }
                                }

                                Loader{
                                    id: defaultPage
                                    anchors.fill: parent
                                    sourceComponent: testComponent
                                    visible: false
                                    onLoaded: {
                                        item.customColor = "#313648"
                                        item.customTitle = qsTr("Default Data Visualization")
                                    }
                                }

                                Loader{
                                    id: pathPlotPage
                                    anchors.fill: parent
//                                    sourceComponent: testComponent
                                    source: Qt.resolvedUrl("pages/PathPlot.qml")
                                    visible: true
//                                    onLoaded: {
//                                        item.customColor = "purple"
//                                    }
                                }

                                Loader{
                                    id: xyPathPlotPage
                                    anchors.fill: parent
//                                    sourceComponent: testComponent
                                    source: Qt.resolvedUrl("pages/XyPathPlot.qml")
                                    visible: false
//                                    onLoaded: {
//                                        item.customColor = "yellow"
//                                    }
                                }

                                Component{
                                    id: testComponent
                                    Item {
                                        id: rootItem
                                        property alias customColor: testRect.color
                                        property alias customTitle: titleText.text
                                        property alias customTitleVisible: titleText.visible

                                        Rectangle{
                                            id: testRect
                                            anchors.fill: parent
                                            color: "#ee3e00"
                                            Text {
                                                id: titleText
                                                text: qsTr("text")
                                                visible: true
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }

                                }
                            }

                            Rectangle {
                                id: mapContainer
                                color: "#00ffffff"
                                anchors.left: defaultVisualizerPanel.right
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 0
                                MapView{
                                    id: map
                                    anchors.fill: parent
                                    anchors.leftMargin: 3
                                }
                            }
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

