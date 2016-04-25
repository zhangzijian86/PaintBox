import QtQuick 2.0
import com.syberos.basewidgets 2.0
import com.syberos.makeimage 1.0
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
    property var childrens:[]
    property var passValue:[]
    signal deleteFocus();
    color: "#ffffff"
    Rectangle{
        id:title
        anchors.top: parent.top
        anchors.left: parent.left
        height:parent.height/14
        width:parent.width
        color: "#ffffff"
        onChildrenChanged: {
            console.log("===========onChildrenChanged==========");
        }
        MakeImage{
            id:makeImage
        }

        CButton{
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            text:"下一步"
            onClicked:{
                console.log("=下一步=");
                var i = 0;
                var chieldImage;
                var tmpStr = "";
                for(i=0;i<childrens.length;i++){
                    chieldImage = childrens[i];
                    tmpStr = tmpStr + chieldImage.chield_index;
                    tmpStr = tmpStr +"-"+ chieldImage.chield_x;
                    tmpStr = tmpStr +"-"+ chieldImage.chield_y;
                    tmpStr = tmpStr +"-"+ chieldImage.width;
                    tmpStr = tmpStr +"-"+ chieldImage.height;
                    tmpStr = tmpStr +"-"+ chieldImage.chield_rotate;
                    tmpStr = tmpStr +"-"+ chieldImage.chield_url;
                    console.log("==="+i+"==index="+chieldImage.chield_index);
                    console.log("==="+i+"==x="+chieldImage.chield_x);
                    console.log("==="+i+"==y="+chieldImage.chield_y);
                    console.log("==="+i+"==width="+chieldImage.width);
                    console.log("==="+i+"==height="+chieldImage.height);
                    console.log("==="+i+"==rotate="+chieldImage.chield_rotate);
                    console.log("==="+i+"==url="+chieldImage.chield_url);
                    console.log("==="+i+"==focus="+chieldImage.focus);
                    console.log("==="+i+"==tmpStr="+tmpStr);
                    passValue.push(tmpStr);
                    tmpStr = "";
//                    if(chieldImage.focus==true){
//                        childrens.splice(i,1);
//                        chieldImage.destroy();
//                    }
//                    childrens.splice(i,1);
//                    chieldImage.destroy();
                }
//                makeImage.makeStaticImage(canvas.width,canvas.height,passValue);
//                passValue.splice(0,makeImage.length);
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
        anchors.right: parent.right
        height:parent.height*8/14
        width:parent.width
        color: "#ffffff"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                deleteFocus();
            }
        }
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
        color: "#ffffff"
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
                    var imageObj = Qt.createQmlObject(
                      'import QtQuick 2.0;
                       ChieldObject {
                           chield_url: "'+imageUrl+'";
                           width: '+expressionImage.width+';
                           height: '+expressionImage.height+';
                           parent_width: "'+canvas.height+'";
                           parent_height: "'+canvas.height+'";
                           chield_index: "'+flag+'";
                           x: '+(canvas.width/2-expressionImage.width/2)+'
                           y: '+(canvas.height/2-expressionImage.height/2)+'
                       }', canvasObject);
                    childrens.push(imageObj);
                    flag ++;
                }
            }
        }
    }
    Component.onCompleted: {
        passValue.splice(0,makeImage.length);
        expressionModel.clear();
        expressionModel.append({image:"qrc:/res/expression_1.png"});
        expressionModel.append({image:"qrc:/res/expression_2.png"});
        expressionModel.append({image:"qrc:/res/expression_3.png"});
        expressionModel.append({image:"qrc:/res/expression_4.png"});
        expressionModel.append({image:"qrc:/res/expression_5.png"});
        expressionModel.append({image:"qrc:/res/expression_6.png"});
        expressionModel.append({image:"qrc:/res/expression_7.png"});
        expressionModel.append({image:"qrc:/res/expression_8.png"});
    }
}
