import Toybox.Graphics;
import Toybox.Lang;

class ArcLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }

    public function getType() as Number {
        return 3;
    }

    protected function drawPattern(dc as Dc) as Void {
        var dcWidth = dc.getWidth();
        var dcHeight = dc.getHeight();

        if (direction == First) {
            for (var r = dcHeight + dcHeight / 2; r > 0; r -= 12) {
                dc.drawArc(dcWidth, dcHeight, r, Graphics.ARC_CLOCKWISE, 180, 90);
            }
        }
        else {
            for (var r = dcHeight + dcHeight / 2; r > 0; r -= 12) {
                dc.drawArc(0, dcHeight, r, Graphics.ARC_CLOCKWISE, 90, 0);
            }
        }
    }

    protected function getDirection() as BackgroundPattern.Direction {
        var minute = System.getClockTime().min;
        return (minute >= 15 && minute < 30) || minute >= 45 ? First : Second;
    }
}
