import QtQuick 2.0
import com.syberos.basewidgets 2.0

Rectangle {
    width: 500
    height: 500
    Rectangle{
        anchors.fill: parent
        color: "red"
    }
    CButton{
        text:"qihuandao--my"
        onClicked:{
            mainPage.changePage("myPicture.qml");
        }
    }
}
