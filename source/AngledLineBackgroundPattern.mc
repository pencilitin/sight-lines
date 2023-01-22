import Toybox.Graphics;
import Toybox.Lang;

class AngledLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
        direction = getDirection();
    }

    public function getType() as Number {
        return 1;
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
        if (direction == Right) {
            for (var x = 0; x < dcWidth; x += 12) {
                dc.drawLine(x, 0, endX, endY - x);
                dc.drawLine(0, x, endX - x, endY);
            }
        }
        else {
            for (var x = 0; x < dcWidth; x += 12) {
                dc.drawLine(endX - x, 0, 0, endY - x);
                dc.drawLine(endX, x, x, endY);
            }
        }

        // Clear outer ring.
        dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(outerRingWidth);
        dc.drawCircle(dcWidth / 2, dcHeight / 2, (dcWidth - outerRingWidth) / 2);
    }

    private function getDirection() as Direction {
        var minute = System.getClockTime().min;
        return (minute >= 0 && minute < 15) || (minute >= 30 && minute < 45) ? Right : Left;
    }

    private enum Direction { Left, Right }

    private var direction as Direction;
}