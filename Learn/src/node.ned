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

// Ned模块
//Ned参数
//1. 配置文件赋值   2.实例赋值

package learn;
simple Node
{
    parameters:
        int num;
        double xpos;
        double ypos;
        string type;
        double distance @unit(m);  //指定参数单位
        @class(Node); //绑定的c++类，一般会自动匹配。
    gates:
        input in[];  //连接多个门
        output out;
}
//module Host
//{
//    gates:
//        input in;
//        output out;
//    submodules:
//        node1: Node {
//            num = intuniform(10,100); //10到100的随机数
//            xpos = 20;
//            ypos = 20;
//            type = "fei";
//            @display("p=238,167");
//        }
//        node2: Node {
//            @display("p=58,37;i=abstract/penguin,#FF8080;is=l");
//        }
//        node4: Node {
//            @display("i=block/process,#00FF80;is=n");
//        }
//    connections allowunconnected: //允许模块没有连接的结点存在
//        node1.out --> node2.in;
//        node2.out --> node1.in;
//}
network Demo
{
    @display("bgb=805,238"); //得在第一行
    types:     //定义信道
        channel Eth extends ned.DatarateChannel
        {
            double distance @unit(m);
            datarate = 100Mbps; //数据率
            ber = e-7;  //比特错误率
            per = e-5; //包错误率
            delay = distance / 10km*1s;  //每秒10km
        }
    submodules:
          node1: Node {
            num = intuniform(10,100); //10到100的随机数
            xpos = 20;
            ypos = 20;
            type = "fei";
            @display("p=238,167");
        }
        node2: Node {
            @display("p=58,37;i=abstract/penguin,#FF8080;is=l");
        }
        node3: Node {
            @display("p=582,182");
        }
//        host: Host;
    connections:
        node3.out --> Eth { @display("ls=green,4,da");distance = 100m; } --> node1.in++;  //添加自定义的信道，第一种定义方式。
        node1.out --> {datarate=100Mbps;}  --> node3.in++;  //第二种定义方式: 直接在连接中设置参数。
        node2.out --> Eth {distance = 10000m;} --> node1.in++;

}
