#include "backend.h"

backend::backend(QObject *parent) : QObject(parent)
{

//==================================================================================
    QFile in(":/ENGRUS.txt");

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
                str += c;
            }

            if(i % 2 == 0)
            {
                list.push_back(str);
            }else
                listTransl.push_back(str);
            ++i;
        }

        unsigned long int t = 0;
        for(auto &c:list)
        {
            dictionary.insert(c, listTransl[t++]);
        }
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
            }

++pos;
       }
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

void backend::clearTyped()
{
    typedWord.clear();
}

QString backend::checkIfRight()
{

    QString strtemp = dictionary.value(typedWord);
    if(!strtemp.isEmpty() && typedWord != startWord)
    {
        userWords.push_back(strtemp);
        return formatter(1, "<br>", strtemp);
    } if(typedWord == startWord)
        return "same";
                else return "null";

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
    typedWord.clear();

    timesWordCall = 0;
    points = 0;
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

void backend::findWordList()                  // just start process of findind possible words
{
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
        ++points;
        return true;
    }else return false;
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































