// http://mech.math.msu.su/~nap/2/GWindow/xintro.html

module xgui;

// https://github.com/ZILtoid1991/x11d
import x11.Xlib;
import x11.X;

import std.stdio;
import std.string;

class Win {
    /// main window
    GUI gui;
    Window win;
    uint width = 640; ///< current window width
    uint height = 480; ///< current window height
    uint border = 5; ///< border size, pixels

    this(GUI gui) {
        this.gui = gui;
        win = XCreateSimpleWindow(gui.display, gui.root, 0,
                0, width, height, border, gui.black, gui.white);
        XMapWindow(gui.display, win);

    }

    void quit() {
        XUnmapWindow(gui.display, win);
        XDestroyWindow(gui.display, win);
    }

    void cross() {
    }
}

class GUI {
    /// The @ref Display points to the X Server.
    static Display* display = null;
    /// Global system root window
    static Window root;
    /// default screen
    static int screen = 0;
    /// colors
    ulong black, white;
    /// main window
    Win main;
    /// events
    XEvent event;

    /// construct base GUI items
    this() {
        display = XOpenDisplay(null);
        assert(display !is null);
        writefln("X%s.%s %s rel.%s DISPLAY=%s.%s /%s",
                display.proto_major_version,
                display.proto_minor_version, display.vendor.fromStringz,
                display.release, display.display_name.fromStringz,
                display.default_screen, display.nscreens);
        screen = DefaultScreen(display);
        root = RootWindow(display, screen);
        black = BlackPixel(display, screen);
        white = WhitePixel(display, screen);
        main = new Win(this);
    }

    void loop() {
        while (XNextEvent(display, &event)) {
        }
    }

    void quit() {
        main.quit();
        XCloseDisplay(display);
    }
}

GUI gui;

static this() {
    gui = new GUI();
}
