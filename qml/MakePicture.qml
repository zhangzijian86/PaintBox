import QtQuick 2.0
import com.syberos.basewidgets 2.0

Rectangle {
    width: 500
    height: 500
    color: "#ffffff"

    Rectangle{
        id:makePicturetop
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: bottom.top
        Rectangle{
            id:corpseRectangle
            width: 155
            height: 180
            anchors.left: parent.left
            anchors.top: parent.top
            Image {
                id: newoneImage
                anchors.left: parent.left
                anchors.top: parent.top
                width: 150
                height: 150
                anchors.topMargin:50
                anchors.leftMargin:50
                source:  "qrc:/res/homepage/homepage_corpse.png";
            }
            Text{
                anchors.top: newoneImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: newoneImage.horizontalCenter
                text:"僵尸"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainPage.pageStack.push("qrc:/qml/StaticPicture/MakeStaticPicture.qml",{"materialType":"corpse-僵尸"});
                }
            }
        }
        Rectangle{
            id:throwdogRectangle
            width: 155
            height: 180
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            Image {
                id: throwdogImage
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                width: 150
                height: 150
                anchors.topMargin:50
                source:  "qrc:/res/homepage/homepage_throwdog.png";
            }
            Text{
                anchors.top: throwdogImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: throwdogImage.horizontalCenter
                text:"扔狗"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainPage.pageStack.push("qrc:/qml/StaticPicture/MakeStaticPicture.qml",{"materialType":"throwdog-扔狗"});
                }
            }
        }
        Rectangle{
            id:collapseRectangle
            width: 155
            height: 180
            anchors.right: parent.right
            anchors.top: parent.top
            Image {
                id: collapseImage
                anchors.right: parent.right
                anchors.top: parent.top
                width: 150
                height: 150
                anchors.topMargin:50
                anchors.rightMargin:50
                source:  "qrc:/res/homepage/homepage_collapse.png";
            }
            Text{
                anchors.top: collapseImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: collapseImage.horizontalCenter
                text:"崩溃"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainPage.pageStack.push("qrc:/qml/StaticPicture/MakeStaticPicture.qml",{"materialType":"collapse-崩溃"});
                }
            }
        }

        Rectangle{
            id:friendshipRectangle
            width: 155
            height: 180
            anchors.left: parent.left
            anchors.top: corpseRectangle.bottom
            anchors.topMargin:100
            Image {
                id: friendshipImage
                anchors.left: parent.left
                anchors.top: parent.top
                width: 150
                height: 150
                anchors.topMargin:30
                anchors.leftMargin:50
                source:  "qrc:/res/homepage/homepage_friendship.png";
            }
            Text{
                anchors.top: friendshipImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: friendshipImage.horizontalCenter
                text:"友谊"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    gToast.requestToast("素材收集中");
                }
            }
        }

        Rectangle{
            id:penguinRectangle
            width: 155
            height: 180
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: throwdogRectangle.bottom
            anchors.topMargin:100
            Image {
                id: penguinImage
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                width: 150
                height: 150
                anchors.topMargin:30
                source:  "qrc:/res/homepage/homepage_penguin.png";
            }
            Text{
                anchors.top: penguinImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: penguinImage.horizontalCenter
                text:"企鹅"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    gToast.requestToast("素材收集中");
                }
            }
        }

        Rectangle{
            id:chickRectangle
            width: 155
            height: 180
            anchors.right: parent.right
            anchors.top: collapseRectangle.bottom
            anchors.topMargin:100
            Image {
                id: chickImage
                anchors.right: parent.right
                anchors.top: parent.top
                width: 150
                height: 150
                anchors.topMargin:30
                anchors.rightMargin:50
                source:  "qrc:/res/homepage/homepage_chick.png";
            }
            Text{
                anchors.top: chickImage.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: chickImage.horizontalCenter
                text:"小鸡"
                font.pixelSize: 25
                color: "#7b7b7b"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    gToast.requestToast("素材收集中");
                }
            }
        }
    }

    Rectangle{
        id: makePicturebottom
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
                    mainPage.pageStack.push("qrc:/qml/StaticPicture/MakeStaticPicture.qml",{"materialType":"expression-基础"});
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
