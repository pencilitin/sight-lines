import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class BackgroundDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
        outerRingWidth = params[:outerRingWidth];
        backgroundColor = getColor(Properties.backgroundColor);

        backgroundBuffer = new BufferedBitmap({
            :width => screenWidth,
            :height => screenHeight });
        drawBackground(backgroundBuffer.getDc());
    }

    public function draw(dc as Dc) as Void {
        var currentBackgroundColor = getColor(Properties.backgroundColor);
        if (backgroundColor != currentBackgroundColor) {
            backgroundColor = currentBackgroundColor;
            drawBackground(backgroundBuffer.getDc());
        }

        dc.drawBitmap(0, 0, backgroundBuffer);
    }

    private function drawBackground(dc as Dc) as Void {
        // Set the background color then call to clear the screen.
        dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
        dc.clear();

        // Draw background pattern: angled line pattern
        dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);

        var endX = screenWidth - 1;
        for (var x = 0; x < screenWidth; x += 10) {
            dc.drawLine(x, 0, endX, screenHeight - x - 1);
        }
        var endY = screenHeight - 1;
        for (var y = 0; y < screenHeight; y += 10) {
            dc.drawLine(0, y, screenWidth - y - 1, endY);
        }

        // Clear outer ring.
        dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(outerRingWidth);
        dc.drawCircle(screenCenterX, screenCenterY, (screenWidth - outerRingWidth) / 2);
    }

    private var backgroundBuffer as BufferedBitmap;
    private var outerRingWidth as Number;
    private var backgroundColor as ColorType;
}
