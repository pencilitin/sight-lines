import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class BackgroundDrawable extends WatchUi.Drawable {

    function initialize(params as Dictionary) {
        Drawable.initialize(params);
    }

    public function draw(dc as Dc) as Void {
        // Set the background color then call to clear the screen
        dc.setColor(Graphics.COLOR_TRANSPARENT, getApp().getProperty("BackgroundColor") as Number);
        dc.clear();
    }
}
