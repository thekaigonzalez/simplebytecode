module ubyteparser;

import std.stdio : writefln, File, writef, readln;

const byte PRN = 20; // print byte as a character
const byte PUSH = 21; // push byte onto stack

const byte NULL = 0; // null byte, end of request 
const byte END = 1; // use this to print the last member in the stack

void print_byte(byte[] registers, byte[]* stack)
{
    if (registers[0] == END)
    {
        writefln("%s", stack[stack.length - 1]);
    }
    else
    {
        char n = registers[0];

        writef("%c", n);
    }
}

void push_byte(byte[] registers, byte[]* stack)
{
    byte n = registers[0];

    *stack ~= n;
}

void parse_byte(byte[] p)
{
    byte[] regs;
    byte[] stack;
    void function(byte[], byte[]*)[byte] functs = [
        PRN: &print_byte,
        PUSH: &push_byte
    ];

    for (int i = 0; i < p.length; i++)
    {
        if (p[i] == NULL)
        {
            functs[regs[0]](regs[1 .. $], &stack);
            regs = [];
            continue;
        }

        regs ~= p[i];
    }
}

int main()
{
    byte[] p = [
        PRN, 72, NULL, // prints "H"
        PRN, 101, NULL, // prints "e"
        PRN, 108, NULL, // prints "l"
        PRN, 108, NULL, // prints "l"
        PRN, 111, NULL, // prints "o"
        PRN, 33, NULL, // prints "!"
        PRN, 10, NULL, // prints newline
        PRN, 72, NULL, // prints "H"
        PRN, 101, NULL, // prints "e"
        PRN, 108, NULL, // prints "l"
        PRN, 108, NULL, // prints "l"
        PRN, 111, NULL, // prints "o"
        PRN, 33, NULL, // prints "!"
        PRN, 10, NULL, // prints newline
        PRN, 72, NULL, // prints "H"
        PRN, 101, NULL, // prints "e"
        PRN, 108, NULL, // prints "l"
        PRN, 108, NULL, // prints "l"
        PRN, 111, NULL, // prints "o"
        PRN, 33, NULL, // prints "!"
        PRN, 10, NULL, // prints newline
        PRN, 72, NULL, // prints "H"
        PRN, 101, NULL, // prints "e"
        PRN, 108, NULL, // prints "l"
        PRN, 108, NULL, // prints "l"
        PRN, 111, NULL, // prints "o"
        PRN, 33, NULL, // prints "!"
        PRN, 10, NULL, // prints newline
        PRN, 72, NULL, // prints "H"
        PRN, 101, NULL, // prints "e"
        PRN, 108, NULL, // prints "l"
        PRN, 108, NULL, // prints "l"
        PRN, 111, NULL, // prints "o"
        PRN, 33, NULL, // prints "!"
        PRN, 10, NULL, // prints newline
        PRN, 72, NULL, // prints "H"
        PRN, 101, NULL, // prints "e"
        PRN, 108, NULL, // prints "l"
        PRN, 108, NULL, // prints "l"
        PRN, 111, NULL, // prints "o"
        PRN, 33, NULL, // prints "!"
        PRN, 10, NULL, // prints newline
    ];
    //end of stress test. completed successfully


    writefln("initial interpreted bytes below");
    parse_byte(p);

    auto n = File("test.byte", "wb");
    n.rawWrite(p);
    n.close();

    readln();

    writefln("read interpreted bytes below");

    auto nz = File("test.byte", "rb");
    auto buf = nz.rawRead(p);

    parse_byte(buf);

    nz.close();

    readln();

    return 0;
}
