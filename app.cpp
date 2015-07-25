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

void Backend::createFinalImageAndPrint()
{
    QTimer::singleShot(0, m_worker, SLOT(work()));
}

