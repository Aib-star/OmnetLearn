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
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;


network WiredDemo
{
    types:
        channel fiberline extends DatarateChannel
        {
            delay = 1us;
            datarate = 512Mbps;
        }
        channel ethline extends DatarateChannel
        {
            delay = 50ns;
            datarate = 100Mbps;
        }
    submodules:
        client: StandardHost {
            @display("p=50,95;i=device/laptop");
        }
        host1: StandardHost {
            @display("p=50,195;i=device/pc");
        }
        host2: StandardHost {
            @display("p=50,295;i=device/pc");
        }
        switch: EtherSwitch {
            @display("p=200,195");
        }
        router: Router {
            @display("p=350,195");
        }
        server: StandardHost {
            @display("p=489,195;i=device/server");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=58,26;is=s");
        }
    connections:
        client.ethg++ <--> ethline <--> switch.ethg++;
        switch.ethg++ <--> ethline <--> host1.ethg++;
        switch.ethg++ <--> ethline <--> host2.ethg++;
        router.ethg++ <--> ethline <--> switch.ethg++;
        router.pppg++ <--> fiberline <--> server.pppg++;
}
