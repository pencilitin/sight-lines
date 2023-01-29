import Toybox.Graphics;
import Toybox.Lang;

class AngledLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }

    public function getType() as Number {
        return 1;
    }

    protected function drawPattern(dc as Dc) as Void {
        var dcWidth = dc.getWidth();
        var dcHeight = dc.getHeight();
        var endX = dcWidth - 1;
        var endY = dcHeight - 1;

        if (direction == First) {
            for (var i = 0; i < dcWidth; i += 12) {
                dc.drawLine(i, 0, endX, endY - i);
                dc.drawLine(0, i, endX - i, endY);
            }
        }
        else {
            for (var i = 0; i < dcWidth; i += 12) {
                dc.drawLine(endX - i, 0, 0, endY - i);
                dc.drawLine(endX, i, i, endY);
            }
        }
    }

    protected function getDirection() as BackgroundPattern.Direction {
        var minute = System.getClockTime().min;
        return (minute >= 0 && minute < 15) || (minute >= 30 && minute < 45) ? First : Second;
    }
}
