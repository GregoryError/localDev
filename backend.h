#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QFile>
#include <QDebug>
#include <QStringList>
#include <set>

class backend : public QObject
{
    Q_OBJECT
public:
    explicit backend(QObject *parent = nullptr);
    QStringList list;

private:
    QStringList listOfWords(const QString &word);
    QString formatter(const int &howManyInLine, const QString &separater, const QStringList &list);




signals:

public slots:
};

#endif // BACKEND_H
