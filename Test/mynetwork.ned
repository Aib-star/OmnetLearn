simple mynode1
{
    gates:
        input in;
        output out;
}

simple mynode2
{
    gates:
        input in1;
        input in2;
        output out1;
        output out2;
}

network Network
{
    submodules:
        mynode1: mynode1 {
            @display("p=76,54");
        }
        mynode2: mynode2 {
            @display("p=193,250");
        }
        mynode3: mynode1 {
            @display("p=305,54");
        }
    connections:
        mynode1.out --> mynode2.in1;
        mynode2.out1 --> mynode3.in;
        mynode3.out --> mynode2.in2;
        mynode2.out2 --> mynode1.in;
}
