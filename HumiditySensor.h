#ifndef HUMIDITYSENSOR_H
#define HUMIDITYSENSOR_H
#include "qtimer.h"
#include <QObject>
#include <DataBaseManager.h>

class HumiditySensor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int humidity READ getHumidity NOTIFY humidityChange)
public:
    explicit HumiditySensor(QObject *parent = nullptr,DataBaseManager *dbManager=nullptr);
    int getHumidity() const;
    Q_INVOKABLE void generateHumidity();

signals:
    void humidityChange(int humidity);
private slots:
    void onHumidityChange(int humidity);
private:
    int m_humidity = 0;
    QTimer *timer;
    DataBaseManager *t_dbManager;
};

#endif // HUMIDITYSENSOR_H
