import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Item {
    id: itemRoot

//    property alias swipeIndex: swipView.stackIndex
    property alias siwpViewInterface: swipView

    //swipView.currentIndex=swipView.popIndex();
    SwipeView {
        id: swipView
        anchors.fill: parent
        interactive: false;
        property int stackIndex: -1;

        function popIndex(){
            return (--stackIndex);
        }

        function pushIndex(){
            return (++stackIndex);
        }

        Component.onCompleted: {
            if(swipView.contentChildren.length>0)
            {
                swipView.stackIndex=0;
                contentItem.highlightMoveDuration = 0 //Set the moving time to 0
            }
        }

        Item {
            id: defaultDataPage
            Rectangle{
                anchors.fill: parent

                Text {
                    text: qsTr("Default Data")
                    anchors.centerIn: parent

                }
            }
        }

        Item {
            id: pathPlotPage
            Rectangle{
                anchors.fill: parent

                Text {
                    text: qsTr("3D Path Plot")
                    anchors.centerIn: parent

                }
            }
        }

        Item {
            id: xypathPlotPage
            Rectangle{
                anchors.fill: parent

                Text {
                    text: qsTr("2D Path Plot")
                    anchors.centerIn: parent

                }
            }
        }
    }
}
