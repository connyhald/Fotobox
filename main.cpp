#include "app.h"
#include "gpiomanager.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFontDatabase>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qDebug() << "STARTING";

    qDebug() << QFontDatabase::addApplicationFont(":/fonts/Roboto-Light.ttf");
    qDebug() << QFontDatabase::addApplicationFont(":/fonts/Roboto-Regular.ttf");
    qDebug() << QFontDatabase::addApplicationFont(":/fonts/Roboto-Bold.ttf");

    QFontDatabase db;

    qDebug() << "Available fonts:" << db.families();

    Backend backend;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("backend", &backend);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
