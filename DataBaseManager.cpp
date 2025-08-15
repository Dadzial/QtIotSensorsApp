#include "DataBaseManager.h"
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>

DataBaseManager::DataBaseManager(QObject *parent)
    : QObject{parent}
{
}

DataBaseManager::~DataBaseManager()
{
    if(db.isOpen()){
        db.close();
    }
}

bool DataBaseManager::openDataBase(const QString &path)
{
    if (QSqlDatabase::contains("qt_sql_default_connection"))
        db = QSqlDatabase::database("qt_sql_default_connection");
    else
        db = QSqlDatabase::addDatabase("QSQLITE");

    db.setDatabaseName(path);

    if (!db.open()) {
        qDebug() << "Database error: " << db.lastError().text();
        return false;
    }
    return true;
}

bool DataBaseManager::createTemperatureTable()
{
    QSqlQuery query;
    QString sql =
        "CREATE TABLE IF NOT EXISTS temperature ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "value TEXT NOT NULL, "
        "timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)";
    if (!query.exec(sql)) {
        qDebug() << "create table error" << query.lastError().text();
        return false;
    } else {
        qDebug() << "Table was created";
        return true;
    }
}

bool DataBaseManager::insertTempData(const QString &temp)
{
    QSqlQuery query;
    query.prepare("INSERT INTO temperature (value) VALUES (:temp)");
    query.bindValue(":temp", temp);

    if (!query.exec()) {
        qDebug() << "Insert error:" << query.lastError().text();
        return false;
    } else {
        qDebug() << "insert is complete";
        updateTemperatureModel();
        return true;
    }
}

QStringList DataBaseManager::getTemperatureHistory()
{
    QStringList list;
    QSqlQuery query("SELECT value, timestamp FROM temperature ORDER BY timestamp DESC");
    while (query.next()) {
        QString value = query.value(0).toString();
        QString timestamp = query.value(1).toString();
        list << QString("%1 : %2").arg(timestamp, value);
    }
    return list;
}

QStringListModel* DataBaseManager::temperatureModel()
{
    updateTemperatureModel();
    return &m_temperatureModel;
}

void DataBaseManager::updateTemperatureModel()
{
    m_temperatureModel.setStringList(getTemperatureHistory());
    emit temperatureHistoryChanged();
}

bool DataBaseManager::deleteTempData()
{
    QSqlQuery query("DELETE FROM temperature");
    if (!query.exec()) {
        qDebug() << "Delete error:" << query.lastError().text();
        return false;
    } else {
        qDebug() << "delete is complete";
        updateTemperatureModel();
        return true;
    }
}

//Alarms table

bool DataBaseManager::createAlarmsTable()
{
    QSqlQuery query;
    query.exec("DROP TABLE IF EXISTS alarms");

    QString sql =
        "CREATE TABLE alarms ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "value TEXT NOT NULL, "
        "timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)";
    if (!query.exec(sql)) {
        qDebug() << "create alarms table error" << query.lastError().text();
        return false;
    }
    qDebug() << "Alarms table was created";
    return true;
}

bool DataBaseManager::insertAlarmsData(const QString &alarm)
{
    QSqlQuery query;
    query.prepare("INSERT INTO alarms (value) VALUES (:alarm)");
    query.bindValue(":alarm", alarm);

    if (!query.exec()) {
        qDebug() << "Insert alarms error:" << query.lastError().text();
        return false;
    } else {
        qDebug() << "Alarm insert complete";
        updateAlarmsModel();
        return true;
    }
}

QStringList DataBaseManager::getAlarmsHistory()
{
    QStringList list;
    QSqlQuery query("SELECT value, timestamp FROM alarms ORDER BY timestamp DESC");
    while (query.next()) {
        QString value = query.value(0).toString();
        QString timestamp = query.value(1).toString();
        list << QString("%1 : %2").arg(timestamp, value);
    }
    return list;
}

QStringListModel* DataBaseManager::AlarmsModel()
{
    updateAlarmsModel();
    return &m_alarmModel;
}

void DataBaseManager::updateAlarmsModel()
{
    m_alarmModel.setStringList(getAlarmsHistory());
}

bool DataBaseManager::deleteAlarmsData()
{
    QSqlQuery query("DELETE FROM alarms");
    if (!query.exec()) {
        qDebug() << "Delete alarms error:" << query.lastError().text();
        return false;
    } else {
        qDebug() << "All alarms deleted";
        updateAlarmsModel();
        return true;
    }
}

void DataBaseManager::closeDataBase()
{
    if (db.isOpen())
        db.close();
}
