import Toybox.Graphics;
import Toybox.Lang;

class BackgroundPattern {
    protected function initialize(color as ColorType, outerRingWidth as Number) {
        self.color = color;
        self.outerRingWidth = outerRingWidth;
    }

    public function getType() as Number {
        throw new AbstractFunctionException();
    }

    public function isCurrent(currentColor as ColorType) as Boolean {
        if (color != currentColor) {
            color = currentColor;
            return false;
        }

        return true;
    }

    public function draw(dc as Dc, backgroundColor as ColorType) as Void {
        throw new AbstractFunctionException();
    }

    protected var color as ColorType;
    protected var outerRingWidth as Number;
}
