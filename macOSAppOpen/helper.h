#ifndef HELPER_H
#define HELPER_H

#include <QObject>

class Helper : public QObject
{
	Q_OBJECT

	Q_PROPERTY(QString testMessage READ testMessage WRITE setTestMessage NOTIFY testMessageChanged)
public:
	explicit Helper(QObject *parent = nullptr);

	void setTestMessage(const QString &msg) {
		if (msg == m_testMessage) return;
		m_testMessage = msg;
		emit testMessageChanged();
	}

	QString testMessage() const { return m_testMessage; }

signals:
	void testMessageChanged();

private:
	QString m_testMessage;
};

extern Helper g_helper; // It is a simple test program

#endif // HELPER_H
