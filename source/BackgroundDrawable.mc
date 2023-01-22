import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class BackgroundDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
        backgroundColor = getColor(Properties.backgroundColor);
        backgroundPattern = getApp().properties[Properties.backgroundPattern];
        backgroundPatternColor = getColor(Properties.backgroundPatternColor);
        patternRingWidth = params[:patternRingWidth];
        tickWidth = params[:tickWidth];
        fiveMinuteTickWidth = params[:fiveMinuteTickWidth];
        tickLength = params[:tickLength];
        tickRingColor = getColor(Properties.tickRingColor);

        backgroundBuffer = new BufferedBitmap({
            :width => screenWidth,
            :height => screenHeight });
        drawBackgroundPattern(backgroundBuffer.getDc());
        drawTickRing(backgroundBuffer.getDc());
    }

    public function draw(dc as Dc) as Void {
        var currentBackgroundColor = getColor(Properties.backgroundColor);
        var currentBackgroundPattern = getApp().properties[Properties.backgroundPattern];
        var currentBackgroundPatternColor = getColor(Properties.backgroundPatternColor);
        var currentTickRingColor = getColor(Properties.tickRingColor);
        if (backgroundColor != currentBackgroundColor ||
            backgroundPattern != currentBackgroundPattern ||
            backgroundPatternColor != currentBackgroundPatternColor ||
            tickRingColor != currentTickRingColor) {
            backgroundColor = currentBackgroundColor;
            backgroundPattern = currentBackgroundPattern;
            backgroundPatternColor = currentBackgroundPatternColor;
            tickRingColor = currentTickRingColor;
            drawBackgroundPattern(backgroundBuffer.getDc());
            drawTickRing(backgroundBuffer.getDc());
        }

        dc.drawBitmap(0, 0, backgroundBuffer);
    }

    private function drawBackgroundPattern(dc as Dc) as Void {
        // Set the background color then call to clear the screen.
        dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
        dc.clear();

        switch (backgroundPattern) {
            // Case 0: solid background.
            case 1: {
                // Angled line pattern.
                drawAngledLineBackground(dc);
                break;
            }
        }
    }

    private function drawAngledLineBackground(dc as Dc) as Void {
        // Draw background pattern: angled line pattern
        dc.setColor(backgroundPatternColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);

        var endX = screenWidth - 1;
        for (var x = 0; x < screenWidth; x += 12) {
            dc.drawLine(x, 0, endX, screenHeight - x - 1);
        }
        var endY = screenHeight - 1;
        for (var y = 0; y < screenHeight; y += 12) {
            dc.drawLine(0, y, screenWidth - y - 1, endY);
        }

        // Clear outer ring.
        dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(patternRingWidth);
        dc.drawCircle(screenCenterX, screenCenterY, (screenWidth - patternRingWidth) / 2);
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

    private var backgroundBuffer as BufferedBitmap;
    private var backgroundColor as ColorType;
    private var backgroundPattern as Number;
    private var backgroundPatternColor as ColorType;
    private var patternRingWidth as Number;
    private var tickWidth as Number;
    private var fiveMinuteTickWidth as Number;
    private var tickLength as Number;
    private var tickRingColor as ColorType;
}
