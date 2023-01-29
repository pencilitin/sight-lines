import Toybox.Graphics;
import Toybox.Lang;

class WaveLineBackgroundPattern extends BackgroundPattern {
    public function initialize(color as ColorType, outerRingWidth as Number) {
        BackgroundPattern.initialize(color, outerRingWidth);
    }

    public function getType() as Number {
        return 4;
    }

    protected function drawPattern(dc as Dc) as Void {
        var dcWidth = dc.getWidth();
        var dcHeight = dc.getHeight();
        var endX = dcWidth - 1;
        var endY = dcHeight - 1;
        if (direction == First) {
            for (var y = 12; y < dcHeight + waveHeight; y += 12) {
                for (var x = 0; x < dcWidth; x += wavePeriod) {
                    dc.drawLine(x, y, x + waveHalfPeriod, y - waveHeight);
                    dc.drawLine(x + waveHalfPeriod, y - waveHeight, x + wavePeriod, y);
                }
            }
        }
        else {
            for (var x = 0; x < dcWidth - 12; x += 12) {
                for (var y = 0; y < dcHeight; y += wavePeriod) {
                    dc.drawLine(x, y, x + waveHeight, y + waveHalfPeriod);
                    dc.drawLine(x + waveHeight, y + waveHalfPeriod, x, y + wavePeriod);
                }
            }
        }
    }

    protected function getDirection() as BackgroundPattern.Direction {
        var minute = System.getClockTime().min;
        return (minute >= 52 || minute < 7) || (minute >= 22 && minute < 37) ? First : Second;
    }

    private const waveHeight = 15;
    private const waveHalfPeriod = 25;
    private const wavePeriod = 50;
}
