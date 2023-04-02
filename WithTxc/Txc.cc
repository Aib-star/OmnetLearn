//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#include "Txc.h"
#include "learn_m.h"    //������Ϣ��

const int TX = 100;
const int TIMER = 101;
const int RECEIVE_END = 102;
const int REQ = 200;
const int ACK = 201;

namespace withtxc {

Define_Module(Txc);

void Txc::initialize(int stage) {
    if (stage == 0) {
        dataSignal = registerSignal("rcvData");  //ע������ͳ�ƣ�ʹ��nedͳ�ƣ�
        timer = new cMessage("TIMER", TIMER);  //������������Ϣ����
        routeTable.push_back(this->getIndex()); //����ǰ�ڵ��������ӵ�·�ɱ���
        myInfo.id = this->getIndex();
        myInfo.hop = 0;
        myInfo.name = "tic";
        dataVec.setName("data");
        dataVec.setType(cOutVector::TYPE_DOUBLE);
        dataVec.setInterpolationMode(cOutVector::LINEAR);
        total = 0;
        count = 0;
        if (par("sendInitialMessage").boolValue())  //par(): ���ض���������ָ���Ĳ��������á�
        {
            //1.messageʹ��
            //        cMessage *msg = new cMessage("test");  //��Length
            //        msg->setKind(TX);
            //        send(msg, "out");  //outΪTictoc������ţ���Ϣ������С�
            //2.packetʹ��
            //200byte   dataRate = 960bps  ->   duration =
            //        int duration = 200*8/960;
            //        cPacket *pkt = new cPacket();
            //        pkt->setKind(TX);
            //        pkt->setByteLength(2);
            //        pkt->setBitError(true);
            //        pkt->setDuration(duration);  //���ð��ķ���ʱ��
            //        gate("in")->setDeliverOnReceptionStart(true);   //����ʱ�Ӽ����Խ��ն˽��յ���һ��bit��ʼ�����һ��bit����.
            //        sendDelayed(pkt, duration, "out");
            //3.�Զ�����Ϣʹ��
            REQPkt *pkt = new REQPkt("REQ", REQ);
            pkt->setByteLength(2);
            pkt->setSrc(this->getIndex());
            pkt->setDest(0);
            pkt->setData(uniform(0, 100));
            pkt->setRouteTable(routeTable);
            pkt->setInfo(myInfo);
            send(pkt, "out");

        }
        //  scheduleAt ���ڼ�ʱ����ʱ����handleMessage��receive��������timer��Ϣ���˴���ʱ���趨��0.2�룬��ʱ���յ���Ϣ����timerָ������
        //  scheduleAt(simTime()+0.2, timer); //simTime(): Returns the current simulation time
    } else if (stage == 1) {
        //do something
    }
    EV << "stage=" << stage << endl;
}

void Txc::handleMessage(cMessage *msg) { //Ĭ��ջ��Ϊ0
    // 1.����packet��Ϣ
//    if(msg->getKind()==TX){
////        send(msg, "out");
//        cPacket *pkt = check_and_cast<cPacket*>(msg);  //����ת������cMessageת��ΪcPacket
//        simtime_t duration = pkt->getDuration();  //ģ�ⷢ�Ͱ��ĳ���ʱ��
//        simtime_t start = simTime();   //���տ�ʼ��ʱ��
//        simtime_t end = start + duration;
//        scheduleAt(end, new cMessage("receiving",RECEIVE_END)); //������Ϣ�ɹ�
//    }else if(msg->getKind()==TIMER){
//        double slot= this->par("slot").doubleValue();
//        EV<<"slot="<<slot<<endl;
//        scheduleAt(simTime()+0.2, timer);
//    }else if(msg->getKind()==RECEIVE_END){
////        ������Ϣ�ɹ��󣬽���һЩ������
//        EV<<"received"<<endl;
//    }
    //2.�����Զ�����Ϣ
    if (msg->getKind() == REQ) {
        REQPkt *reqPkt = check_and_cast<REQPkt*>(msg);
        std::vector<int> tr = reqPkt->getRouteTable(); //�õ�·�ɱ���Ϣ
        struct NodeInfo info = reqPkt->getInfo();
        emit(dataSignal,reqPkt->getData());  //ʹ��nedͳ��
        dataVec.record(reqPkt->getData());
        total += reqPkt->getData();
        count++;
        EV << "reqData=" << reqPkt->getData() << endl;
        REQPkt *pkt = new REQPkt("ACK", ACK);
        pkt->setSrc(this->getIndex());
        pkt->setDest(0);
        pkt->setData(200);
        send(pkt, "out");
    } else if (msg->getKind() == ACK) {
        REQPkt *pkt = new REQPkt("REQ", REQ);
        pkt->setSrc(this->getIndex());
        pkt->setDest(0);
        pkt->setData(uniform(0, 100));
        send(pkt, "out");
    }
}
void Txc::finish() {
    EV << "finish" << endl;
    //���ݷ��� ͳ��  ȡ��ֵ
    double average = total / count;
    recordScalar("average", average);
}
}
;

