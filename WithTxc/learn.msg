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

namespace withtxc;
//vector 引用头文件   定义     声明     使用
cplusplus{{
    #include <vector>
    #include "param.h"
    //定义
    typedef std::vector<int> IntVector;
}}
//声明
class noncobject IntVector;
struct NodeInfo;

message REQMsg{
    int src;
    int dest;
    int data;
}
packet REQPkt{
    int src;
    int dest;
    int data;
    //使用
    IntVector routeTable;
    NodeInfo info;
}