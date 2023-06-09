//
// Generated file, do not edit! Created by nedtool 5.6 from learn.msg.
//

#ifndef __WITHTXC_LEARN_M_H
#define __WITHTXC_LEARN_M_H

#if defined(__clang__)
#  pragma clang diagnostic ignored "-Wreserved-id-macro"
#endif
#include <omnetpp.h>

// nedtool version check
#define MSGC_VERSION 0x0506
#if (MSGC_VERSION!=OMNETPP_VERSION)
#    error Version mismatch! Probably this file was generated by an earlier version of nedtool: 'make clean' should help.
#endif


namespace withtxc {

// cplusplus {{
    #include <vector>
    #include "param.h"
    //����
    typedef std::vector<int> IntVector;
// }}

/**
 * Class generated from <tt>learn.msg:28</tt> by nedtool.
 * <pre>
 * message REQMsg
 * {
 *     int src;
 *     int dest;
 *     int data;
 * }
 * </pre>
 */
class REQMsg : public ::omnetpp::cMessage
{
  protected:
    int src;
    int dest;
    int data;

  private:
    void copy(const REQMsg& other);

  protected:
    // protected and unimplemented operator==(), to prevent accidental usage
    bool operator==(const REQMsg&);

  public:
    REQMsg(const char *name=nullptr, short kind=0);
    REQMsg(const REQMsg& other);
    virtual ~REQMsg();
    REQMsg& operator=(const REQMsg& other);
    virtual REQMsg *dup() const override {return new REQMsg(*this);}
    virtual void parsimPack(omnetpp::cCommBuffer *b) const override;
    virtual void parsimUnpack(omnetpp::cCommBuffer *b) override;

    // field getter/setter methods
    virtual int getSrc() const;
    virtual void setSrc(int src);
    virtual int getDest() const;
    virtual void setDest(int dest);
    virtual int getData() const;
    virtual void setData(int data);
};

inline void doParsimPacking(omnetpp::cCommBuffer *b, const REQMsg& obj) {obj.parsimPack(b);}
inline void doParsimUnpacking(omnetpp::cCommBuffer *b, REQMsg& obj) {obj.parsimUnpack(b);}

/**
 * Class generated from <tt>learn.msg:33</tt> by nedtool.
 * <pre>
 * packet REQPkt
 * {
 *     int src;
 *     int dest;
 *     int data;
 *     //ʹ��
 *     IntVector routeTable;
 *     NodeInfo info;
 * }
 * </pre>
 */
class REQPkt : public ::omnetpp::cPacket
{
  protected:
    int src;
    int dest;
    int data;
    IntVector routeTable;
    NodeInfo info;

  private:
    void copy(const REQPkt& other);

  protected:
    // protected and unimplemented operator==(), to prevent accidental usage
    bool operator==(const REQPkt&);

  public:
    REQPkt(const char *name=nullptr, short kind=0);
    REQPkt(const REQPkt& other);
    virtual ~REQPkt();
    REQPkt& operator=(const REQPkt& other);
    virtual REQPkt *dup() const override {return new REQPkt(*this);}
    virtual void parsimPack(omnetpp::cCommBuffer *b) const override;
    virtual void parsimUnpack(omnetpp::cCommBuffer *b) override;

    // field getter/setter methods
    virtual int getSrc() const;
    virtual void setSrc(int src);
    virtual int getDest() const;
    virtual void setDest(int dest);
    virtual int getData() const;
    virtual void setData(int data);
    virtual IntVector& getRouteTable();
    virtual const IntVector& getRouteTable() const {return const_cast<REQPkt*>(this)->getRouteTable();}
    virtual void setRouteTable(const IntVector& routeTable);
    virtual NodeInfo& getInfo();
    virtual const NodeInfo& getInfo() const {return const_cast<REQPkt*>(this)->getInfo();}
    virtual void setInfo(const NodeInfo& info);
};

inline void doParsimPacking(omnetpp::cCommBuffer *b, const REQPkt& obj) {obj.parsimPack(b);}
inline void doParsimUnpacking(omnetpp::cCommBuffer *b, REQPkt& obj) {obj.parsimUnpack(b);}

} // namespace withtxc

#endif // ifndef __WITHTXC_LEARN_M_H

