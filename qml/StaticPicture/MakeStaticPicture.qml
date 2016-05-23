import QtQuick 2.0
import com.syberos.basewidgets 2.0
import com.syberos.makeimage 1.0
import com.syberos.filemanager.filepicker 1.0
import "./"

CPage {
    id:makeStaticPicture
    anchors.fill: parent
    property int flag:0
    property int text_flag:0
    property int xflag:10
    property int yflag:10
    property int zflag:10
    property int size:2
    property string imageUrl:""
    property string strText:""
    property string materialType:""
    property alias  canvasObject :canvas
    property var childrens:[]
    property var text_childrens:[]
    property var passValue:[]
    property var passTextValue:[]
    property var nameValue:["expression-基础","corpse-僵尸","throwdog-扔狗","collapse-崩溃","friendship-友谊","penguin-企鹅","chick-小鸡"]
    signal deleteFocus();
    signal imageReversal();
    color: "#ffffff"
    contentAreaItem: Item {
        id:mainItem
        Rectangle{
            id:title
            anchors.top: parent.top
            anchors.left: parent.left
            height:parent.height/14
            width:parent.width
            color: "#ffffff"
            onChildrenChanged: {

            }

            Text {
                id: titleText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: division.bottom
                anchors.bottomMargin: 15
                elide:Text.ElideRight
                color: "#b5e8ff"
                font.pixelSize: 42
                text: "颜料盒子"
            }

            MakeImage{
                id:makeImage
            }

            CButton{
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                text:"保存"
                onClicked:{
                    console.log("=保存=");
                    deleteFocus();
                    var i = 0;
                    var chieldImage;
                    var tmpStr = "";
                    for(i=0;i<childrens.length;i++){
                        chieldImage = childrens[i];
                        tmpStr = tmpStr + chieldImage.chield_index;
                        tmpStr = tmpStr +"="+ ((chieldImage.chield_x - (chieldImage.width/2)*(chieldImage.countScale-1)))
                        tmpStr = tmpStr +"="+ ((chieldImage.chield_y - (chieldImage.height/2)*(chieldImage.countScale-1)));
                        tmpStr = tmpStr +"="+ (chieldImage.width*chieldImage.countScale);
                        tmpStr = tmpStr +"="+ (chieldImage.height*chieldImage.countScale);
                        tmpStr = tmpStr +"="+ chieldImage.chield_rotate;
                        tmpStr = tmpStr +"="+ chieldImage.chield_url;
                        tmpStr = tmpStr +"="+ chieldImage.chield_reversal;
                        tmpStr = tmpStr +"="+ chieldImage.chield_imagetype;
                        tmpStr = tmpStr +"="+ "0";
//                        console.log("==="+i+"==index="+chieldImage.chield_index);
//                        console.log("==="+i+"==x="+((chieldImage.chield_x - (chieldImage.width/2)*(chieldImage.countScale-1))));
//                        console.log("==="+i+"==y="+((chieldImage.chield_y - (chieldImage.height/2)*(chieldImage.countScale-1))));
//                        console.log("==="+i+"==width="+chieldImage.width);
//                        console.log("==="+i+"==height="+chieldImage.height);
//                        console.log("==="+i+"==rotate="+chieldImage.chield_rotate);
//                        console.log("==="+i+"==url="+chieldImage.chield_url);
//                        console.log("==="+i+"==focus="+chieldImage.focus);
//                        console.log("==="+i+"==chield_reversal="+chieldImage.chield_reversal);
//                        console.log("==="+i+"==chield_imagetype="+chieldImage.chield_imagetype);
//                        console.log("==="+i+"==tmpStr="+tmpStr);
                        passValue.push(tmpStr);
                        tmpStr = "";
                        //                    if(chieldImage.focus==true){
                        //                        childrens.splice(i,1);
                        //                        chieldImage.destroy();
                        //                    }
                        //                    childrens.splice(i,1);
                        //                    chieldImage.destroy();
                    }

                    var j = 0;
                    var chieldText;
                    var tmpTextStr = "";
                    for(j=0;j<text_childrens.length;j++){
                        chieldText = text_childrens[j];
                        tmpTextStr = tmpTextStr + chieldText.chield_index;
                        tmpTextStr = tmpTextStr +"="+ ((chieldText.chield_x - (chieldText.width/2)*(chieldText.countScale-1)))
                        tmpTextStr = tmpTextStr +"="+ ((chieldText.chield_y - (chieldText.height/2)*(chieldText.countScale-1)));
                        tmpTextStr = tmpTextStr +"="+ (chieldText.width*chieldText.countScale);
                        tmpTextStr = tmpTextStr +"="+ (chieldText.height*chieldText.countScale);
                        tmpTextStr = tmpTextStr +"="+ chieldText.chield_rotate;
                        tmpTextStr = tmpTextStr +"="+ chieldText.chield_text;
                        tmpTextStr = tmpTextStr +"="+ chieldText.scale;
                        tmpTextStr = tmpTextStr +"="+ chieldText.chield_imagetype;
                        tmpTextStr = tmpTextStr +"="+ "1";
                        console.log("==="+i+"==index="+chieldText.chield_index);
                        console.log("==="+i+"==x="+((chieldText.chield_x - (chieldText.width/2)*(chieldText.countScale-1))));
                        console.log("==="+i+"==y="+((chieldText.chield_y - (chieldText.height/2)*(chieldText.countScale-1))));
                        console.log("==="+i+"==width="+chieldText.width);
                        console.log("==="+i+"==height="+chieldText.height);text_childrens
                        console.log("==="+i+"==rotate="+chieldText.chield_rotate);
                        console.log("==="+i+"==url="+chieldText.chield_text);
                        console.log("==="+i+"==focus="+chieldText.focus);
                        console.log("==="+i+"==scale="+chieldText.scale);
                        console.log("==="+i+"==chield_imagetype="+chieldText.chield_imagetype);
                        console.log("==="+i+"==tmpStr="+tmpTextStr);
                        passTextValue.push(tmpTextStr);
                        tmpTextStr = "";
                    }

                    var returnStr = makeImage.makeStaticImage(size,canvas.width,canvas.height,passValue,passTextValue);
                    console.log("====returnStr======="+returnStr);
                    if(returnStr!=""){
                        mainPage.pageStack.pop();
                    }

                    passValue.splice(0,passValue.length);
                    passTextValue.splice(0,passTextValue.length)
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
                id:division
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
            color: "#ffffff"
            Image {
                id: reversalImage
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:30
                source:  "qrc:/res/reversal.png";
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        imageReversal();
                    }
                }
            }
            Image {
                id: newoneImage
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:50+(makeStaticPicture.width)/5
                source:  "qrc:/res/newone.png";
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        imageUrl = "";
                        var i = 0;
                        var chieldImage;
                        var width = expression.width/4;
                        var height = makeStaticPicture.height/13;
                        var reversal = 0
                        var rotation = 0;
                        for(i=0;i<childrens.length;i++){
                            chieldImage = childrens[i];
                            if(chieldImage.focus==true){
                                imageUrl = chieldImage.chield_url
                                width = chieldImage.width
                                height = chieldImage.height
                                rotation = chieldImage.rotation
                                reversal = chieldImage.chield_reversal
                            }
                        }
                        var parentheightTmp = makeStaticPicture.height*8/14
                        var parentwidthTmp = makeStaticPicture.width
                        if(imageUrl!=""){
                            deleteFocus();
                            var imageObj = Qt.createQmlObject(
                            'import QtQuick 2.0;
                               ChieldObject {
                               chield_url: "'+imageUrl+'";
                               width: 200;
                               height: 200;
                               parent_width: "'+parentwidthTmp+'";
                               parent_height: "'+parentheightTmp+'";
                               x: '+(canvas.width/2-width/2)+'
                               y: '+(canvas.height/2-height/2)+'
                               chield_index: "'+flag+'";
                               rotation: '+rotation+'
                               chield_reversal: '+reversal+'
                           }', canvasObject);
                            childrens.push(imageObj);
                            flag ++;
                        }

                        strText = "";
                        var j = 0;
                        var chieldText;
                        var textWidth = expression.width/4;
                        var textHeight = makeStaticPicture.height/13;
                        var reversalText = 0
                        var rotationText = 0;
                        for(j=0;j<text_childrens.length;j++){
                            chieldText = text_childrens[i];
                            if(chieldText.focus==true){
                                strText = chieldText.chield_text
                                textWidth = chieldText.width
                                textHeight = chieldText.height
                                rotationText = chieldText.rotation
                                reversalText = chieldText.chield_reversal
                            }
                        }
                        var parentheightTextTmp = makeStaticPicture.height*8/14
                        var parentwidthTextTmp = makeStaticPicture.width

                        if(strText!=""){
                            deleteFocus();
                            var textObj = Qt.createQmlObject(
                            'import QtQuick 2.0;
                               ChieldTextObject {
                               chield_text: "'+strText+'";
                               width: '+textWidth+';
                               height: 65;
                               parent_width: "'+parentwidthTextTmp+'";
                               parent_height: "'+parentheightTextTmp+'";
                               chield_index: "'+text_flag+'";
                               x: '+(canvas.width/2-width/2)+'
                               y: '+(canvas.height/2-height/2)+'
                               rotation: '+rotationText+'
                               chield_reversal: '+reversalText+'
                               chield_imagetype: "1";
                           }', canvasObject);
                            text_childrens.push(textObj);
                            text_flag ++;
                        }
                    }
                }
            }
            Image {
                id: deleteImage
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:50+(makeStaticPicture.width)*2/5
                source:  "qrc:/res/delete.png";
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        var i = 0;
                        var chieldImage;
                        for(i=0;i<childrens.length;i++){
                            chieldImage = childrens[i];
                            if(chieldImage.focus==true){
                                childrens.splice(i,1);
                                chieldImage.destroy();
                            }
                        }
                        var j = 0;
                        var chieldText;
                        for(i=0;i<text_childrens.length;i++){
                            chieldText = text_childrens[i];
                            if(chieldText.focus==true){
                                text_childrens.splice(i,1);
                                chieldText.destroy();
                            }
                        }
                    }
                }
            }

            Image {
                id: sizeImage
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:50+(makeStaticPicture.width)*3/5
                source:  "qrc:/res/big.png";
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        switch(size){
                            case 2:
                                size = 3;
                                sizeImage.source = "qrc:/res/middle.png";
                            break;
                            case 3:
                                size = 4;
                                sizeImage.source = "qrc:/res/small.png";
                            break;
                            case 4:
                                size = 2;
                                sizeImage.source = "qrc:/res/big.png";
                            break;
                            default:
                            break;
                        }
                    }
                }
            }

            Image {
                id: deleteAllImage
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin:50+(makeStaticPicture.width)*4/5
                source:  "qrc:/res/deleteAll.png";
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        deleteFocus();
                        deleteAllDialog.show();
                    }
                }
            }
        }

        Rectangle{
            anchors.top: operation.top
            anchors.left: parent.left
            width:parent.width
            height: 2
            color: "#e2e2e2"
        }

        Rectangle{
            id:type
            anchors.top: operation.bottom
            anchors.left: parent.left
            height:parent.height/13
            width:parent.width
            color: "#ffffff"
            ListView{
                anchors.top:parent.top
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 33
                anchors.right: parent.right
                anchors.rightMargin: 250
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                orientation: ListView.Horizontal
                model:typeModel
                delegate: typeDelegate
            }

            Image {
                id: selectImage
                anchors.right: parent.right
                width: 60
                height: 60
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin:30
                source:  "qrc:/res/selectimage.png";
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("========selectImage========");
                        mainPage.pageStack.push(filesPickerCom,{"category":1})
                    }
                }
            }
            Image {
                id: addfontImage
                anchors.right: parent.right
                width: 60
                height: 60
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin:110
                source:  "qrc:/res/addfont.png";
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("========addfontImage========");
                        //gToast.requestToast("添加文字功能构建中");
                        cInputDialog.show();
                    }
                }
            }
        }

        CInputDialog{
            id:cInputDialog
            visible: false
            maximumLength: 15
            onAccepted: {
                console.log("=======cInputDialog========="+cInputDialog.text());
                console.log("=======cInputDialog========="+cInputDialog.text().length);
                if(cInputDialog.text().length!=0){
                    mainItem.creatTextObj(cInputDialog.text(),cInputDialog.text().length*35,"0");
                }
                cInputDialog.setText("");
            }
        }

        Component{
            id: filesPickerCom
            SyberosFilesPicker{
                id: filesPicker
                onOk:{
                    console.log("========filesPickerCom=========00=====");
                    for(var j = 0; j < filesPicker.filesPath.length; j++){
                        console.log("========filesPickerCom=========11====="+filesPicker.filesPath[j]);
                        if(j==0){
                            mainItem.creatObj("file:/"+filesPicker.filesPath[j],makeStaticPicture.width/2,makeStaticPicture.width/2,"1");
                        }else{
                            gToast.requestToast("只保留多张图片的第一张");
                            break;
                        }
                    }
                }
            }
        }

        ListModel {
            id:typeModel
            ListElement {
                typeName:""
                isSelected:""
            }
        }

        Component {
            id:typeDelegate
            Text{
                id:typeText
                height: parent.height
                width:type.width/4
                text:typeName
                color:"#62b09f"
                font.pixelSize: 30
                anchors.top: parent.top
                anchors.topMargin: 28
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("======typeText============"+typeText.text);
                        mainItem.changeModel(typeText.text);
                    }
                }
            }
        }

        Rectangle{
            anchors.top: type.top
            anchors.left: parent.left
            width:parent.width
            height: 2
            color: "#e2e2e2"
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
                        mainItem.creatObj(imageUrl,expressionImage.width,expressionImage.height,"0");
                    }
                }
            }
        }

        Rectangle{
            anchors.top: expression.top
            anchors.left: parent.left
            width:parent.width
            height: 2
            color: "#e2e2e2"
        }

        CDialog{
            id:deleteAllDialog
            visible: false
            titleText : "清空画布"
            messageText:"是否清空画布？"
            acceptedButtonText: "确定"
            rejectButtonText: "取消"
            onAccepted:{
                console.log("=====deleteAllDialog=======确定======")
                var i = 0;
                var chieldImage;
                var tmpStr = "";
                for(i=0;i<childrens.length;i++){
                    chieldImage = childrens[i];
                    chieldImage.destroy();
                }

                var j = 0;
                var chieldText;
                for(j=0;j<text_childrens.length;j++){
                    chieldText = text_childrens[j];
                    chieldText.destroy();
                }

                passValue.splice(0,passValue.length);
                passTextValue.splice(0,passTextValue.length);
                childrens.splice(0,childrens.length);
                text_childrens.splice(0,text_childrens.length);
            }
        }

        Component.onCompleted: {
            passValue.splice(0,makeImage.length);
            expressionModel.clear();
            typeModel.clear();
            var str = makeStaticPicture.materialType.toString();
            str = str.substring(str.indexOf("-")+1,str.length);
            typeModel.append({typeName:str,isSelected:"1"});
            if(makeStaticPicture.materialType=="expression-基础"){
                expressionModel.append({image:"qrc:/res/expression/expression_1.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_2.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_3.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_4.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_5.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_6.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_7.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_8.png"});
            }
            if(makeStaticPicture.materialType=="corpse-僵尸"){
                expressionModel.append({image:"qrc:/res/corpse/corpse_1.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_2.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_3.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_4.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_5.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_6.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_7.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_8.png"});
            }
            if(makeStaticPicture.materialType=="throwdog-扔狗"){
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_1.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_2.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_3.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_4.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_5.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_6.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_7.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_8.png"});
            }
            if(makeStaticPicture.materialType=="collapse-崩溃"){
                expressionModel.append({image:"qrc:/res/collapse/collapse_1.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_2.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_3.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_4.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_5.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_6.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_7.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_8.png"});
            }            
            if(makeStaticPicture.materialType=="friendship-友谊"){
                expressionModel.append({image:"qrc:/res/friendship/friendship_1.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_2.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_3.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_4.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_5.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_6.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_7.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_8.png"});
            }
            if(makeStaticPicture.materialType=="penguin-企鹅"){
                expressionModel.append({image:"qrc:/res/penguin/penguin_1.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_2.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_3.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_4.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_5.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_6.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_7.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_8.png"});
            }
            if(makeStaticPicture.materialType=="chick-小鸡"){
                expressionModel.append({image:"qrc:/res/chick/chick_1.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_2.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_3.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_4.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_5.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_6.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_7.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_8.png"});
            }
            var i =0
            var strOne = "";
            for(i=0;i<nameValue.length;i++){
                if(makeStaticPicture.materialType!=nameValue[i]){
                   strOne = nameValue[i];
                   strOne = strOne.substring(strOne.indexOf("-")+1,strOne.length);
                   typeModel.append({typeName:strOne,isSelected:"0"});
                }
            }
        }

        function creatObj(sourceObj,widthObj,heightObj,imageType){
            var imageObj = Qt.createQmlObject(
            'import QtQuick 2.0;
               ChieldObject {
               chield_url: "'+sourceObj+'";
               width: 200;
               height: 200;
               parent_width: "'+canvasObject.width+'";
               parent_height: "'+canvasObject.height+'";
               chield_index: "'+flag+'";
               chield_imagetype: "'+imageType+'";
               x: '+(canvasObject.width/2-widthObj/2)+'
               y: '+(canvasObject.height/2-heightObj/2)+'
           }', canvasObject);
            childrens.push(imageObj);
            flag ++;
        }

        function creatTextObj(textObj,textObjwith,imageType){
            var imageObj = Qt.createQmlObject(
            'import QtQuick 2.0;
               ChieldTextObject {
               chield_text: "'+textObj+'";
               width: '+textObjwith+';
               height: 65;
               parent_width: "'+canvasObject.width+'";
               parent_height: "'+canvasObject.height+'";
               chield_index: "'+text_flag+'";
               chield_imagetype: "'+imageType+'";
               x: '+(canvasObject.width/2-200)+'
               y: '+(canvasObject.height/2-200)+'
           }', canvasObject);
            text_childrens.push(imageObj);
            text_flag ++;
        }

        function changeModel(type){
            if(type=="基础"){
                expressionModel.clear();
                expressionModel.append({image:"qrc:/res/expression/expression_1.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_2.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_3.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_4.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_5.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_6.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_7.png"});
                expressionModel.append({image:"qrc:/res/expression/expression_8.png"});
            }
            if(type=="僵尸"){
                expressionModel.clear();
                expressionModel.append({image:"qrc:/res/corpse/corpse_1.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_2.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_3.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_4.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_5.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_6.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_7.png"});
                expressionModel.append({image:"qrc:/res/corpse/corpse_8.png"});
            }
            if(type=="扔狗"){
                expressionModel.clear();
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_1.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_2.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_3.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_4.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_5.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_6.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_7.png"});
                expressionModel.append({image:"qrc:/res/throwdog/throwdog_8.png"});
            }
            if(type=="崩溃"){
                expressionModel.clear();
                expressionModel.append({image:"qrc:/res/collapse/collapse_1.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_2.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_3.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_4.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_5.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_6.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_7.png"});
                expressionModel.append({image:"qrc:/res/collapse/collapse_8.png"});
            }
            if(type=="友谊"){
                expressionModel.clear();
                expressionModel.append({image:"qrc:/res/friendship/friendship_1.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_2.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_3.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_4.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_5.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_6.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_7.png"});
                expressionModel.append({image:"qrc:/res/friendship/friendship_8.png"});
            }
            if(type=="企鹅"){
                expressionModel.clear();
                expressionModel.append({image:"qrc:/res/penguin/penguin_1.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_2.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_3.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_4.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_5.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_6.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_7.png"});
                expressionModel.append({image:"qrc:/res/penguin/penguin_8.png"});
            }
            if(type=="小鸡"){
                expressionModel.clear();
                expressionModel.append({image:"qrc:/res/chick/chick_1.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_2.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_3.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_4.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_5.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_6.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_7.png"});
                expressionModel.append({image:"qrc:/res/chick/chick_8.png"});
            }
        }
    }
}
