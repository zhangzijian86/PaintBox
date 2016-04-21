#ifndef MAKEIMAGE_H
#define MAKEIMAGE_H

#include <QObject>
#include <QDebug>

class MakeImage : public QObject
{
    Q_OBJECT

public:
    explicit MakeImage(QObject *parent = 0);
    Q_INVOKABLE QString sendFaultReportRequest(const QStringList &imgList);
};

#endif // MAKEIMAGE_H
