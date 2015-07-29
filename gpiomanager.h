#ifndef GPIO_H
#define GPIO_H

#include <QObject>

class GpioManager : public QObject
{
    Q_OBJECT

public:
    static GpioManager* instance();

signals:
    // void pinClosed() // oder so

private:
    static GpioManager* m_instance;

private:
    explicit GpioManager(QObject *parent = 0);
    static void handleInterrupt();


};


#endif // GPIO_H
