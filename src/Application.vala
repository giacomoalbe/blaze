public class Blaze.Application : Gtk.Application {
  protected override void activate() {
    var window = new Blaze.Window(this);

    this.add_window(window);
  }
}
