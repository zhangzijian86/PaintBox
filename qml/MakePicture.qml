import QtQuick 2.0
import com.syberos.basewidgets 2.0

Rectangle {
    width: 500
    height: 500
    color: "#ffffff"
    Rectangle{
        id: bottom
        width: parent.width
        height: parent.height*2/5
        anchors.bottom: parent.bottom
        color: "#fce277"

        Rectangle{
            id: staticRectangle
            height: parent.height/2
            width: parent.width/5
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.top: parent.top
            anchors.topMargin: 100
            color: "#fce277"
            Image {
                id: staticImage
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                source: "qrc:/res/staticImage.png"
            }
            Text{
                anchors.top: staticImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text:"做静图"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainPage.pageStack.push("qrc:/qml/StaticPicture/MakeStaticPicture.qml");
                }
            }
        }
        Rectangle{
            id: dynamicRectangle
            anchors.top: parent.top
            height: parent.height/2
            width: parent.width/5
            anchors.topMargin: 100
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#fce277"
            Image {
                id: dynamicImage
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/res/dynamicImage.png"
            }
            Text{
                anchors.top: dynamicImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text:"玩动图"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    gToast.requestToast("玩动图功能构建中");
                }
            }
        }
        Rectangle{
            id: animationRectangle
            height: parent.height/2
            width: parent.width/5
            anchors.right: parent.right
            anchors.rightMargin: 80
            anchors.top: parent.top
            anchors.topMargin: 100
            color: "#fce277"
            Image {
                id: animationImage
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                source: "qrc:/res/animationImage.png"
            }
            Text{
                anchors.top: animationImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text:"微动画"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    gToast.requestToast("微动画功能构建中");
                }
            }
        }
    }
}
