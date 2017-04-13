#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QProcess>
#include <QQmlContext>

class ProcessStarter : public QProcess {
    Q_OBJECT
public slots:
    void run(const QString &application) {
        startDetached(application);
    }
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    ProcessStarter starter;
    engine.rootContext()->setContextProperty("starter", &starter);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}

#include "main.moc"
