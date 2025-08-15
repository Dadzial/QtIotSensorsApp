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

    bool openDataBase(const QString &path);

    bool createTemperatureTable();
    bool insertTempData(const QString &temp);

    bool createAlarmsTable();
    bool insertAlarmsData(const QString &alarm);


    void closeDataBase();

signals:
    void temperatureHistoryChanged();

private:
    QSqlDatabase db;
    QStringListModel m_temperatureModel;
    QStringListModel m_alarmModel;

    void updateTemperatureModel();
    void updateAlarmsModel();
};

#endif // DATABASEMANAGER_H
