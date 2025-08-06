#include "TemperatureSensor.h"
#include <QTimer>
#include <QDebug>
#include <QRandomGenerator>

TemperatureSensor::TemperatureSensor(QObject *parent): QObject{parent}, m_temp(0)
{
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &TemperatureSensor::generateTemperature);
    timer->start(2000);
    connect(this,&TemperatureSensor::tempChange,this,&TemperatureSensor::onTemperatureChange);
}

int TemperatureSensor::getTemp() const
{
    return my_temp;
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
    qDebug() << "Humidity is change:" << temperature;
}


