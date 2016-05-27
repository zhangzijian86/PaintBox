#include "makeimage.h"

MakeImage::MakeImage(QObject *parent):QObject(parent)
{
}

bool MakeImage::deleteImage(QString imageName){
    bool returnBool = true;
    QString path;
    QDir dir;
    path=dir.currentPath();
    qDebug()<<"=deleteImage=path=0="+ (path+"/"+imageName+"/");
    qDebug()<<"=deleteImage=path=1="+ (path+"/"+imageName+".jpg");
    qDebug()<<"=deleteImage=path=rm="+ ("rm -rf "+path+"/"+imageName+"*");
    QString cmd = "";
    cmd = "rm -rf "+path+"/"+imageName+"*";
    char*  ch;
    QByteArray ba = cmd.toLatin1();
    ch=ba.data();
    system(ch);
    return returnBool;
}


QString MakeImage::getModifyImages(QString imageName){
    QString returnStr = "";
    QString path;
    QDir dir;
    path=dir.currentPath();
    qDebug()<<"==path=="+ path;
    qDebug()<<"==path=="+ (path+"/"+imageName+"/"+imageName+".txt");
    QFile f(path+"/"+imageName+"/"+imageName+".txt");
    if(!f.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug()<<"=Open failed=";
        return "error";
    }

    QTextStream txtInput(&f);
    QString lineStr;
    while(!txtInput.atEnd())
    {
        lineStr = txtInput.readLine();
        returnStr = returnStr + lineStr + "+";
        qDebug()<<"=lineStr="<< lineStr << endl;
    }

    f.close();
    return returnStr;
}

QString MakeImage::getAllImages(){
    QString returnStr = "";
    QString path;
    QDir dir;
    path=dir.currentPath();
    qDebug()<<"==path=="+ path;
    QDir dirAllImage(path);
    if (dirAllImage.exists()){
        dirAllImage.setFilter(QDir::Dirs|QDir::Files);
        dirAllImage.setSorting(QDir::DirsFirst);
        QFileInfoList list = dir.entryInfoList();
        for(int i = 0; i<list.length();i++){
            QFileInfo fileInfo = list.at(i);
            if(fileInfo.fileName().endsWith(".jpg")){
                qDebug()<<"==fileName=="+ fileInfo.fileName();
                qDebug()<<"==filePathAll=="+ path+"/"+fileInfo.fileName();
                returnStr = returnStr + path+"/"+fileInfo.fileName() +"=";
            }
        }
    }
    return returnStr;
}

