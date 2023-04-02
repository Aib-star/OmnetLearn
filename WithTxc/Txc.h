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

#ifndef __WITHTXC_TCX_H
#define __WITHTXC_TCX_H

#include <omnetpp.h>
#include "param.h"
using namespace omnetpp;

namespace withtxc {

/**
 * Implements the Txc simple module. See the NED file for more information.
 */
class Txc : public cSimpleModule
{
private:
    cMessage * timer;
    std::vector<int> routeTable;
    struct NodeInfo myInfo;
    cOutVector dataVec;   //c++统计
    double total; //均值
    int count;
    simsignal_t dataSignal;
  protected:
    virtual void initialize(int stage) override;  //默认numInitStages = 1 , 需要修改的话得重写numInitStages()方法。
    virtual void handleMessage(cMessage *msg) override;
    virtual int numInitStages() const override {return 10;}
    virtual void finish() override;
};

}; // namespace

#endif
