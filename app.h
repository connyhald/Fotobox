#ifndef APP_H
#define APP_H

#include "worker.h"

#include <QObject>
#include <QImage>
#include <QThread>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = 0);

signals:


public slots:
    void createFinalImageAndPrint();

private:
    QString m_workingDir;
    QThread m_thread;
    Worker *m_worker;


};

#endif // APP_H
