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
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.applications.contract.IApp;

simple TCPClientAppImpl like IApp
{
    parameters:
        string localAddress = default(""); //本地地址
        int localPort = default(-1); //本地端口
        string connectAddress = default("");  //服务器地址
        int connectPort = default(1000); //服务器端口
        double startTime @unit(s) = default(1s); //开始时间
        double stopTime @unit(s) = default(-1s);  //停止时间
        volatile int numRequestsPerSession = default(10);  // number of requests sent per session
        volatile int requestLength @unit(B) = default(200B); // length of a request
        volatile int replyLength @unit(B) = default(1MiB); // length of a reply
        volatile double thinkTime @unit(s); //请求间隔 time gap between requests
        volatile double idleInterval @unit(s); //会话间隔 time gap between sessions
        volatile double reconnectInterval @unit(s) = default(30s);  //重连间隔
        @display("i=block/app");
        @class(TCPClientAppImpl);
        @lifecycleSupport;
        double stopOperationExtraTime @unit(s) = default(-1s);    //
        double stopOperationTimeout @unit(s) = default(2s);    //
    gates:
        input socketIn @labels(TcpCommand/up);
        output socketOut @labels(TcpCommand/down);
}

simple TCPServerAppImpl like IApp
{
    parameters:
        string localAddress = default(""); //本地地址
        int localPort = default(1000); //本地端口
        @display("i=block/app");
        @lifecycleSupport;
        @class(TCPServerAppImpl);
        double stopOperationExtraTime @unit(s) = default(-1s);    //
        double stopOperationTimeout @unit(s) = default(2s);    //
    gates:
        input socketIn @labels(TcpCommand/up);
        output socketOut @labels(TcpCommand/down);
}

network TcpSocketDemo
{
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
        }
    submodules:
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
        client: StandardHost {
            parameters:
                @display("p=250,100;i=device/pc3");
        }
        server: StandardHost {
            parameters:
                @display("p=400,100;i=device/pc2");
        }
    connections allowunconnected:
        client.pppg++ <--> C <--> server.pppg++;
}