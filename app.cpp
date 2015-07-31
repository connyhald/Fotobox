#include "app.h"
#include "worker.h"
#include "gpiomanager.h"

#include <QDebug>
#include <QTimer>
#include <QStandardPaths>

Backend::Backend(QObject *parent) : QObject(parent)
{
    // TODO: Crashes if empty list is returned. Fix.
    qDebug() << "Picture loc:" << QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);
    m_workingDir = QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);

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
    if (pulseCount <= 2) {
        emit coinAccepted(50);
        return;
    } else if (pulseCount <= 4) {
        emit coinAccepted(100);
        return;
    } else {
        emit coinAccepted(200);
    }
}
