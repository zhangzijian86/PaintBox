import QtQuick 2.0
import com.syberos.basewidgets 2.0
import "./"

Rectangle {
    id:makeStaticPicture
    anchors.fill: parent
    property int flag:0
    property int xflag:10
    property int yflag:10
    property int zflag:10
    property string imageUrl:""
    property alias  canvasObject :canvas
    color: "#ffffff"
    Rectangle{
        id:title
        anchors.top: parent.top
        anchors.left: parent.left
        height:parent.height/14
        width:parent.width
        color: "#ffffff"
        CButton{
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            text:"下一步"
            onClicked:{
                console.log("=下一步=");
            }
        }
        Image {
            id: backImage
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/res/back.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainPage.pageStack.pop();
                }
            }
        }
        Rectangle{
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width:parent.width
            height: 2
            color: "#e2e2e2"
        }
    }
    Rectangle{
        id:canvas
        anchors.top: title.bottom
        anchors.left: parent.left
        height:parent.height*8/14
        width:parent.width
        color: "#ffffff"
    }

    Rectangle{
        id:operation
        anchors.top: canvas.bottom
        anchors.left: parent.left
        height:parent.height/13
        width:parent.width
        color: "blue"
    }

    Rectangle{
        id:type
        anchors.top: operation.bottom
        anchors.left: parent.left
        height:parent.height/13
        width:parent.width
        color: "red"
    }

    Rectangle{
        id:expression
        anchors.top: type.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        height:parent.height/13
        width:parent.width
        color: "#e2e2e2"
        ListView{
            anchors.top:parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            orientation: ListView.Horizontal
            model:expressionModel
            delegate: expressionDelegate
        }
    }

    ListModel {
        id:expressionModel
        ListElement {
            image:""
        }
    }
    Component {
        id:expressionDelegate
        Image{
            id:expressionImage
            height: parent.height
            width:expression.width/4
            source:image
            anchors.verticalCenter: parent.verticalCenter
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    imageUrl = expressionImage.source;

//                    var imageObj = Qt.createQmlObject(
//                      'import QtQuick 2.0;
//                       ChieldObject {}', canvasObject);

                    var imageObj = Qt.createQmlObject(
                      'import QtQuick 2.0;
                       Image {
                           source: "'+imageUrl+'";
                           width: '+expressionImage.width+';
                           height: '+expressionImage.height+';
                           anchors.left: parent.left
                           anchors.leftMargin:  '+flag+'
                           anchors.verticalCenter: parent.verticalCenter
                       }', canvasObject);

                    flag = flag+100;
                }
            }
        }
    }
    Component.onCompleted: {
        expressionModel.clear();
        expressionModel.append({image:"qrc:/res/expression-1.png"});
        expressionModel.append({image:"qrc:/res/expression-2.png"});
        expressionModel.append({image:"qrc:/res/expression-3.png"});
        expressionModel.append({image:"qrc:/res/expression-4.png"});
        expressionModel.append({image:"qrc:/res/expression-5.png"});
        expressionModel.append({image:"qrc:/res/expression-6.png"});
        expressionModel.append({image:"qrc:/res/expression-7.png"});
        expressionModel.append({image:"qrc:/res/expression-8.png"});
    }
}
