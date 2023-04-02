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


network MultiClientDemo
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
        client1: StandardHost {
            @display("p=50,95;i=device/laptop");
        }
        client2: StandardHost {
            @display("p=50,195;i=device/pc");
        }
        host1: StandardHost {
            @display("p=210,283;i=device/pc");
        }
        host2: StandardHost {
            @display("p=450,57;i=device/pc");
        }
        switch1: EtherSwitch {
            @display("p=238,159");
        }
        switch2: EtherSwitch {
            @display("p=308,250");
        }
        switch3: EtherSwitch {
            @display("p=260,25");
        }
        router1: Router {
            @display("p=154,160");
        }
        router2: Router {
            @display("p=329,160");
        }
        router3: Router {
            @display("p=213,93");
        }
        router4: Router {
            @display("p=368,95");
        }
        server: StandardHost {
            @display("p=405,283;i=device/server");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=58,26;is=s");
        }
    connections:
        client1.pppg++ <--> fiberline <--> router1.pppg++;
        client2.pppg++ <--> fiberline <--> router1.pppg++;

        router1.ethg++ <--> ethline <--> switch1.ethg++;
        switch1.ethg++ <--> ethline <--> router2.ethg++;
        router2.ethg++ <--> ethline <--> switch2.ethg++;

        router1.ethg++ <--> ethline <--> router3.ethg++;
        router3.ethg++ <--> ethline <--> switch3.ethg++;
        switch3.ethg++ <--> ethline <--> router4.ethg++;
        router4.ethg++ <--> ethline <--> router2.ethg++;
        host2.pppg++ <--> fiberline <--> router4.pppg++;

        host1.ethg++ <--> ethline <--> switch2.ethg++;
        server.ethg++ <--> ethline <--> switch2.ethg++;
}
