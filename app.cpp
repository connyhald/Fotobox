#include "app.h"
#include "worker.h"
#include "gpiomanager.h"

#include <QDebug>
#include <QTimer>

Backend::Backend(QObject *parent) : QObject(parent)
{
    m_workingDir = "/home/conny/tmp/fotobox/";

    // Setup the worker thread
    m_worker = new Worker(m_workingDir);
    m_worker->moveToThread(&m_thread);
    m_thread.start();

    // Connect GPIO stuff
    GpioManager *manager = GpioManager::instance();
    connect(manager, SIGNAL(pulsesReceived(int)), this, SLOT(onPulsesReceived(int)));
}

void Backend::createFinalImageAndPrint(QStringList paths)
{
    qDebug() << "PROCESSING:" << paths;

    m_worker->setPaths(paths);

    QTimer::singleShot(0, m_worker, SLOT(work(paths)));
}

void Backend::onPulsesReceived(int pulseCount)
{
    if (pulseCount == 10 || pulseCount == 11) {
        emit coinAccepted(100);
    } else {
        emit coinAccepted(200);
    }
}
