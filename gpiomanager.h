#ifndef GPIO_H
#define GPIO_H

#include <QObject>
#include <QTimer>

class GpioManager : public QObject
{
    Q_OBJECT

public:
    static GpioManager* instance();

signals:
    void pulsesReceived(int pulseCount);

private slots:
    void countAndSetTimeout();
    void onTimeout();

private:
    static GpioManager* m_instance;
    int m_pulseCount;
    QTimer m_timer;

private:
    explicit GpioManager(QObject *parent = 0);
    static void handleInterrupt();
    static void handleReboot();


};


#endif // GPIO_H
