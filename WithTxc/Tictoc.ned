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

package withtxc;

//
// Two instances (tic and toc) of Txc connected.
//
network Tictoc
{
    @display("bgb=644,504");
    submodules:
        tic: Txc {
            @display("p=59,230");
        }
        toc: Txc {
            @display("p=200,44");
        }
        tac: Tac {
            @display("p=407,225");
        }
    connections allowunconnected:
        tic.out --> toc.in;
        toc.out --> tic.in;
}
