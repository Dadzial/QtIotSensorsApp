#ifndef TEMPERATURESENSOR_H
#define TEMPERATURESENSOR_H
#include <qtimer.h>
#include <QObject>
#include <DataBaseManager.h>

class TemperatureSensor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int temperature READ getTemp NOTIFY tempChange)
public:
    explicit TemperatureSensor(QObject *parent = nullptr,DataBaseManager *dbManager=nullptr);
    int getTemp() const;
    Q_INVOKABLE void generateTemperature();

signals:
    void tempChange(int temperature);
private slots:
    void onTemperatureChange(int temperature);
private:
    int m_temp=0;
    QTimer *timer;
    DataBaseManager *t_dbManager;
};

#endif // TEMPERATURESENSOR_H
