import std.stdio;
import std.range;

import x11;

void main(string[] args) {
    foreach (argc, argv; args.enumerate)
        writefln("argv[%s] = <%s>", argc, argv);
    x11.init;
    x11.quit;
}
