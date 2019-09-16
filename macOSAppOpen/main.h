#ifndef MAIN_H
#define MAIN_H

#include <QApplication>

class MacOSApp : public QApplication
{
	Q_OBJECT
public:
	MacOSApp(int& argc, char** argv) : QApplication(argc, argv) {}

	bool event( QEvent* event ) override;
};

#endif // MAIN_H
