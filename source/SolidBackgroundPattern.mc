import Toybox.Graphics;
import Toybox.Lang;

class SolidBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }

    public function getType() as Number {
        return 0;
    }

    public function isCurrent(currentColor as ColorType) {
        return BackgroundPattern.isCurrent(currentColor);
    }

    public function draw(dc as Dc, backgroundColor as ColorType) {
        dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
        dc.clear();
    }
}
