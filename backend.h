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

#include <QSoundEffect>




class backend : public QObject
{
    Q_OBJECT
public:
    explicit backend(QObject *parent = nullptr);
    QStringList list, listTransl, subList, userWords;
    QMap<QString, QString> dictionary;
    std::set<QString> wordSet;
    QString lastWord;
    QString startWord;
    int timesWordCall;
    unsigned int points = 0, sessionpoints = 0, possiblePoints = 0;
    bool ready = false;
    QString typedWord;
    QSoundEffect *effect;
    QSoundEffect *effect_bad;


private:
    QStringList listOfWords(const QString &word);
    QString formatter(const int &howManyInLine, const QString &separater, const QStringList &list);
    QString formatter(const int &howManyInLine, const QString &separater, const QString &list);
    int randomBetween(int low, int high);




signals:

public slots:
    void playNext();
    void playRight();

    QString showSessionPercent();
    QString showPointsPercent();
    QString showPossiblePoints();
    QString showSessionPoints();
    QString showPoints();
    QString userAnswers();
    QString showLast();
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