QString MakeImage::makeStaticImage(int size,int Bgwidht,int Bgheight,const QStringList &imgList,const QStringList &textList){
    QString nameTmp = "";
    QString pathTmp = "";
    QString path;
    QDir dir;
    path=dir.currentPath();
    qDebug()<<"==path=="+ path;
    QDateTime current_date_time = QDateTime::currentDateTime();
    QString current_date = current_date_time.toString("yyyyMMdd_hhmmss");
    nameTmp = "PaintBox_"+current_date;
    pathTmp = path+"/"+nameTmp;
    QDir *temp = new QDir;

    bool exist = temp->exists(path+"/"+nameTmp);
    if(exist)
        qDebug()<<"<<<<文件夹已经存在！";
    else
    {
        bool ok = temp->mkdir(pathTmp);
        if( ok ){
            qDebug()<<"<<<<文件夹创建成功！";
        }else{
            qDebug()<<"<<<<无法创建文件夹！";
            return "error";
        }
    }

    QDir *outtemp = new QDir;
    bool outexist = outtemp->exists("/data/home/user/DCIM/Camera");
    if(outexist)
        qDebug()<<"out<<<<文件夹已经存在！";
    else
    {
        bool outok = outtemp->mkdir("/data/home/user/DCIM/Camera");
        if( outok ){
            qDebug()<<"out<<<<文件夹创建成功！";
        }else{
            qDebug()<<"out<<<<无法创建文件夹！";
            return "error";
        }
    }

    QFile file(pathTmp+"/"+nameTmp+".txt");
    if (!file.open(QIODevice::ReadWrite|QIODevice::Text)) {
        qDebug()<<"<<<<无法创建文件";
        return "error";
    }
    QTextStream out(&file);

    QPixmap *pix=new QPixmap(QSize(Bgwidht,Bgheight));
    pix->fill(Qt::white);
    QPainter paint(pix);
    paint.setRenderHint(QPainter::HighQualityAntialiasing, true);
    for(int i = 0; i<imgList.length();i++){
        QString strTmp=imgList.at(i);

        QStringList strlTmp = strTmp.split("=");
        QString xTmp = this->processingString(strlTmp.at(1));
        QString yTmp = this->processingString(strlTmp.at(2));
        QString widhtTmp = this->processingString(strlTmp.at(3));
        QString heightTmp = this->processingString(strlTmp.at(4));
        QString rotatetTmp = this->processingString(strlTmp.at(5));
        QString urlTmp = strlTmp.at(6);
        QString reversalTmp = strlTmp.at(7);
        QString imagetypeTmp = strlTmp.at(8);
        QString typeTmp = strlTmp.at(9);

        qDebug()<<"=makeStaticImage=typeTmp=="<< typeTmp<<"i=:"<<i;

        if(imagetypeTmp=="0"){
            urlTmp = urlTmp.mid(urlTmp.lastIndexOf("/"),urlTmp.length()-1);
            urlTmp = ":res"+urlTmp.mid(0,urlTmp.lastIndexOf("_"))+urlTmp;
            out<<strTmp<<endl;
        }else{            
            QString outImageName = "";
            QString outImageUrl = "";
            outImageName = urlTmp.mid(urlTmp.lastIndexOf("/"),urlTmp.length()-1);
            outImageUrl = pathTmp+""+outImageName;
            qDebug()<<"==outImageUrl=="+ outImageUrl;
            out<<strTmp.replace(urlTmp,outImageUrl)<<endl;
            urlTmp = urlTmp.replace("file:/","");
            qDebug()<<"==strTmp.replace(urlTmp,outImageUrl)=="+ strTmp.replace(urlTmp,outImageUrl);
            qDebug()<<"==urlTmp=="+ urlTmp;
            qDebug()<<"==outImageUrl=="+ outImageUrl;
            if(!QFile::copy(urlTmp, outImageUrl))
            {
                 qDebug()<<"拷贝失败";
            }
        }
        qDebug()<<"=imgList=000=urlTmp="<<urlTmp;
        qDebug()<<"=imgList=000=size="<<size;
        qDebug()<<"=imgList=000=width="<<QPixmap(urlTmp).width();
        qDebug()<<"=imgList=000=height="<<QPixmap(urlTmp).height();
        qDebug()<<"=imgList=000=widhtTmp.toInt()/size="<<widhtTmp.toInt()/size;
        qDebug()<<"=imgList=000=heightTmp.toInt()/size="<<heightTmp.toInt()/size;
        if(reversalTmp=="0"){
            if(rotatetTmp==""){
                qDebug()<<"=imgList=000==";
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap(urlTmp).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation));
            }else{
                qDebug()<<"=imgList=111==";
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap(urlTmp).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }else if(reversalTmp=="1"){
            if(rotatetTmp==""){
                qDebug()<<"=imgList=222==";
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap::fromImage(QImage(urlTmp).mirrored(true, false)).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation));
            }else{
                qDebug()<<"=imgList=333==";
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap::fromImage(QImage(urlTmp).mirrored(true, false)).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }        
    }

    for(int j = 0; j<textList.length();j++){
        QString strTextTmp=textList.at(j);
        out<<strTextTmp<<endl;
        QStringList strlTmp = strTextTmp.split("=");
        QString xTmp = this->processingString(strlTmp.at(1));
        QString yTmp = this->processingString(strlTmp.at(2));
        QString widhtTmp = this->processingString(strlTmp.at(3));
        QString heightTmp = this->processingString(strlTmp.at(4));
        QString rotatetTmp = this->processingString(strlTmp.at(5));
        QString textTmp = strlTmp.at(6);
        QString scaleTmp = strlTmp.at(7);
        QString typeTmp = strlTmp.at(9);

        qDebug()<<"=makeStaticImage=typeTmp=="+ typeTmp;

        qDebug()<<"=textList=111=size="<<size;
        qDebug()<<"=textList=111=textTmp="<<textTmp;
        qDebug()<<"=textList=111=widhtTmp.toInt()/size="<<widhtTmp.toInt();
        qDebug()<<"=textList=111=heightTmp.toInt()/size="<<heightTmp.toInt();
        qDebug()<<"=textList=111=scaleTmp="<<scaleTmp;
        qDebug()<<"=textList=111=rotatetTmp="<<rotatetTmp;

        if(rotatetTmp==""){
            qDebug()<<"=textList=111=="<<rotatetTmp.toInt();
            QFont font;
            font.setPixelSize(30);
            paint.setFont(font);
            paint.drawText(xTmp.toInt()+20,yTmp.toInt()+40,textTmp);
        }else{
            qDebug()<<"=textList=222=="<<rotatetTmp.toInt();
            QFont font;
            double pixesize = 30;
            pixesize = pixesize*scaleTmp.toDouble();
            int pixesizeInt = (int)pixesize;
            qDebug()<<"=textList=222=pixesizeInt="<<pixesizeInt;
            font.setPixelSize(pixesizeInt);//30*scaleTmp.toInt()
            paint.setFont(font);
            paint.drawText(xTmp.toInt(),yTmp.toInt(),"aaa");
            int rotateNumber = 0;
            rotateNumber = rotatetTmp.toInt();
            rotateNumber = rotateNumber%360;
//            if(rotateNumber<0){
//                rotateNumber = 360 + rotateNumber;
//            }
            paint.translate(xTmp.toInt(),yTmp.toInt());
            paint.rotate(rotateNumber);
            paint.drawText(0,0,textTmp);
            paint.rotate(-rotateNumber);
            paint.translate(-xTmp.toInt(),-yTmp.toInt());
            paint.drawText(xTmp.toInt(),yTmp.toInt(),"bbb");
            qDebug()<<"=textList=222=rotateNumber="<<rotateNumber;
        }
    }

    QString returnStr = "/data/home/user/DCIM/Camera/"+nameTmp+".jpg";
    QString localSaveStr = path+"/"+nameTmp+".jpg";
    qDebug()<<"==localSaveStr=="+ localSaveStr;
    pix->scaled(pix->width()/size,pix->height()/size,Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation);
    pix->save(returnStr);
    pix->save(localSaveStr);

    out.flush();
    file.close();

    return returnStr;
}

