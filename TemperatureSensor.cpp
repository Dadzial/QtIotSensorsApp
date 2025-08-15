#include "TemperatureSensor.h"
#include <QTimer>
#include <QDebug>
#include <QRandomGenerator>

TemperatureSensor::TemperatureSensor(QObject *parent, DataBaseManager *dbManager) : QObject{parent}, m_temp(0), t_dbManager(dbManager)
{
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &TemperatureSensor::generateTemperature);
    timer->start(2000);
    connect(this,&TemperatureSensor::tempChange,this,&TemperatureSensor::onTemperatureChange);
}

int TemperatureSensor::getTemp() const
{
    return m_temp;
}

void TemperatureSensor::generateTemperature()
{
    int newTemperature = QRandomGenerator::global()->bounded(101);
    if(newTemperature != m_temp){
        m_temp = newTemperature;
        emit tempChange(m_temp);
    }
}

void TemperatureSensor::onTemperatureChange(int temperature)
{
    qDebug() << "Temperature is change:" << temperature;
    if(t_dbManager){
        t_dbManager->insertTempData(QString::number(temperature));
    }

    if(temperature >= 20) {
        t_dbManager->insertAlarmsData(QString::number(temperature));
    }
}


