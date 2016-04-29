import QtQuick 2.0
import com.syberos.makeimage 1.0
import com.syberos.basewidgets 2.0

Rectangle {
    id:myPicture
    width: 500
    height: 500
    property var images:[]
    Rectangle{
        anchors.fill: parent
        color: "#e2e2e2"
        MakeImage{
            id:makeImage
        }
        ListView{
            anchors.top:parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            model:expressionModel
            delegate: expressionDelegate
        }

        ListModel {
            id:expressionModel
            ListElement {
                image:""
                imageName:""
            }
        }

        Component {
            id:expressionDelegate
            Rectangle{
                height:myPicture.height*8/14+30
                width:myPicture.width-100
                anchors.horizontalCenter: parent.horizontalCenter
                Image{
                    id:expressionImage
                    height:parent.height-30
                    width:parent.width
                    source:image
                    anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("============="+imageName);
                        }
                    }
                }
                Rectangle{
                    anchors.top: expressionImage.bottom
                    anchors.topMargin: 3
                    anchors.left: parent.left
                    width:parent.width
                    height: 30
                    color: "#e2e2e2"
                }
            }
        }
        Component.onCompleted: {
            expressionModel.clear();
            var returnValue = makeImage.getAllImages();
            var imageNameText = "";
            console.log("==returnValue=="+returnValue)
            images = returnValue.toString().split("=");
            var i = 0;
            for(i = 0;i<images.length;i++){
                console.log("==returnValue=0="+images[i])
                if(images[i].toString()!=""){
                    console.log("==returnValue=1="+i+"file:"+images[i].toString())
                    imageNameText = images[i].toString().substring(images[i].toString().indexOf("/data/data/com.pg.PaintBox/")+"/data/data/com.pg.PaintBox/".length,images[i].length-4);
                    console.log("==imageNameText=="+imageNameText)
                    expressionModel.append({image:("file:"+images[i].toString()),imageName:imageNameText});
                }
            }
        }
    }
}
