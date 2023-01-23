import Toybox.Graphics;
import Toybox.Lang;

class StraightLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
        direction = getDirection();
    }

    public function getType() as Number {
        return 2;
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

        var endX = dcWidth - 1;
        var endY = dcHeight - 1;
        if (direction == Horizontal) {
            for (var y = 0; y < dcHeight; y += 12) {
                dc.drawLine(0, y, endX, y);
            }
        }
        else {
            for (var x = 0; x < dcWidth; x += 12) {
                dc.drawLine(x, 0, x, endY);
            }
        }

        // Clear outer ring.
        dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(outerRingWidth);
        dc.drawCircle(dcWidth / 2, dcHeight / 2, (dcWidth - outerRingWidth) / 2);
    }

    private function getDirection() as Direction {
        var minute = System.getClockTime().min;
        return (minute >= 52 || minute < 7) || (minute >= 22 && minute < 37) ? Horizontal : Vertical;
    }

    private enum Direction { Horizontal, Vertical }

    private var direction as Direction;
}