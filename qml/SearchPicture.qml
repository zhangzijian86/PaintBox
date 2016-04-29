import QtQuick 2.0
import com.syberos.basewidgets 2.0

Rectangle {
    width: 500
    height: 500
    Rectangle{
        id:myPictureMain
        anchors.fill: parent
        color: "#e1f8f6"
        Rectangle{
            id:search4Rectangle
            height:myPictureMain.height*2/14+30
            width:myPictureMain.width-100
            anchors.top: parent.top
            anchors.topMargin: 80
            color: "#e1f8f6"
            anchors.horizontalCenter: parent.horizontalCenter
            Image{
                id:search4Image
                anchors.left:parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                height:130
                width:130
                source: "qrc:/res/serach/search_4.png";
            }
            Text {
                id: search4BigText
                anchors.left: search4Image.right
                anchors.leftMargin: 60
                anchors.top: parent.top
                anchors.topMargin: 42
                elide:Text.ElideRight
                color: "#000000"
                font.pixelSize: 35
                text:"颜料盒子贴纸铺"
            }
            Text{
                id:search4SmallText
                anchors.left: search4Image.right
                anchors.leftMargin: 58
                anchors.top: search4BigText.bottom
                anchors.topMargin: 17
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#adadad"
                font.pixelSize: 28
                text:"每周更新，贴纸送\"到家\""
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    gToast.requestToast("功能构建中");
                }
            }
        }
        Rectangle{
            id:search5Rectangle
            height:myPictureMain.height*2/14+30
            width:myPictureMain.width-100
            anchors.top: search4Rectangle.bottom
            anchors.topMargin: 50
            color: "#e1f8f6"
            anchors.horizontalCenter: parent.horizontalCenter
            Image{
                id:search5Image
                anchors.left:parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                height:130
                width:130
                source: "qrc:/res/serach/search_5.png";
            }
            Text {
                id: search5BigText
                anchors.left: search5Image.right
                anchors.leftMargin: 60
                anchors.top: parent.top
                anchors.topMargin: 42
                elide:Text.ElideRight
                color: "#000000"
                font.pixelSize: 35
                text:"私信&通知"
            }
            Text{
                id:search5SmallText
                anchors.left: search5Image.right
                anchors.leftMargin: 58
                anchors.top: search5BigText.bottom
                anchors.topMargin: 17
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#adadad"
                font.pixelSize: 28
                text:"朋友私信和系统通知"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    gToast.requestToast("功能构建中");
                }
            }
        }
    }
}
