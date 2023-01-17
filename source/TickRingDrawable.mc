import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class TickRingDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
        tickWidth = params[:tickWidth];
        fiveMinuteTickWidth = params[:fiveMinuteTickWidth];
        tickLength = params[:tickLength];
        tickRingColor = getColor(Properties.tickRingColor);

        tickRingBuffer = new BufferedBitmap({
            :width => screenWidth,
            :height => screenHeight });
        drawTickRing(tickRingBuffer.getDc());
    }

    public function draw(dc as Dc) as Void {
        var currentTickRingColor = getColor(Properties.tickRingColor);
        if (tickRingColor != currentTickRingColor) {
            tickRingColor = currentTickRingColor;
            drawTickRing(tickRingBuffer.getDc());
        }
        
        dc.drawBitmap(0, 0, tickRingBuffer);
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

    private var tickRingBuffer as BufferedBitmap;
    private var tickWidth as Number;
    private var fiveMinuteTickWidth as Number;
    private var tickLength as Number;
    private var tickRingColor as ColorType;
}
