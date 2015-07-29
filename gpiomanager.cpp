#include "gpiomanager.h"

#include <QDebug>
#include <QDateTime>
#include <wiringPi.h>

GpioManager * GpioManager::m_instance = 0;

/*
 * With our coin acceptor the time between two rising edges is about 130ms
 * using the 'fast' setting. So if we would use 30 pulses, which is the
 * maximum we would need to wait about 4 sec to read in all pulses.
 *
 * We will should use a maximum of 6 to 10 pulses.
 */

GpioManager::GpioManager(QObject *parent) : QObject(parent)
{
    m_pulseCount = 0;

    // If we do not get the next pulse within 200ms, we will stop counting and report the result
    m_timer.setInterval(200);
    m_timer.setSingleShot(true);
    connect(&m_timer, SIGNAL(timeout()), this, SLOT(onTimeout()));

    // Setup wiringPi
    //if (wiringPiSetup() < 0) {
    if (wiringPiSetupSys() < 0) {
        qWarning() << "Unable to setup wiringPi";
        return;
    }

    // GPIO 27 -> PIN 2
    //if (wiringPiISR (2, INT_EDGE_RISING, &handleInterrupt) < 0) {
    if (wiringPiISR (27, INT_EDGE_RISING, &handleInterrupt) < 0) {
        qWarning() << "Unable to setup ISR";
        return;
    }
}

GpioManager* GpioManager::instance() {
    if (m_instance == 0) {
        m_instance = new GpioManager();
    }
    return m_instance;
}

// Static called from a thread originally created by wireingpi
void GpioManager::handleInterrupt() {
    qDebug() << "Got a pulse:" << QDateTime::currentDateTime().time();
    // Using a QTimer to get the method executed in the right thread
    QTimer::singleShot(0, m_instance, SLOT(countAndSetTimeout()));
}

void GpioManager::countAndSetTimeout() {
    // Count pulse and start or restart timeout timer
    m_pulseCount++;
    m_timer.start();
}

void GpioManager::onTimeout() {
    qDebug() << "Got timeout" << QDateTime::currentDateTime().time();
    qDebug() << "Until now we counted" << m_pulseCount << "pulses";
    emit pulsesReceived(m_pulseCount);
    m_pulseCount = 0;
}
