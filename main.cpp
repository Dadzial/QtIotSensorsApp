#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <HumiditySensor.h>
#include <TemperatureSensor.h>
#include <DataBaseManager.h>
#include <QQmlContext>
#include <QDebug>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    TemperatureSensor tempSensor;
    HumiditySensor humiditySensor;
    DataBaseManager dbManager;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("tempSensor", &tempSensor);
    engine.rootContext()->setContextProperty("humiditySensor", &humiditySensor);
    engine.rootContext()->setContextProperty("dbManager",&dbManager);

    if (!dbManager.openDataBase("sensors_dataBase.sqlite")) {
        qWarning() << "Not Connected";
        return -1;
    } else {
        qDebug() << "Connected";
    }

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("IotAppSensors", "Main");

    return app.exec();
}
