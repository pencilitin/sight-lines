import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;

class BackgroundDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
        backgroundPatternType = getApp().properties[Properties.backgroundPattern];
        backgroundColor = getColor(Properties.backgroundColor);
        patternRingWidth = params[:patternRingWidth];
        backgroundPattern = createBackgroundPattern();
        surpriseMeDay = getDay();
        tickWidth = params[:tickWidth];
        fiveMinuteTickWidth = params[:fiveMinuteTickWidth];
        tickLength = params[:tickLength];
        tickRingColor = getColor(Properties.tickRingColor);

        backgroundBuffer = new BufferedBitmap({ :width => screenWidth, :height => screenHeight });
        backgroundPattern.draw(backgroundBuffer.getDc(), backgroundColor);
        drawTickRing(backgroundBuffer.getDc());
    }

    public function draw(dc as Dc) as Void {
        // If any of the colors or pattern has changed, redraw the buffered bitmap.
        var currentBackgroundColor = getColor(Properties.backgroundColor);
        var currentBackgroundPatternType = getApp().properties[Properties.backgroundPattern];
        var currentBackgroundPatternColor = getColor(Properties.backgroundPatternColor);
        var currentSurpriseMeDay = getDay();
        var currentTickRingColor = getColor(Properties.tickRingColor);
        if (backgroundColor != currentBackgroundColor ||
            backgroundPatternType != currentBackgroundPatternType ||
            !backgroundPattern.isCurrent(currentBackgroundPatternColor) ||
            surpriseMeDay != currentSurpriseMeDay ||
            tickRingColor != currentTickRingColor) {

            backgroundColor = currentBackgroundColor;
            if (backgroundPatternType != currentBackgroundPatternType || 
                (backgroundPatternType == surpriseMePatternType && (surpriseMeDay != currentSurpriseMeDay))) {
                backgroundPatternType = currentBackgroundPatternType;
                surpriseMeDay = currentSurpriseMeDay;
                backgroundPattern = createBackgroundPattern();
            }
            tickRingColor = currentTickRingColor;

            backgroundPattern.draw(backgroundBuffer.getDc(), backgroundColor);
            drawTickRing(backgroundBuffer.getDc());
        }

        dc.drawBitmap(0, 0, backgroundBuffer);
    }

    private function drawTickRing(dc as Dc) as Void {
        dc.setColor(tickRingColor, Graphics.COLOR_TRANSPARENT);
        var outerRadius = dc.getWidth() / 2;
        var innerRadius = outerRadius - tickLength;

        dc.setPenWidth(tickWidth);
        for (var i = 0; i <= Math.PI * 2; i += Math.PI / 30) {
            var xStart = outerRadius + innerRadius * Math.cos(i);
            var xEnd = outerRadius + outerRadius * Math.cos(i);
            var yStart = outerRadius + innerRadius * Math.sin(i);
            var yEnd = outerRadius + outerRadius * Math.sin(i);
            dc.drawLine(xStart, yStart, xEnd, yEnd);
        }

        dc.setPenWidth(fiveMinuteTickWidth);
        for (var i = 0; i <= Math.PI * 2; i += Math.PI / 6) {
            var xStart = outerRadius + innerRadius * Math.cos(i);
            var xEnd = outerRadius + outerRadius * Math.cos(i);
            var yStart = outerRadius + innerRadius * Math.sin(i);
            var yEnd = outerRadius + outerRadius * Math.sin(i);
            dc.drawLine(xStart, yStart, xEnd, yEnd);
        }
    }

    private function createBackgroundPattern() as BackgroundPattern {
        var newBackgroundPatternType = backgroundPatternType == surpriseMePatternType ? Math.rand() % 4 + 1 : backgroundPatternType;
        var backgroundPatternColor = getColor(Properties.backgroundPatternColor);
        switch (newBackgroundPatternType) {
            case 1: {
                return new AngledLineBackgroundPattern(backgroundPatternColor, patternRingWidth);
            }
            case 2: {
                return new StraightLineBackgroundPattern(backgroundPatternColor, patternRingWidth);
            }
            case 3: {
                return new ArcLineBackgroundPattern(backgroundPatternColor, patternRingWidth);
            }
            case 4: {
                return new WaveLineBackgroundPattern(backgroundPatternColor, patternRingWidth);
            }
        }

        return new SolidBackgroundPattern(backgroundPatternColor, patternRingWidth);
    }

    private static function getDay() as Number {
        return Gregorian.info(Time.now(), Time.FORMAT_SHORT).day;
    }

    private var backgroundBuffer as BufferedBitmap;
    private var backgroundPattern as BackgroundPattern;
    // Keep background settings used to draw background and
    // to detect changes that force redrawing the background.
    private var backgroundPatternType as Number;
    private var backgroundColor as ColorType;
    private var patternRingWidth as Number;
    private var surpriseMeDay as Number;
    // Keep tick ring settings used to draw tick ring and
    // to detect changes that force redrawing the background.
    private var tickWidth as Number;
    private var fiveMinuteTickWidth as Number;
    private var tickLength as Number;
    private var tickRingColor as ColorType;

    private const surpriseMePatternType = -1;
}
