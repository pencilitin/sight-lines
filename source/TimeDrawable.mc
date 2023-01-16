import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class TimeDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
        var radiusLength = min(screenWidth / 2, screenHeight / 2);
        hourHandLength = radiusLength - params[:hourHandRadiusDifference];
        hourHandWidth = params[:hourHandWidth];
        minuteHandLength = radiusLength - params[:minuteHandRadiusDifference];
        minuteHandWidth = params[:minuteHandWidth];
    }

    public function draw(dc as Dc) as Void {
        var clockTime = System.getClockTime();

        // Draw the hour hand.
        var hourHandAngle = (clockTime.hour % 12) * 5 + clockTime.min / 12.0;
        hourHandAngle = hourHandAngle / 60.0 * Math.PI * 2 - ninetyDegreesInRadians;
        drawHand(dc, screenCenterX, screenCenterY, hourHandAngle, hourHandLength, hourHandWidth, getColor(Properties.hourHandColor));

        // Draw minute hand.
        var minuteHandAngle = clockTime.min / 60.0 * Math.PI * 2 - ninetyDegreesInRadians;
        drawHand(dc, screenCenterX, screenCenterY, minuteHandAngle, minuteHandLength, minuteHandWidth, getColor(Properties.minuteHandColor));
    }

    private function drawHand(dc as Dc, x as Number, y as Number, angle as Float, length as Number, width as Number, color as ColorType) as Void {
        var endX = Math.cos(angle) * length + x;
        var endY = Math.sin(angle) * length + y;
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(width + 2);
        dc.drawLine(x, y, endX, endY);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(width);
        dc.drawLine(x, y, endX, endY);
    }

    private var hourHandLength as Number;
    private var hourHandWidth as Number;
    private var minuteHandLength as Number;
    private var minuteHandWidth as Number;
    private static const ninetyDegreesInRadians as Float = 1.570796;
}
