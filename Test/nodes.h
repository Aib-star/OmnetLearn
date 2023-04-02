#ifndef NODES_H_
#define NODES_H_

#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class mynode1:public cSimpleModule
{
protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
};

class mynode2:public cSimpleModule
{
public:
    int count = 1;
protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
};

#endif /*NODES_H_*/



