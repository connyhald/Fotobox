#include "app.h"
#include "gpiomanager.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont("qrc:/fonts/Roboto-Light.ttf");
    QFontDatabase::addApplicationFont("qrc:/fonts/Roboto-Regular.ttf");
    QFontDatabase::addApplicationFont("qrc:/fonts/Roboto-Bold.ttf");

    GpioManager* gpio = GpioManager::instance();

    Backend backend;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("backend", &backend);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
