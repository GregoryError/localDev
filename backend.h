#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QFile>
#include <QDebug>
#include <QStringList>
#include <set>
#include <QDateTime>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QMap>

class backend : public QObject
{
    Q_OBJECT
public:
    explicit backend(QObject *parent = nullptr);
    QStringList list, listTransl, subList, userWords;
    QMap<QString, QString> dictionary;
    std::set<QString> wordSet;
    QString startWord;
    int timesWordCall;
    unsigned int points;
    bool ready = false;
    QString typedWord;


private:
    QStringList listOfWords(const QString &word);
    QString formatter(const int &howManyInLine, const QString &separater, const QStringList &list);
    QString formatter(const int &howManyInLine, const QString &separater, const QString &list);
    int randomBetween(int low, int high);




signals:

public slots:
    void clearTyped();
    QString checkIfRight();
    void typeing(QString ch);
    bool readyWork();
    void initWord();
    int howManyLetter();
    QChar gimmeLetter();
    void findWordList();
    bool isRightWord(QString &word);
    QString showUserAnswers();
    QString showRestOfAnswers();

};

#endif // BACKEND_H
