import Toybox.Graphics;
import Toybox.Lang;

class StraightLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }

    public function getType() as Number {
        return 2;
    }

    protected function drawPattern(dc as Dc) as Void {
        var dcWidth = dc.getWidth();
        var dcHeight = dc.getHeight();
        var endX = dcWidth - 1;
        var endY = dcHeight - 1;
        if (direction == First) {
            for (var y = 0; y < dcHeight; y += 12) {
                dc.drawLine(0, y, endX, y);
            }
        }
        else {
            for (var x = 0; x < dcWidth; x += 12) {
                dc.drawLine(x, 0, x, endY);
            }
        }
    }

    protected function getDirection() as BackgroundPattern.Direction {
        var minute = System.getClockTime().min;
        return (minute >= 52 || minute < 7) || (minute >= 22 && minute < 37) ? First : Second;
    }
}
