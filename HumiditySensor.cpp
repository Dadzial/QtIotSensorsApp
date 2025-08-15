#include "HumiditySensor.h"
#include <QTimer>
#include <QDebug>
#include <QRandomGenerator>

HumiditySensor::HumiditySensor(QObject *parent , DataBaseManager *dbManager): QObject{parent}, m_humidity(0) ,t_dbManager(dbManager)
{
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &HumiditySensor::generateHumidity);
    timer->start(2000);
    connect(this, &HumiditySensor::humidityChange, this, &HumiditySensor::onHumidityChange);
}

int HumiditySensor::getHumidity() const
{
    return m_humidity;
}

void HumiditySensor::generateHumidity()
{
    int newHumidity = QRandomGenerator::global()->bounded(101);
    if (newHumidity != m_humidity) {
        m_humidity = newHumidity;
        emit humidityChange(m_humidity);
    }
}

void HumiditySensor::onHumidityChange(int humidity)
{
    qDebug() << "Humidity is change:" << humidity;

    if(t_dbManager){
        t_dbManager->insertHumidityData(QString::number(humidity));
    }

    if(humidity >= 40) {
        t_dbManager->insertHumidityAlarmData(QString::number(humidity));
    }
}
