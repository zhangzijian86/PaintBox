import QtQuick 2.0
import com.syberos.basewidgets 2.0

CPageStackWindow {
    initialPage:CPage{
        id:mainPage
        width: parent.width
        height: parent.height
        statusBarHoldItemColor: "#ffd306"
        orientationLock: CPageOrientation.LockPortrait

        signal modifyFocus();

        Component.onCompleted: {
            gScreenInfo.setStatusBar(true)
            gScreenInfo.setStatusBarStyle("transblack")
        }

        contentAreaItem: Item {
            id:mainItem
            property var content: undefined

            Rectangle{
                id: top
                z:10
                width: parent.width
                height: parent.height/10
                anchors.top: parent.top
                color: "#FEE680"
                Text {
                    id: titleText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 15
                    elide:Text.ElideRight
                    color: "#b5e8ff"
                    font.pixelSize: 42
                    text: "颜料盒子"
                }
            }

            Rectangle{
                id: bottom
                z:10
                width: parent.width
                height: parent.height/10
                anchors.bottom: parent.bottom
                color: "#e2e2e2"
                Rectangle{
                    width: parent.height-parent.height/4
                    height: parent.height
                    color: "#e2e2e2"
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/4-parent.width/8
                    Image {
                        id: searchPageImage
                        height: parent.height-parent.height/4
                        width: parent.height-parent.height/4
                        anchors.top: parent.top
                        anchors.topMargin: parent.height/6
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "qrc:/res/searchOff.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            mainItem.changePage("SearchPicture.qml");
                        }
                    }
                }
                Rectangle{
                    width: parent.height-parent.height/4
                    height: parent.height
                    color: "#e2e2e2"
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        id: makePageImage
                        width: parent.width+parent.height/10
                        height: parent.height-parent.height/10
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: parent.height/6
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "qrc:/res/makeOn.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            mainItem.changePage("MakePicture.qml");
                        }
                    }
                }
                Rectangle{
                    width: parent.height-parent.height/4
                    height: parent.height
                    color: "#e2e2e2"
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width/4-parent.width/8
                    Image {
                        id: myPageImage
                        height: parent.height-parent.height/4
                        width: parent.height-parent.height/4
                        anchors.top: parent.top
                        anchors.topMargin: parent.height/6
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "qrc:/res/myOff.png"
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            mainItem.changePage("MyPicture.qml");
                        }
                    }
                }
            }

            Component.onCompleted: {
                var com = Qt.createComponent("qrc:/qml/MakePicture.qml");
                if(com.status == Component.Ready){
                    mainItem.content = com.createObject(mainItem);
                    mainItem.content.anchors.top =  top.bottom;
                    mainItem.content.anchors.left = mainItem.left;
                    mainItem.content.anchors.right = mainItem.right;
                    mainItem.content.anchors.bottom =  bottom.top;
                }
            }

            function changePage(pageName) {
                if(mainItem.content != undefined ){
                    mainItem.content.destroy();
                }

                var com = Qt.createComponent("qrc:/qml/"+pageName);
                if(com.status == Component.Ready){
                    mainItem.content = com.createObject(mainItem);
                    mainItem.content.anchors.top =  top.bottom;
                    mainItem.content.anchors.left = mainItem.left;
                    mainItem.content.anchors.right = mainItem.right;
                    mainItem.content.anchors.bottom =  bottom.top;
                    if(pageName=="SearchPicture.qml"){
                        searchPageImage.source = "qrc:/res/searchOn.png";
                        makePageImage.source = "qrc:/res/makeOff.png";
                        myPageImage.source = "qrc:/res/myOff.png";
                    }else if(pageName=="MakePicture.qml"){
                        searchPageImage.source = "qrc:/res/searchOff.png";
                        makePageImage.source = "qrc:/res/makeOn.png";
                        myPageImage.source = "qrc:/res/myOff.png";
                    }else if(pageName=="MyPicture.qml"){
                        searchPageImage.source = "qrc:/res/searchOff.png";
                        makePageImage.source = "qrc:/res/makeOff.png";
                        myPageImage.source = "qrc:/res/myOn.png";
                    }
                }
            }
        }
    }
}

