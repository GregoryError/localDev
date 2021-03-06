#include "backend.h"


backend::backend(QObject *parent) : QObject(parent)
{

    effect = new QSoundEffect;

    effect_bad = new QSoundEffect;
    effect_bad->setSource(QUrl::fromLocalFile(":/zumer.wav"));
    effect_bad->setVolume(0.40f);

//==================================================================================
    QFile in(":/ENG.txt");

    if (!in.open(QIODevice::ReadOnly | QIODevice::Text))
     {
          qDebug() << "Unable to read the file.";

     }else{
          qDebug() << "Open file.... ok";

        int i = 0;
        while (!in.atEnd()) {

            QString tmp = in.readLine();
            QString str;

            for(auto &c:tmp)
            {
                if(c == "\n")
                    break;
                str += c.toLower();
            }

           // if(i % 2 == 0)
           // {
                list.push_back(str);
            //}else
            //    listTransl.push_back(str);
            ++i;
        }

        //unsigned long int t = 0;
       // for(auto &c:list)
       // {
       //     dictionary.insert(c, listTransl[t++]);
       // }
    }


    //qDebug() << "Словарь для подбора прочитан в память.";
    //qDebug() << dictionary.value("mankind");
    in.close();
//===================================================================================

 //  qDebug() << list[randomBetween(0, list.size())];
    ready = true;

}


QStringList backend::listOfWords(const QString &word)       // This method gets word, returns all of possible words that this word include in
{
    short i;

    QStringList answer;

    long int pos(0);

    while (pos != list.size()) {

         i = 0;

         std::multiset<QChar> s;
         s.insert(word.begin(), word.end());

         QString str;

         str = list[pos];

         for(auto &c:str)
         {
             if(s.find(c) != s.end())
             {
                 s.erase(s.find(c));
                 ++i;
             }
         }

            if(i != 1 && i == str.length() && str != word)
            {
                answer.push_back(str);
                //qDebug() << str;
            }

++pos;
       }
    possiblePoints = answer.size();
    return answer;

}

QString backend::formatter(const int &howManyInLine, const QString &separater, const QStringList &list)  //this guy formats text by setted separator, each setted word
{
    QString answer;

    int counter(0);

    for(auto &c:list)
    {
         ++counter;
        answer += ' ';
        for(auto &d:c)
        {
            if(counter == howManyInLine)
            {
                answer += separater;
                counter = 0;
            }
            answer += d;
        }
    }
    return answer;
}

QString backend::formatter(const int &howManyInLine, const QString &separater, const QString &list)  //this guy formats text by setted separator, each setted word
{
    QString answer;

    int counter(0);

    for(auto &c:list)
    {
       if(c == ' ' || c == '\n' || c == '\t')
       {
           ++counter;
       }
       if(counter == howManyInLine)
       {
           answer += separater;
           counter = 0;
       }
       answer += c;

    }
    return answer;
}

int backend::randomBetween(int low, int high)
{
    qsrand(QDateTime::currentMSecsSinceEpoch());
    return (qrand() % ((high + 1) - low) + low);
}

void backend::playNext()
{
    effect->setSource(QUrl::fromLocalFile(":/test.wav"));
    effect->setVolume(0.60f);
    effect->play();
}

void backend::playRight()
{

    effect->setSource(QUrl::fromLocalFile(":/rightSound.wav"));
    effect->setVolume(0.80f);
    effect->play();
}

QString backend::showSessionPercent()
{
    auto all(possiblePoints);
    auto session(sessionpoints);
    //QString str = QString::number((all / 100) * session) + "%"
    return QString::number((all / 100) * session) + "%";
}

QString backend::showPointsPercent()
{
    auto all(possiblePoints);
    auto session(points);
    //QString str = QString::number((all / 100) * session) + "%"
    return QString::number((all / 100) * session) + "%";
}

QString backend::showPossiblePoints()
{
    return QString::number(possiblePoints);
}

QString backend::showSessionPoints()
{
    return QString::number(sessionpoints);
}

QString backend::showPoints()
{
    return QString::number(points);
}

QString backend::userAnswers()
{
    return "Your answers: <br>" + formatter(1, "<br>", userWords) + "<br><br>"
            "All possible answers: <br>" + formatter(1, "<br>", subList) ;

}

QString backend::showLast()
{
    return lastWord;
}

void backend::clearTyped()
{
    typedWord.clear();
}


void backend::findWordList()                  // just start process of findind possible words
{
    wordSet.clear();
    subList = listOfWords(startWord);
    wordSet.insert(subList.begin(), subList.end());
   // return true;
}

bool backend::isRightWord(QString &word)      // returns true if passed word exist in a list of all possible words
{
    if(wordSet.find(word) != wordSet.end())
    {
        wordSet.erase(wordSet.find(word));
        userWords.push_back(word);
        playRight();
        ++points;
        ++sessionpoints;
        return true;

    }else
    {
       // effect_bad->play();
        return false;
    }
}


QString backend::checkIfRight()
{  

    if(isRightWord(typedWord))
    {
        //QString strtemp = dictionary.value(typedWord);
        lastWord = typedWord; // + ":<br>" + formatter(1, "<br>", strtemp);
        return lastWord;
    }else

        if(typedWord == startWord || wordSet.find(typedWord) != wordSet.end())
        {

            return "same";
        }
            else
            return "null";


}



void backend::typeing(QString ch)
{
    typedWord += ch;
}

bool backend::readyWork()
{
    return ready;
}

void backend::initWord()
{
   // qDebug() << "Проверим буфер: " + typedWord;
    userWords.clear();
    typedWord.clear();

    timesWordCall = 0;
    sessionpoints = 0;
    possiblePoints = 0;
    startWord = list[randomBetween(0, list.size())];
}

int backend::howManyLetter()
{
    return startWord.length();
}

QChar backend::gimmeLetter()
{
    if(timesWordCall != startWord.length())
    {
       return startWord[timesWordCall++];
    }
    else return ' ';;
}


QString backend::showUserAnswers()           // this shows only player answers with translations and formatted
{
    QString answer;
    int i(0);
    while(i != userWords.size())
    {
        answer += userWords[i] + " " + dictionary.value(userWords[i]);
        ++i;
    }
    return formatter(3, "<br>", answer);
}

QString backend::showRestOfAnswers()
{
    QString answer;
    int i(0);
    while(i != subList.size())
    {
        if(subList[i] != userWords[i])
        answer += subList[i] + " " + dictionary.value(subList[i]);
        ++i;
    }
    return formatter(3, "<br>", answer);
}































