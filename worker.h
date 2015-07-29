#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QImage>
#include <QStringList>

class Worker : public QObject
{
    Q_OBJECT
public:
    explicit Worker(QString workingDir, QObject *parent = 0);

    void setPaths(QStringList paths);

signals:
   //void imageReadyForPrint();
   //void imagePrinted();

public slots:
    void work();

private:
   QString m_workingDir;
   QStringList m_paths;

private:
    QImage createImage();
    void printImage(QImage image);
};

#endif // WORKER_H
