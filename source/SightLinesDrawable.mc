import Toybox.Lang;
import Toybox.WatchUi;

class SightLinesDrawable extends WatchUi.Drawable {
    protected function initialize(params) {
        Drawable.initialize(params);

        var settings = System.getDeviceSettings();
        screenWidth = settings.screenWidth;
        screenHeight = settings.screenHeight;
        screenCenterX = screenWidth / 2;
        screenCenterY = screenHeight / 2;
    }

    protected function getColor(colorPropertyName as String) as Number {
        var properties = getApp().properties;
        var color = properties[colorPropertyName];
        return color;
    }

    protected static function min(num1 as Number, num2 as Number) as Number {
        return num1 < num2 ? num1 : num2;
    }

    protected static var screenWidth as Number;
    protected static var screenHeight as Number;
    protected static var screenCenterX as Number;
    protected static var screenCenterY as Number;
}