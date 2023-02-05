import Toybox.Graphics;
import Toybox.Lang;

class CircleLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }

    protected function drawPattern(dc as Dc) as Void {
        var dcCenterX = dc.getWidth() / 2;
        var dcCenterY = dc.getHeight() / 2;
        var maxRadius = dcCenterX > dcCenterY ? dcCenterX : dcCenterY;

        for (var r = 12; r < maxRadius; r += 12) {
            dc.drawCircle(dcCenterX, dcCenterY, r);
        }
    }

    protected function getDirection() as BackgroundPattern.Direction {
        return First;
    }
}
