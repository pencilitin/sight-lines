import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;

class DateDrawable extends SightLinesDrawable {
    function initialize(params) {
        SightLinesDrawable.initialize(params);
        dateY = params[:dateY];      
    }
    
    function draw(dc) {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var date = Lang.format("$1$ $2$", [today.day_of_week, today.day]);
        
        // Draw date.
        dc.setColor(getColor(Properties.infoColor), Graphics.COLOR_TRANSPARENT);
        dc.drawText(screenCenterX, dateY, Graphics.FONT_MEDIUM, date, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
    
    private var dateY as Number;
}
