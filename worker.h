#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QImage>

class Worker : public QObject
{
    Q_OBJECT
public:
    explicit Worker(QString workingDir, QObject *parent = 0);

signals:
   void imageReadyForPrint();
   void imagePrinted();

public slots:
    void work();

private:
   QString m_workingDir;

private:
    QImage createImage();
    void printImage(QImage image);
};

#endif // WORKER_H
