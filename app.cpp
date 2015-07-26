#include "app.h"
#include "worker.h"

#include <QDebug>
#include <QTimer>

Backend::Backend(QObject *parent) : QObject(parent)
{
    m_workingDir = "/home/conny/tmp/fotobox/";

    m_worker = new Worker(m_workingDir);
    m_worker->moveToThread(&m_thread);
    m_thread.start();
}

void Backend::createFinalImageAndPrint(QStringList paths)
{
    qDebug() << "PROCESSING:" << paths;

    m_worker->setPaths(paths);

    QTimer::singleShot(0, m_worker, SLOT(work(paths)));
}

