#include "nodes.h"

Define_Module(mynode1);
Define_Module(mynode2);

void mynode1::initialize()
{
    if(strcmp("mynode1",getName()) == 0)
    {
        cMessage *msg = new cMessage("tictocMsg");
        send(msg,"out");
    }
}

void mynode1::handleMessage(cMessage *msg)
{
    send(msg,"out");
}

void mynode2::initialize()
{
    // 不进行初始化
}

void mynode2::handleMessage(cMessage *msg)
{
    if(count == 1)
    {
        send(msg,"out1");
        count = 2;
    }
    else
    {
        send(msg,"out2");
        count = 1;
    }
}



