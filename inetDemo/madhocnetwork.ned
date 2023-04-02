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
import inet.node.inet.AdhocHost;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;

network MobileAdhocDemo
{
    parameters:
        int numHosts;
        @display("bgb=650,450");
    submodules:
        configurator: Ipv4NetworkConfigurator {   //配置节点的IP地址
            parameters:
                @display("p=53,28;is=s");
        }
        radioMedium: Ieee80211ScalarRadioMedium {  //无线媒介模块，确保节点间的通信
            parameters:
                @display("p=59,145;is=vl");
        }
        host[numHosts]: AdhocHost {   //节点模块
            parameters:
                @display("p=300,200;i=misc/drone;is=vl");
        }
}
