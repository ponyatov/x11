// http://mech.math.msu.su/~nap/2/GWindow/xintro.html

module gui;

// https://github.com/ZILtoid1991/x11d
import x11.Xlib;
import x11.X;

import std.stdio;

class Win {
    /// main window
    Window win;
    uint width = 640; ///< current window width
    uint height = 480; ///< current window height
    uint border = 5; ///< border size, pixels

    this(Display* display, int screen, Window root) {
        win = XCreateSimpleWindow(display, root, 0, 0, width, height, border,
                BlackPixel(display, screen), WhitePixel(display, screen));
        XMapWindow(display, win);

    }
}

class GUI {
    /// The @ref Display points to the X Server.
    static Display* display = null;
    /// Global system root window
    static Window root;
    /// default screen
    static int screen = 0;
    /// main window
    Win main;
    /// events
    XEvent event;

    /// construct base GUI items
    this() {
        display = XOpenDisplay(null);
        assert(display !is null);
        screen = DefaultScreen(display);
        root = RootWindow(display, screen);
        main = new Win(display, screen, root);
    }

    void loop() {
        while (XNextEvent(display, &event)) {

        }
    }
}

GUI gui;

void init() {
    gui = new GUI;
    writeln("init\t", gui);
}

void loop() {
    gui.loop;
}

void quit() {
}
