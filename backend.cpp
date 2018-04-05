#include "backend.h"

backend::backend(QObject *parent) : QObject(parent)
{
    QFile in(":/ENRUS");

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
            qDebug() << str;
            }

            ++i;
        }


    }

    qDebug() << "Словарь для подбора прочитан в память.";
    in.close();


}

QStringList backend::listOfWords(QString &word)       // This method gets word, returns all of possible words that this word include in
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
                qDebug() << str;

            }

++pos;
       }
    return answer;

}

QString backend::formatter(const int &howManyInLine, const QString &separater, const QStringList &list)
{


}






































