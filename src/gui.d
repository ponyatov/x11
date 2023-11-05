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

    this(GUI gui) {
        win = XCreateSimpleWindow(gui.display, gui.root, 0,
                0, width, height, border, gui.black, gui.white);
        XMapWindow(gui.display, win);

    }

    void quit(GUI gui) {
        XUnmapWindow(gui.display, win);
        XDestroyWindow(gui.display, win);
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
        main.quit(this);
        XCloseDisplay(display);
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
    gui.quit();
}