QString MakeImage::makeStaticModifyImage(QString imageName,int size,int Bgwidht,int Bgheight,const QStringList &imgList,const QStringList &textList){

    QString path;
    QDir dir;
    path=dir.currentPath();
    QString cmd = "";
    cmd = "rm -rf "+path+"/"+imageName+".jpg;"+"rm -rf "+path+"/"+imageName+"/"+imageName+".txt";
    qDebug()<<"==cmd=="+ cmd;
    QString returnStr = "/data/home/user/DCIM/Camera/"+imageName+".jpg";
    QString localSaveStr = path+"/"+imageName+".jpg";

    char*  ch;
    QByteArray ba = cmd.toLatin1();
    ch=ba.data();
    system(ch);

    QFile file(path+"/"+imageName+"/"+imageName+".txt");
    if (!file.open(QIODevice::ReadWrite|QIODevice::Text)) {
        qDebug()<<"<<<<无法创建文件";
        return "error";
    }
    QTextStream out(&file);

    QPixmap *pix=new QPixmap(QSize(Bgwidht,Bgheight));
    pix->fill(Qt::white);
    QPainter paint(pix);
    for(int i = 0; i<imgList.length();i++){
        QString strTmp=imgList.at(i);

        QStringList strlTmp = strTmp.split("=");
        QString xTmp = this->processingString(strlTmp.at(1));
        QString yTmp = this->processingString(strlTmp.at(2));
        QString widhtTmp = this->processingString(strlTmp.at(3));
        QString heightTmp = this->processingString(strlTmp.at(4));
        QString rotatetTmp = this->processingString(strlTmp.at(5));
        QString urlTmp = strlTmp.at(6);
        QString reversalTmp = strlTmp.at(7);
        QString imagetypeTmp = strlTmp.at(8);
        QString typeTmp = strlTmp.at(9);
        qDebug()<<"=makeStaticModifyImage=typeTmp=="+ typeTmp;

        if(imagetypeTmp=="0"){
            urlTmp = urlTmp.mid(urlTmp.lastIndexOf("/"),urlTmp.length()-1);
            urlTmp = ":res"+urlTmp.mid(0,urlTmp.lastIndexOf("_"))+urlTmp;
            out<<strTmp<<endl;
        }else{
            QString outImageName = "";
            QString outImageUrl = "";
            outImageName = urlTmp.mid(urlTmp.lastIndexOf("/"),urlTmp.length()-1);
            outImageUrl = path+"/"+imageName+""+outImageName;
            qDebug()<<"==outImageUrl=="+ outImageUrl;
            out<<strTmp.replace(urlTmp,outImageUrl)<<endl;
            urlTmp = urlTmp.replace("file:","");
            qDebug()<<"==strTmp.replace(urlTmp,outImageUrl)=="+ strTmp.replace(urlTmp,outImageUrl);
            qDebug()<<"==urlTmp=="+ urlTmp;
            qDebug()<<"==outImageUrl=="+ outImageUrl;
            if(!QFile::copy(urlTmp, outImageUrl))
            {
                 qDebug()<<"拷贝失败";
            }
        }

        if(reversalTmp=="0"){
            if(rotatetTmp==""){
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap(urlTmp).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation));
            }else{
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap(urlTmp).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }else if(reversalTmp=="1"){
            if(rotatetTmp==""){
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap::fromImage(QImage(urlTmp).mirrored(true, false)).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation));
            }else{
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt(),yTmp.toInt(),QPixmap::fromImage(QImage(urlTmp).scaled(widhtTmp.toInt(),heightTmp.toInt(),Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation).mirrored(true, false)).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }
    }
    for(int j = 0; j<textList.length();j++){
        QString strTextTmp=textList.at(j);
        out<<strTextTmp<<endl;
        QStringList strlTmp = strTextTmp.split("=");
        QString xTmp = this->processingString(strlTmp.at(1));
        QString yTmp = this->processingString(strlTmp.at(2));
        QString widhtTmp = this->processingString(strlTmp.at(3));
        QString heightTmp = this->processingString(strlTmp.at(4));
        QString rotatetTmp = this->processingString(strlTmp.at(5));
        QString textTmp = strlTmp.at(6);
        QString scaleTmp = strlTmp.at(7);
        QString typeTmp = strlTmp.at(9);

        qDebug()<<"=makeStaticImage=typeTmp=="+ typeTmp;

        qDebug()<<"=textList=111=size="<<size;
        qDebug()<<"=textList=111=textTmp="<<textTmp;
        qDebug()<<"=textList=111=widhtTmp.toInt()/size="<<widhtTmp.toInt();
        qDebug()<<"=textList=111=heightTmp.toInt()/size="<<heightTmp.toInt();
        qDebug()<<"=textList=111=scaleTmp="<<scaleTmp;
        qDebug()<<"=textList=111=rotatetTmp="<<rotatetTmp;

        if(rotatetTmp==""){
            qDebug()<<"=textList=111=="<<rotatetTmp.toInt();
            QFont font;
            font.setPixelSize(30);
            paint.setFont(font);
            paint.drawText(xTmp.toInt()+20,yTmp.toInt()+40,textTmp);
        }else{
            qDebug()<<"=textList=222=="<<rotatetTmp.toInt();
            QFont font;
            double pixesize = 30;
            pixesize = pixesize*scaleTmp.toDouble();
            int pixesizeInt = (int)pixesize;
            qDebug()<<"=textList=222=pixesizeInt="<<pixesizeInt;
            font.setPixelSize(pixesizeInt);//30*scaleTmp.toInt()
            paint.setFont(font);
            paint.drawText(xTmp.toInt(),yTmp.toInt(),"aaa");
            int rotateNumber = 0;
            rotateNumber = rotatetTmp.toInt();
            rotateNumber = rotateNumber%360;
//            if(rotateNumber<0){
//                rotateNumber = 360 + rotateNumber;
//            }
            paint.translate(xTmp.toInt(),yTmp.toInt());
            paint.rotate(rotateNumber);
            paint.drawText(0,0,textTmp);
            paint.rotate(-rotateNumber);
            paint.translate(-xTmp.toInt(),-yTmp.toInt());
            paint.drawText(xTmp.toInt(),yTmp.toInt(),"bbb");
            qDebug()<<"=textList=222=rotateNumber="<<rotateNumber;
        }
    }
    pix->scaled(pix->width()/size,pix->height()/size,Qt::KeepAspectRatioByExpanding, Qt::SmoothTransformation);
    pix->save(returnStr);
    pix->save(localSaveStr);

    out.flush();
    file.close();

    return returnStr;
}

QString MakeImage::processingString(QString strTmp){
    QString returnValue = strTmp;
    returnValue = returnValue.left(returnValue.trimmed().indexOf("."));
//    qDebug()<<"=processingString=returnValue=="+returnValue;
    return returnValue;
}
