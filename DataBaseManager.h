#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QStringListModel>

class DataBaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DataBaseManager(QObject *parent = nullptr);
    ~DataBaseManager();

    Q_INVOKABLE QStringList getTemperatureHistory();
    Q_INVOKABLE bool deleteTempData();
    Q_INVOKABLE QStringListModel* temperatureModel();

    Q_INVOKABLE QStringList getAlarmsHistory();
    Q_INVOKABLE bool deleteAlarmsData();
    Q_INVOKABLE QStringListModel* AlarmsModel();

    Q_INVOKABLE QStringList getHumidityHistory();
    Q_INVOKABLE bool deleteHumidtyData();
    Q_INVOKABLE QStringListModel* HumidityModel();

    Q_INVOKABLE QStringList getHumidityAlarmHistory();
    Q_INVOKABLE bool deleteHumidtyAlarmData();
    Q_INVOKABLE QStringListModel* HumidityAlarmModel();

    bool openDataBase(const QString &path);

    bool createTemperatureTable();
    bool insertTempData(const QString &temp);

    bool createAlarmsTable();
    bool insertAlarmsData(const QString &alarm);

    bool createHumidityTable();
    bool insertHumidityData(const QString &humidity);

    bool createHumidityAlarmTable();
    bool insertHumidityAlarmData(const QString &humidityAlarm);


    void closeDataBase();
private:
    QSqlDatabase db;
    QStringListModel m_temperatureModel;
    QStringListModel m_alarmModel;
    QStringListModel m_humidityModel;
    QStringListModel m_humidtyAlarmModel;

    void updateTemperatureModel();
    void updateAlarmsModel();
    void updateHumidityModel();
    void updateHumidityAlarmModel();
};

#endif // DATABASEMANAGER_H
