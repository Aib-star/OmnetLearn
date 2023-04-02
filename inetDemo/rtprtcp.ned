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
import inet.node.rtp.RtpHost;


network RtpRtcpDemo
{
    types:
        channel ethernet extends ned.DatarateChannel
        {
            parameters:
                delay = normal(0.00015s, 0.00005s);
                datarate = 10Mbps;
                ber = 0.00001;
        }

    submodules:
        sender: RtpHost {
            parameters:
                profileName = "inet.transportlayer.rtp.RtpAvProfile";
                destinationAddress = "receiver";
                portNumber = 5004;
                bandwidth = 8000;
                @display("p=250,100");
        }
        receiver: RtpHost {
            parameters:
                profileName = "inet.transportlayer.rtp.RtpAvProfile";
                destinationAddress = "sender";
                portNumber = 5004;
                bandwidth = 8000;
                @display("p=400,100");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=100,100;is=s");
        }
    connections:
        sender.pppg++ <--> ethernet <--> receiver.pppg++;
}