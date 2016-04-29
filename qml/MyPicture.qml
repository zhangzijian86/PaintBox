import QtQuick 2.0
import com.syberos.makeimage 1.0
import com.syberos.basewidgets 2.0

Rectangle {
    id:myPicture
    width: 500
    height: 500
    property var images:[]
    Rectangle{
        id:myPictureMain
        anchors.fill: parent
        color: "#e2e2e2"
        MakeImage{
            id:makeImage
        }

        Image{
            id:noImage
            visible: false
            anchors.top: parent.top
            anchors.topMargin: 30
            height:myPicture.height*8/14+30
            width:myPicture.width-100
            source:"qrc:/res/noimage.jpg"
            anchors.horizontalCenter: parent.horizontalCenter
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
                }
                Image{
                    id:modifyImage
                    anchors.bottom: expressionImage.bottom
                    anchors.bottomMargin: 20
                    anchors.left: expressionImage.left
                    anchors.leftMargin:expressionImage.width/3
                    height:50
                    width:90
                    source:"qrc:/res/modifyimage.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("======modifyImage======="+imageName);
                            mainPage.pageStack.push("qrc:/qml/StaticPicture/MakeStaticModifyPicture.qml",{"imageName":imageName});
                        }
                    }
                }
                Image{
                    id:deleteImage
                    anchors.right: expressionImage.right
                    anchors.rightMargin:expressionImage.width/3
                    anchors.verticalCenter: modifyImage.verticalCenter
                    height:75
                    width:75
                    source:"qrc:/res/delete.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.log("======deleteImage======="+imageName);
                            var returnValue = makeImage.deleteImage(imageName);
                            if(returnValue == true){
                                myPictureMain.getAll();
                            }
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

        function getAll(){
            expressionModel.clear();
            var returnValue = makeImage.getAllImages();
            if(returnValue==""){
                console.log("========getAll====null========");
                noImage.visible = true;
            }else{
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

        Component.onCompleted: {
            getAll();
        }
    }
}
