#include "otaUpdate.h"
#include <QTimer>

OtaUpdate::OtaUpdate(QObject *parent)
    :QObject(parent), m_updateRequest(0), m_updateResponse(0) {
    std::cout << "Pailable0" << std::endl;
    runtime = CommonAPI::Runtime::get();
    std::cout << "Pailable1" << std::endl;
    myProxy = runtime->buildProxy<ICProxy>("local","commonapi.IC_service");
    std::cout << "Pailable2" << std::endl;

    QTimer::singleShot(500, this, [this]() {
        if (myProxy->isAvailable()) {
            std::cout << "Proxy is now available!" << std::endl;
        }
    });

    myProxy->getProxyStatusEvent().subscribe([this](CommonAPI::AvailabilityStatus status){
        if(status == CommonAPI::AvailabilityStatus::AVAILABLE){
            std::cout<<"Proxy is Avbbbbbailable"<<std::endl;
        }else{
            std::cout<<"Proxy is NOT bbbbbbbbbAvailable"<<std::endl;
        }
    });

    myProxy->getAskNotifyEvent().subscribe([this](int32_t updateRequest){
        qDebug() << "\nUpdate Request" << updateRequest;
        std::cout << "\nUpdate Request" << updateRequest << std::endl;
        m_updateRequest = updateRequest;
        emit updateNotify();
    });
    std::cout << "Pailable3" << std::endl;
}

int OtaUpdate::updateRequestValue() const {
    return m_updateRequest;
}

void OtaUpdate::setUpdateRequest(int updateRequest){
    m_updateRequest = updateRequest;
}

int OtaUpdate::updateResponseValue() const {
    return m_updateResponse;
}

void OtaUpdate::setUpdateResponse(int updateResponse){
    if (updateResponse == 1) {
        std::cout << "\nYes Callback\n" << std::endl;
        myProxy->answerNotifyAsync(updateResponse, [this](const CommonAPI::CallStatus& callStatus, const int32_t& result){
            if(callStatus == CommonAPI::CallStatus::SUCCESS){
                std::cout << "\nUpdate Start\n" << std::endl;
            }
            else{
                std::cout << "\nFail to Update\n" << std::endl;
            }
        });
        std::cout << "\nSend Yes\n" << std::endl;
    }
}
