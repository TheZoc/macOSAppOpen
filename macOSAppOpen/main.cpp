#include <QApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFileOpenEvent>
#include <QDebug>

#include "main.h"
#include "helper.h"


Helper g_helper; // It is a simple test program

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	MacOSApp app(argc, argv);

	g_helper.setTestMessage("Nothing set");

	QQmlApplicationEngine engine;
	engine.rootContext()->setContextProperty("helper", &g_helper);

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(	&engine,
						&QQmlApplicationEngine::objectCreated,
						&app,
						[url](QObject *obj, const QUrl &objUrl)
						{
							if (!obj && url == objUrl)
								QCoreApplication::exit(-1);
						},
						Qt::QueuedConnection);
	engine.load(url);

	return app.exec();
}

bool MacOSApp::event(QEvent* event)
{
	switch ( event->type() )
	{
	case QEvent::FileOpen:
	{
		QFileOpenEvent* openEvent = static_cast<QFileOpenEvent*>(event);
		auto file_url = openEvent->url();
		qDebug() << "Open file: " << file_url;

		g_helper.setTestMessage(file_url.toString());

		break;
	}
	default:
		break;
	}

	return QApplication::event(event);
}
