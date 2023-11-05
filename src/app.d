import std.stdio;
import std.range;

import gui;

void main(string[] args) {
    foreach (argc, argv; args.enumerate)
        writefln("argv[%s] = <%s>", argc, argv);
    gui.init;
    gui.loop;
    gui.quit;
}
