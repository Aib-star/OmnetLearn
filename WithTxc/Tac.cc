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

#include "Tac.h"
#include "learn_m.h"
namespace withtxc {
Define_Module(Tac);
Tac::Tac() :
        cSimpleModule(16384) {
    // TODO Auto-generated constructor stub

}
void Tac::activity() {
    while(true){
    cMessage *msg = receive(); //区别于handelMessage
    REQPkt *reqPkt = check_and_cast<REQPkt*>(msg);
    std::vector<int> tr = reqPkt->getRouteTable(); //拿到路由表信息
    struct NodeInfo info = reqPkt->getInfo();
    EV << "reqData=" << reqPkt->getData() << endl;
    REQPkt *pkt = new REQPkt("ACK", 201);
    pkt->setSrc(this->getIndex());
    pkt->setDest(0);
    pkt->setData(200);
    send(pkt, "out");
    }
}

Tac::~Tac() {
    // TODO Auto-generated destructor stub
}

} /* namespace withtxc */
