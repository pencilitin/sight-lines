import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class BackgroundDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
    }

    public function draw(dc as Dc) as Void {
        // Set the background color then call to clear the screen
        dc.setColor(Graphics.COLOR_TRANSPARENT, getColor(Properties.backgroundColor));
        dc.clear();
    }
}
