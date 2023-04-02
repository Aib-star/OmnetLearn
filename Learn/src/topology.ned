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

package learn;
simple Host
{
    gates:
        inout port[];
}

network Star
{
    @display("bgb=503,396");
    submodules:
        host[10]: Host {
            @display("p=242,187");
        }
    connections allowunconnected:
        for i=1..9 {
            host[i].port++ <--> host[0].port++; //以0节点为中心
        }
}
//网状
network Mesh
{
    @display("bgb=503,396");
    submodules:

        host0: Host {
            @display("p=65,61");
        }
        host1: Host {
            @display("p=44,166");
        }
        host6: Host {
            @display("p=103,335");
        }
        host2: Host {
            @display("p=231,228");
        }
        host3: Host {
            @display("p=416,44");
        }
        host4: Host {
            @display("p=449,127");
        }
        host5: Host {
            @display("p=429,350");
        }
    connections allowunconnected: //每个host与其余host进行连接
        host0.port++ <--> host1.port++;
        host0.port++ <--> host6.port++;
        host2.port++ <--> host0.port++;
        host0.port++ <--> host3.port++;
        host0.port++ <--> host4.port++;
        host0.port++ <--> host5.port++;
        host1.port++ <--> host2.port++;
        host1.port++ <--> host6.port++;
        host1.port++ <--> host4.port++;
        host1.port++ <--> host5.port++;
        host1.port++ <--> host3.port++;
        host6.port++ <--> host4.port++;
        host6.port++ <--> host5.port++;
        host5.port++ <--> host3.port++;
        host2.port++ <--> host5.port++;
        host2.port++ <--> host4.port++;
        host2.port++ <--> host3.port++;
        host2.port++ <--> host6.port++;
        host4.port++ <--> host2.port++;
}
//
// 树状拓扑
//
simple TreeNode
{
    @display("i=misc/node2");
    gates:
        inout left;
        inout right;
        inout parent;
}
network Tree
{
    int height = default(5);
    @display("bgb=513,251");
    //    submodules:
    //        node[2^height - 1]: TreeNode {
    //            @display("p=200,96");
    //        }
    //    connections allowunconnected:
    //        for i=0..(2^height-1) {
    //            node[i].left <--> node[2*i+1].parent;
    //            node[i].right <--> node[2*i+2].parent;
    //        }
    submodules:
        node0: TreeNode {
            @display("p=281,29");
        }
        node1: TreeNode {
            @display("p=199,101");
        }
        node2: TreeNode {
            @display("p=347,95");
        }
        node3: TreeNode {
            @display("p=111,192");
        }
        node4: TreeNode {
            @display("p=251,196");
        }
        node5: TreeNode {
            @display("p=320,200");
        }
        node6: TreeNode {
            @display("p=440,201");
        }
    connections allowunconnected:
        node0.left <--> node1.parent;
        node0.right <--> node2.parent;
        node1.left <--> node3.parent;
        node1.right <--> node4.parent;
        node2.left <--> node5.parent;
        node2.right <--> node6.parent;
}
//环形结构
network Circle
{
    @display("bgb=519,328");
    submodules:
        host0: Host {
            @display("p=66,114");
        }
        host1: Host {
            @display("p=177,74;is=vl");
        }
        host2: Host {
            @display("p=296,119;is=vl");
        }
        host3: Host {
            @display("p=115,237;is=vl");
        }
        host4: Host {
            @display("p=251,245;is=vl");
        }
    connections:
        host0.port++ <--> host1.port++;
        host1.port++ <--> host2.port++;
        host2.port++ <--> host4.port++;
        host4.port++ <--> host3.port++;
        host3.port++ <--> host0.port++;
}















