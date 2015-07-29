#include "gpiomanager.h"

#include <QDebug>
#include <QDateTime>
#include <wiringPi.h>

GpioManager * GpioManager::m_instance = 0;

GpioManager::GpioManager(QObject *parent) : QObject(parent)
{
    if (wiringPiSetup() < 0) {
        qDebug() << "Unable to setup wiringPi";
        return;
    }

    // GPIO 27 -> PIN 2
    if (wiringPiISR (2, INT_EDGE_RISING, &handleInterrupt) < 0) {
        qDebug() << "Unable to setup ISR";
        return;
    }
}

GpioManager* GpioManager::instance() {
    if (m_instance == 0) {
        m_instance = new GpioManager();
    }
    return m_instance;
}

void GpioManager::handleInterrupt() {
    qDebug() << "INT INT INT" << QDateTime::currentDateTime();
    // TODO: Emit signal
}
