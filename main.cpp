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

    DataBaseManager dbManager;
    if (!dbManager.openDataBase("sensors_dataBase.sqlite")) {
        qWarning() << "Not Connected";
        return -1;
    } else {
        qDebug() << "Connected";
    }
    dbManager.createTemperatureTable();
    dbManager.createAlarmsTable();
    dbManager.createHumidityTable();
    dbManager.createHumidityAlarmTable();

    TemperatureSensor tempSensor(nullptr, &dbManager);
    HumiditySensor humiditySensor(nullptr, &dbManager);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("tempSensor", &tempSensor);
    engine.rootContext()->setContextProperty("humiditySensor", &humiditySensor);
    engine.rootContext()->setContextProperty("temperatureModel", dbManager.temperatureModel());
    engine.rootContext()->setContextProperty("alarmsModel", dbManager.AlarmsModel());
    engine.rootContext()->setContextProperty("humidityModel",dbManager.HumidityModel());
    engine.rootContext()->setContextProperty("humidityAlarmModel" ,dbManager.HumidityAlarmModel());
    engine.rootContext()->setContextProperty("dbManager", &dbManager);


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("IotAppSensors", "Main");

    return app.exec();
}
