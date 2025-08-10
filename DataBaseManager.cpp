#include "DataBaseManager.h"
#include <QSqlError>
#include <QDebug>

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

void DataBaseManager::closeDataBase()
{
    if (db.isOpen())
        db.close();
}
