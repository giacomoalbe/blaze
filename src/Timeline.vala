public class Blaze.Timeline : Gtk.Box {
  private const int BAR_HEIGHT = 20;

  private int current { get; set; }
  private int start_frame { get; set; }
  private int end_frame { get; set; }

  private int width { get; set; }
  private int height { get; set; }

  private int ticks { get; set; }

  private bool button_pressed { get; set; }

  public Timeline () {
    Object(
      orientation: Gtk.Orientation.VERTICAL
    );
  }

  construct {
    set_has_window (false);

    var event_box = new Gtk.EventBox ();

    event_box.set_events(
      Gdk.EventMask.BUTTON_PRESS_MASK |
      Gdk.EventMask.POINTER_MOTION_MASK |
      Gdk.EventMask.BUTTON_RELEASE_MASK
    );

    event_box.button_press_event.connect((event) => {
      button_pressed = true;

      update_current_position (event.motion.x);
    });

    event_box.button_release_event.connect((event) => {
      button_pressed = false;
    });

    event_box.motion_notify_event.connect((event) => {
      if (button_pressed) {
        //print("Pointer motion: (%d, %d)\n", (int)event.motion.x, (int)event.motion.y);

        update_current_position (event.motion.x);
      }
    });

    event_box.hexpand = true;

    event_box.set_size_request (600, BAR_HEIGHT);

    hexpand = true;

    add (event_box);

    set_size_request (600, 120);

    start_frame = 20;
    end_frame = 60;
    current = 20;
    ticks = 80;
  }

  private void update_current_position (double x_pos) {
      int frame_hit = (int)(((int) x_pos) * ticks / width);

      frame_hit = (int) Math.fmax(frame_hit, start_frame);
      frame_hit = (int) Math.fmin(frame_hit, end_frame);

      current = frame_hit;

      queue_draw ();
  }

  public override bool draw (Cairo.Context ctx) {
    width = get_allocated_width ();
    height = get_allocated_height ();

    double tick_spacing = width / ticks;

    double LINE_COLOR = 0.160784314;
    double OUT_COLOR = 0.2;
    string BAR_COLOR = "#2B2B2B";
    double IN_COLOR = 0.258823529;

    int RECT_MIN_WIDTH = 25;
    int RECT_PADDING = 4;

    ctx.set_source_rgb (OUT_COLOR, OUT_COLOR, OUT_COLOR);
    ctx.paint ();

    Util.ctx_set_color(BAR_COLOR, ctx);

    ctx.move_to (0, 0);

    ctx.line_to (0, BAR_HEIGHT);
    ctx.line_to (width, BAR_HEIGHT);
    ctx.line_to (width, 0);
    ctx.line_to (0, 0);

    ctx.fill ();

    ctx.set_source_rgb (IN_COLOR, IN_COLOR, IN_COLOR);

    ctx.move_to (start_frame * tick_spacing, BAR_HEIGHT);

    ctx.line_to (start_frame * tick_spacing, height);
    ctx.line_to (end_frame * tick_spacing, height);
    ctx.line_to (end_frame * tick_spacing, BAR_HEIGHT);
    ctx.line_to (start_frame * tick_spacing, BAR_HEIGHT);

    ctx.fill ();

    double line_width = 0;

    for (var i = 0; i < ticks; i++) {
      line_width = 0;

      if ((i + 2) % 4 == 0) {
        line_width = 0.4;
      }

      if (
        i % 4 == 0 ||
        i == current ||
        i == start_frame ||
        i == end_frame
      ) {
        line_width = 1;
      }

      ctx.set_source_rgb (LINE_COLOR, LINE_COLOR, LINE_COLOR);

      if (i == current) {
        Cairo.TextExtents extents;

        ctx.set_font_size (10.0);
        ctx.text_extents (current.to_string(), out extents);

        var rect_width = Math.fmin(
          RECT_MIN_WIDTH,
          2 * RECT_PADDING + extents.width
        );

        Util.ctx_set_color ("#5680C2", ctx);
        Util.ctx_round_rect (i * tick_spacing - rect_width / 2, 2, 5, rect_width, BAR_HEIGHT - 4, ctx);
        ctx.fill ();

        Util.ctx_set_color("#ffffff", ctx);

        ctx.move_to (
          i * tick_spacing - (rect_width / 2 - RECT_PADDING),
          (BAR_HEIGHT + extents.height) / 2
        );

        ctx.show_text (current.to_string ());

        Util.ctx_set_color ("#5680C2", ctx);
      }

      ctx.set_line_width (line_width);

      ctx.move_to (i * tick_spacing, BAR_HEIGHT);
      ctx.line_to (i * tick_spacing, height);

      ctx.stroke ();
    }

    return false;
  }
}
