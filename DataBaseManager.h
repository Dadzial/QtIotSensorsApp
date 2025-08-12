#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
class DataBaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DataBaseManager(QObject *parent = nullptr);
    ~DataBaseManager();

    bool openDataBase(const QString &path);
    bool createTemperatureTable();
    bool insertTempData(const QString &temp);
    bool deleteTempData();
    void closeDataBase();

private:
    QSqlDatabase db;

signals:
};

#endif // DATABASEMANAGER_H
