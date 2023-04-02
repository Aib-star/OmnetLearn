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
#include "learn_m.h"    //引用消息类

const int TX = 100;
const int TIMER = 101;
const int RECEIVE_END = 102;
const int REQ = 200;
const int ACK = 201;

namespace withtxc {

Define_Module(Txc);

void Txc::initialize(int stage) {
    if (stage == 0) {
        dataSignal = registerSignal("rcvData");  //注册数据统计（使用ned统计）
        timer = new cMessage("TIMER", TIMER);  //对象名称与消息类型
        routeTable.push_back(this->getIndex()); //将当前节点的索引添加到路由表中
        myInfo.id = this->getIndex();
        myInfo.hop = 0;
        myInfo.name = "tic";
        dataVec.setName("data");
        dataVec.setType(cOutVector::TYPE_DOUBLE);
        dataVec.setInterpolationMode(cOutVector::LINEAR);
        total = 0;
        count = 0;
        if (par("sendInitialMessage").boolValue())  //par(): 返回对用其名称指定的参数的引用。
        {
            //1.message使用
            //        cMessage *msg = new cMessage("test");  //无Length
            //        msg->setKind(TX);
            //        send(msg, "out");  //out为Tictoc的输出门，消息进入队列。
            //2.packet使用
            //200byte   dataRate = 960bps  ->   duration =
            //        int duration = 200*8/960;
            //        cPacket *pkt = new cPacket();
            //        pkt->setKind(TX);
            //        pkt->setByteLength(2);
            //        pkt->setBitError(true);
            //        pkt->setDuration(duration);  //设置包的发送时间
            //        gate("in")->setDeliverOnReceptionStart(true);   //设置时延计算以接收端接收到第一个bit开始到最后一个bit结束.
            //        sendDelayed(pkt, duration, "out");
            //3.自定义消息使用
            REQPkt *pkt = new REQPkt("REQ", REQ);
            pkt->setByteLength(2);
            pkt->setSrc(this->getIndex());
            pkt->setDest(0);
            pkt->setData(uniform(0, 100));
            pkt->setRouteTable(routeTable);
            pkt->setInfo(myInfo);
            send(pkt, "out");

        }
        //  scheduleAt 会在计时器到时调用handleMessage或receive函数接收timer消息，此处计时器设定是0.2秒，到时接收的消息就是timer指针内容
        //  scheduleAt(simTime()+0.2, timer); //simTime(): Returns the current simulation time
    } else if (stage == 1) {
        //do something
    }
    EV << "stage=" << stage << endl;
}

void Txc::handleMessage(cMessage *msg) { //默认栈数为0
    // 1.处理packet消息
//    if(msg->getKind()==TX){
////        send(msg, "out");
//        cPacket *pkt = check_and_cast<cPacket*>(msg);  //类型转换：将cMessage转换为cPacket
//        simtime_t duration = pkt->getDuration();  //模拟发送包的持续时间
//        simtime_t start = simTime();   //接收开始的时间
//        simtime_t end = start + duration;
//        scheduleAt(end, new cMessage("receiving",RECEIVE_END)); //接收消息成功
//    }else if(msg->getKind()==TIMER){
//        double slot= this->par("slot").doubleValue();
//        EV<<"slot="<<slot<<endl;
//        scheduleAt(simTime()+0.2, timer);
//    }else if(msg->getKind()==RECEIVE_END){
////        接收消息成功后，进行一些操作：
//        EV<<"received"<<endl;
//    }
    //2.处理自定义消息
    if (msg->getKind() == REQ) {
        REQPkt *reqPkt = check_and_cast<REQPkt*>(msg);
        std::vector<int> tr = reqPkt->getRouteTable(); //拿到路由表信息
        struct NodeInfo info = reqPkt->getInfo();
        emit(dataSignal,reqPkt->getData());  //使用ned统计
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
    //数据分析 统计  取均值
    double average = total / count;
    recordScalar("average", average);
}
}
;

