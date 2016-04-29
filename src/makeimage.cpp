#include "makeimage.h"

MakeImage::MakeImage(QObject *parent):QObject(parent)
{
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


QString MakeImage::makeStaticImage(int size,int Bgwidht,int Bgheight,const QStringList &imgList){
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

    QFile file(pathTmp+"/"+nameTmp+".txt");
    if (!file.open(QIODevice::WriteOnly|QIODevice::Text)) {
        qDebug()<<"<<<<无法创建文件";
        return "error";
    }
    QTextStream out(&file);

    QPixmap *pix=new QPixmap(QSize(Bgwidht/size,Bgheight/size));
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

        if(reversalTmp=="0"){
            if(rotatetTmp==""){
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap(urlTmp));
            }else{
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap(urlTmp).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }else if(reversalTmp=="1"){
            if(rotatetTmp==""){
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap::fromImage(QImage(urlTmp).mirrored(true, false)));
            }else{
                QMatrix leftmatrix;
                leftmatrix.rotate(rotatetTmp.toInt());
                paint.drawPixmap(xTmp.toInt()/size,yTmp.toInt()/size,widhtTmp.toInt()/size,heightTmp.toInt()/size,QPixmap::fromImage(QImage(urlTmp).mirrored(true, false)).transformed(leftmatrix,Qt::SmoothTransformation));
            }
        }        
    }

    QString returnStr = "/data/home/user/DCIM/Camera/"+nameTmp+".jpg";
    QString localSaveStr = path+"/"+nameTmp+".jpg";
    qDebug()<<"==localSaveStr=="+ localSaveStr;
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
