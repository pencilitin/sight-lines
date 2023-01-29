import Toybox.Graphics;
import Toybox.Lang;

class BackgroundPattern {
    protected function initialize(color as ColorType, outerRingWidth as Number) {
        self.color = color;
        self.outerRingWidth = outerRingWidth;
        direction = getDirection();
    }

    public function isCurrent(currentColor as ColorType) as Boolean {
        var currentDirection = getDirection();
        if (color != currentColor || direction != currentDirection) {
            color = currentColor;
            direction = currentDirection;
            return false;
        }

        return true;
    }

    public function draw(dc as Dc, backgroundColor as ColorType) as Void {
        // Clear the background.
        dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
        dc.clear();

        // Set up the pen for drawing the pattern.
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);

        // Draw the pattern.
        drawPattern(dc);

        // Clear outer ring.
        var dcWidth = dc.getWidth();
        dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(outerRingWidth);
        dc.drawCircle(dcWidth / 2, dc.getHeight() / 2, (dcWidth - outerRingWidth) / 2);
    }

    protected function drawPattern(dc as Dc) as Void {
    }

    protected function getDirection() as Direction {
        return First;
    }

    protected enum Direction { First, Second }

    protected var color as ColorType;
    protected var outerRingWidth as Number;
    protected var direction as Direction;
}
