#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <HumiditySensor.h>
#include <TemperatureSensor.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    TemperatureSensor tempSensor;
    HumiditySensor humiditySensor;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("tempSensor", &tempSensor);
    engine.rootContext()->setContextProperty("humiditySensor", &humiditySensor);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("IotAppSensors", "Main");

    return app.exec();
}
