#ifndef OTAUPDATE_H
#define OTAUPDATE_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <CommonAPI/CommonAPI.hpp>
#include <v0/commonapi/ICProxy.hpp>

using namespace v0::commonapi;

class OtaUpdate : public QObject {
    Q_OBJECT
    Q_PROPERTY(int updateRequestValue READ updateRequestValue WRITE setUpdateRequest NOTIFY updateNotify)
    Q_PROPERTY(int updateResponseValue READ updateResponseValue WRITE setUpdateResponse NOTIFY updateResponse)

public:
    explicit OtaUpdate(QObject *parent = nullptr);
    int updateRequestValue() const;
    Q_INVOKABLE void setUpdateRequest(int updateRequest);
    int updateResponseValue() const;
    Q_INVOKABLE void setUpdateResponse(int updateResponse);

    std::shared_ptr<CommonAPI::Runtime> runtime;
    std::shared_ptr<ICProxy<>> myProxy;

signals:
    void updateNotify();
    void updateResponse();

private:
    int m_updateRequest;
    int m_updateResponse;

    QTimer m_timer;
};

#endif // OTAUPDATE_H
