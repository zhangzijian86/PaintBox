import QtQuick 2.0
import com.syberos.basewidgets 2.0

CPageStackWindow {
    initialPage:CPage{
        id:mainPage
        anchors.fill: parent
        statusBarHoldItemColor: "#ffd306"
        orientationLock: CPageOrientation.LockPortrait

        property var content: undefined

        Rectangle{
            id: top
            width: parent.width
            height: parent.height/10
            anchors.top: parent.top
            color: "#ffd306"
        }

        Rectangle{
            id: bottom
            z:10
            width: parent.width
            height: parent.height/10
            anchors.bottom: parent.bottom
            color: "#f3f3f3"
            Rectangle{
                width: parent.height-parent.height/4
                height: parent.height
                color: "#f3f3f3"
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
                    source: "qrc:/res/searchOn.png"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainPage.changePage("searchPicture.qml");
                    }
                }
            }
            Rectangle{
                width: parent.height-parent.height/4
                height: parent.height
                color: "#f3f3f3"
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    id: makePageImage
                    height: parent.height-parent.height/6
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height/4
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/res/makeOff.png"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        mainPage.changePage("makePicture.qml");
                    }
                }
            }
            Rectangle{
                width: parent.height-parent.height/4
                height: parent.height
                color: "#f3f3f3"
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
                        mainPage.changePage("myPicture.qml");
                    }
                }
            }
        }

        Component.onCompleted: {
            var com = Qt.createComponent("qrc:/qml/searchPicture.qml");
            if(com.status == Component.Ready){
                mainPage.content = com.createObject(mainPage);
                mainPage.content.anchors.top =  top.bottom;
                mainPage.content.anchors.left = mainPage.left;
                mainPage.content.anchors.right = mainPage.right;
                mainPage.content.anchors.bottom =  bottom.top;
            }
        }

        function changePage(pageName) {            
            if(mainPage.content != undefined ){
                mainPage.content.destroy();
            }

            var com = Qt.createComponent("qrc:/qml/"+pageName);
            if(com.status == Component.Ready){
                mainPage.content = com.createObject(mainPage);
                mainPage.content.anchors.top =  top.bottom;
                mainPage.content.anchors.left = mainPage.left;
                mainPage.content.anchors.right = mainPage.right;
                mainPage.content.anchors.bottom =  bottom.top;
                if(pageName=="searchPicture.qml"){
                    searchPageImage.source = "qrc:/res/searchOn.png";
                    makePageImage.source = "qrc:/res/makeOff.png";
                    myPageImage.source = "qrc:/res/myOff.png";
                }else if(pageName=="makePicture.qml"){
                    searchPageImage.source = "qrc:/res/searchOff.png";
                    makePageImage.source = "qrc:/res/makeOn.png";
                    myPageImage.source = "qrc:/res/myOff.png";
                }else if(pageName=="myPicture.qml"){
                    searchPageImage.source = "qrc:/res/searchOff.png";
                    makePageImage.source = "qrc:/res/makeOff.png";
                    myPageImage.source = "qrc:/res/myOn.png";
                }
            }
        }
    }
}

