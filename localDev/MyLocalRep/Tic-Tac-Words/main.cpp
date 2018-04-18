#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "backend.h"


int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;

    QQmlContext *cont;

    cont = engine.rootContext();

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    backend *obj = new backend;


    cont->setContextProperty("backend", obj);


    return app.exec();
}
