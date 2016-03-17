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
            width: parent.width
            height: parent.height/10
            anchors.bottom: parent.bottom
            color: "#f3f3f3"
        }
        Component.onCompleted: {
            var com = Qt.createComponent("qrc:/qml/makePicture.qml");
            console.log("====000====");
            if(com.status == Component.Ready){
                console.log("====111====");
                mainPage.content = com.createObject(mainPage);
                console.log("====222====");
                mainPage.content.anchors.top =  top.bottom;
                mainPage.content.anchors.left = mainPage.left;
                mainPage.content.anchors.right = mainPage.right;
                console.log("====333====");
                mainPage.content.anchors.bottom =  bottom.top;
            }
            console.log("====444====")
        }
    }
}

