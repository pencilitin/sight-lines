import Toybox.Graphics;
import Toybox.Lang;

class ArcLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }

    public function getType() as Number {
        return 3;
    }

    public function isCurrent(currentColor as ColorType) as Boolean {
        var currentDirection = getDirection();
        if (!BackgroundPattern.isCurrent(currentColor) || direction != currentDirection) {
            direction = currentDirection;
            return false;
        }

        return true;
    }

    public function draw(dc as Dc, backgroundColor as ColorType) as Void {
        var dcWidth = dc.getWidth();
        var dcHeight = dc.getHeight();

        dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
        dc.clear();

        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);

        if (direction == Left) {
            for (var r = dcHeight + dcHeight / 2; r > 0; r -= 12) {
                dc.drawArc(dcWidth, dcHeight, r, Graphics.ARC_CLOCKWISE, 180, 90);
            }
        }
        else {
            for (var r = dcHeight + dcHeight / 2; r > 0; r -= 12) {
                dc.drawArc(0, dcHeight, r, Graphics.ARC_CLOCKWISE, 90, 0);
            }
        }

        // Clear outer ring.
        dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(outerRingWidth);
        dc.drawCircle(dcWidth / 2, dcHeight / 2, (dcWidth - outerRingWidth) / 2);
    }

    private function getDirection() as Direction {
        var minute = System.getClockTime().min;
        return (minute >= 15 && minute < 30) || minute >= 45 ? Left : Right;
    }

    private enum Direction { Left, Right }

    private var direction as Direction;
}