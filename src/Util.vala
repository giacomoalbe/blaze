class Blaze.Util {
  public static void ctx_set_color(string hex_color, owned Cairo.Context ctx) {
    var color = Gdk.RGBA ();
    color.parse (hex_color);

    ctx.set_source_rgb(
      color.red,
      color.green,
      color.blue
    );
  }

  public static void ctx_round_rect(double x, double y, double radius, double width, double height, owned Cairo.Context ctx) {
    double degrees = Math.PI / 180.0;

    ctx.new_path ();

    ctx.arc (x + width - radius, y + radius, radius, -90 * degrees, 0 * degrees);
    ctx.arc (x + width - radius, y + height - radius, radius, 0 * degrees, 90 * degrees);
    ctx.arc (x + radius, y + height - radius, radius, 90 * degrees, 180 * degrees);
    ctx.arc (x + radius, y + radius, radius, 180 * degrees, 270 * degrees);

    ctx.close_path ();

    ctx.fill ();
  }
}
