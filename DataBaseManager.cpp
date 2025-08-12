#include "DataBaseManager.h"
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>

DataBaseManager::DataBaseManager(QObject *parent): QObject{parent}{}

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
    }else{
        qDebug() << "Table was created" ;
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
    }else{
        qDebug() << "insert is complete" ;
        return true;
    }

}

bool DataBaseManager::deleteTempData()
{
    QSqlQuery query("DELETE FROM temperature");
    if (!query.exec()) {
        qDebug() << "Delete error:" << query.lastError().text();
        return false;
    }else{
        qDebug() << "delete is complete" ;
        return true;
    }
}

void DataBaseManager::closeDataBase()
{
    if (db.isOpen())
        db.close();
}
