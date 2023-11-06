import std.stdio;
import std.range;

import xgui;

void main(string[] args) {
    foreach (argc, argv; args.enumerate)
        writefln("argv[%s] = <%s>", argc, argv);
    gui.main.cross;
    gui.loop;
    gui.quit;
}
