import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class BackgroundDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
        backgroundColor = getColor(Properties.backgroundColor);
        patternRingWidth = params[:patternRingWidth];
        backgroundPattern = createBackgroundPattern(
            getApp().properties[Properties.backgroundPattern],
            getColor(Properties.backgroundPatternColor),
            patternRingWidth);
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
        var currentTickRingColor = getColor(Properties.tickRingColor);
        if (backgroundColor != currentBackgroundColor ||
            backgroundPattern.getType() != currentBackgroundPatternType ||
            !backgroundPattern.isCurrent(currentBackgroundPatternColor) ||
            tickRingColor != currentTickRingColor) {

            backgroundColor = currentBackgroundColor;
            tickRingColor = currentTickRingColor;
            if (backgroundPattern.getType() != currentBackgroundPatternType) {
                backgroundPattern = createBackgroundPattern(currentBackgroundPatternType, currentBackgroundPatternColor, patternRingWidth);
            }

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

    private static function createBackgroundPattern(backgroundPatternType as Number, backgroundPatternColor as ColorType, patternRingWidth as Number) as BackgroundPattern {
        switch (backgroundPatternType) {
            case 1: {
                return new AngledLineBackgroundPattern(backgroundPatternColor, patternRingWidth);
            }
            case 2: {
                return new StraightLineBackgroundPattern(backgroundPatternColor, patternRingWidth);
            }
        }

        return new SolidBackgroundPattern(backgroundPatternColor, patternRingWidth);
    }

    private var backgroundBuffer as BufferedBitmap;
    private var backgroundColor as ColorType;
    private var patternRingWidth as Number;
    private var backgroundPattern as BackgroundPattern;
    private var tickWidth as Number;
    private var fiveMinuteTickWidth as Number;
    private var tickLength as Number;
    private var tickRingColor as ColorType;
}
