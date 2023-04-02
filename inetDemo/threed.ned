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

import inet.common.geometry.common.OsgGeographicCoordinateSystem;
import inet.environment.common.PhysicalEnvironment;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.AdhocHost;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedVisualizer;


network EarthVisualizationShowcase
{
    submodules:
        visualizer: IntegratedVisualizer {
            parameters:
                @display("p=100,50");
        }
        coordinateSystem: OsgGeographicCoordinateSystem {
            parameters:
                @display("p=100,150");
        }
}

network EarthVisualization2 extends EarthVisualizationShowcase
{
    submodules:
        physicalEnvironment: PhysicalEnvironment {
            @display("p=100,246");
        }
}

network EarthVisualization3 extends EarthVisualizationShowcase
{
    submodules:
        physicalEnvironment: PhysicalEnvironment {
            @display("p=100,260");
        }
        host1: AdhocHost {
            @display("p=382,50");
        }
        host2: AdhocHost {
            @display("p=382,150");
        }
        host3: AdhocHost {
            @display("p=487,50");
        }
        host4: AdhocHost {
            @display("p=487,150");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=259,150");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=258,50");
        }
}
