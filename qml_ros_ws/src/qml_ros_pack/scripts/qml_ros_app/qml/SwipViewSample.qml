//main.qml
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

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
            }
        }

        Item {
            id: page1
            Column {
                height: parent.height * 0.2
                width: parent.width * 0.5
                anchors.centerIn: parent
                spacing: height * 0.04

                TextField {
                    height: parent.height * 0.48
                    width: parent.width
                    placeholderText: qsTr("Placeholder 1")
                }

                Button {
                    height: parent.height * 0.48
                    width: parent.width
                    text: qsTr("Next")
                    onClicked: swipView.currentIndex=swipView.pushIndex();
                }
            }
        }

        Item {
            id: page2

            Column {
                height: parent.height * 0.2
                width: parent.width * 0.5
                anchors.centerIn: parent
                spacing: height * 0.04

                TextField {
                    height: parent.height * 0.48
                    width: parent.width
                    placeholderText: qsTr("Placeholder 2")
                }

                Button {
                    height: parent.height * 0.48
                    width: parent.width
                    text: qsTr("Back")
                    onClicked: swipView.currentIndex=swipView.popIndex();
                }
            }
        }
    }

}
