import Toybox.Graphics;
import Toybox.Lang;

class SolidBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }
}
