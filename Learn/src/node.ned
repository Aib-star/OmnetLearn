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

// Nedģ��
//Ned����
//1. �����ļ���ֵ   2.ʵ����ֵ

package learn;
simple Node
{
    parameters:
        int num;
        double xpos;
        double ypos;
        string type;
        double distance @unit(m);  //ָ��������λ
        @class(Node); //�󶨵�c++�࣬һ����Զ�ƥ�䡣
    gates:
        input in[];  //���Ӷ����
        output out;
}
//module Host
//{
//    gates:
//        input in;
//        output out;
//    submodules:
//        node1: Node {
//            num = intuniform(10,100); //10��100�������
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
//    connections allowunconnected: //����ģ��û�����ӵĽ�����
//        node1.out --> node2.in;
//        node2.out --> node1.in;
//}
network Demo
{
    @display("bgb=805,238"); //���ڵ�һ��
    types:     //�����ŵ�
        channel Eth extends ned.DatarateChannel
        {
            double distance @unit(m);
            datarate = 100Mbps; //������
            ber = e-7;  //���ش�����
            per = e-5; //��������
            delay = distance / 10km*1s;  //ÿ��10km
        }
    submodules:
          node1: Node {
            num = intuniform(10,100); //10��100�������
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
        node3.out --> Eth { @display("ls=green,4,da");distance = 100m; } --> node1.in++;  //�����Զ�����ŵ�����һ�ֶ��巽ʽ��
        node1.out --> {datarate=100Mbps;}  --> node3.in++;  //�ڶ��ֶ��巽ʽ: ֱ�������������ò�����
        node2.out --> Eth {distance = 10000m;} --> node1.in++;

}