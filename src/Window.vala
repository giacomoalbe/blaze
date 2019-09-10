public class Blaze.Window : Gtk.Window {
  public weak Blaze.Application app { get; construct; }

  public Window (Blaze.Application app) {
    Object(
      app: app
    );
  }

  construct {
    build_ui();

    show_all();
  }

  void build_ui() {
    set_default_size(800, 600);

    title = "Blaze App v0.0.1";

    var main_layout = new Gtk.Grid ();

    var timeline = new Blaze.Timeline ();
    var canvas = new Gtk.Label ("Canvas");

    canvas.vexpand = true;
    canvas.hexpand = true;

    main_layout.attach (canvas, 0, 0, 1, 1);
    main_layout.attach (timeline, 0, 1, 1, 1);

    add (main_layout);

    /*

    var left_side = new Gtk.Grid ();
    var right_side = new Gtk.Grid ();
    var timeline = new Gtk.Grid ();

    var left_side_label = new Gtk.Label("Left Side");
    var right_side_label = new Gtk.Label("Right Side");
    var canvas_label = new Gtk.Label("Canvas Side");
    var timeline_label = new Gtk.Label("Timeline Side");

    canvas.valign = Gtk.Align.CENTER;
    canvas.halign = Gtk.Align.CENTER;
    canvas.vexpand = true;
    canvas.hexpand = true;

    var main_widget = new Gtk.Grid();

    main_widget.attach(left_side, 0, 0, 1, 1);
    main_widget.attach(canvas, 1, 0, 1, 1);
    main_widget.attach(right_side, 2, 0, 1, 1);

    main_widget.vexpand = true;

    left_side.attach(left_side_label, 0, 0, 1, 1);
    right_side.attach(right_side_label, 0, 0, 1, 1);
    //canvas.attach(canvas_label, 0, 0, 1, 1);
    timeline.attach(timeline_label, 0, 0, 1, 1);

    main_layout.attach(main_widget, 1, 0, 1, 1);
    main_layout.attach(timeline, 0, 1, 3, 1);

    add(main_layout);
    */
  }
}
