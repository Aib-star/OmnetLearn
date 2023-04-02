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

#include "TCPServerAppImpl.h"
#include "inet/common/INETUtils.h"
#include "inet/common/ModuleAccess.h"
#include "inet/common/lifecycle/ModuleOperations.h"
#include "inet/networklayer/common/L3AddressResolver.h"


Define_Module(TCPServerAppImpl);

void TCPServerAppImpl::initialize(int stage)
{
    ApplicationBase::initialize(stage);
}

//服务器端socket 设置
void TCPServerAppImpl::handleStartOperation(LifecycleOperation *operation)
{
    const char *localAddress = par("localAddress");
    int localPort = par("localPort");

    serverSocket.setOutputGate(gate("socketOut"));
    serverSocket.setCallback(this);
    serverSocket.bind(localAddress[0] ? L3Address(localAddress) : L3Address(), localPort);
    serverSocket.listen();//侦听
}

void TCPServerAppImpl::handleStopOperation(LifecycleOperation *operation)
{
    serverSocket.close();
    delayActiveOperationFinish(par("stopOperationTimeout"));
}

void TCPServerAppImpl::handleCrashOperation(LifecycleOperation *operation)
{
    // TODO: always?
    if (operation->getRootModule() != getContainingNode(this))
        serverSocket.destroy();
}

void TCPServerAppImpl::refreshDisplay() const
{
    ApplicationBase::refreshDisplay();

    char buf[32];
    sprintf(buf, "%d threads", socketMap.size());
    getDisplayString().setTagArg("t", 0, buf);
}

void TCPServerAppImpl::handleMessageWhenUp(cMessage *msg)
{
    if (msg->isSelfMessage()) {
    }
    else {
        TcpSocket *socket = check_and_cast_nullable<TcpSocket*>(socketMap.findSocketFor(msg));
        if (socket)
            socket->processMessage(msg);
        else if (serverSocket.belongsToSocket(msg))
            serverSocket.processMessage(msg);
        else {
            // throw cRuntimeError("Unknown incoming message: '%s'", msg->getName());
            EV_ERROR << "message " << msg->getFullName() << "(" << msg->getClassName() << ") arrived for unknown socket \n";
            delete msg;
        }
    }
}

void TCPServerAppImpl::socketAvailable(TcpSocket *socket, TcpAvailableInfo *availableInfo)
{
    socket->accept(availableInfo->getNewSocketId());
}

void TCPServerAppImpl::socketClosed(TcpSocket *socket)
{
    if (operationalState == State::STOPPING_OPERATION && !serverSocket.isOpen())
        startActiveOperationExtraTimeOrFinish(par("stopOperationExtraTime"));
}


