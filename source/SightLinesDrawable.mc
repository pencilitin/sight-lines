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
        if (color == -1) {
            var theme = properties[Properties.theme];
            return themeColors[colorPropertyName][theme];
        }

        return color;
    }

    protected static function min(num1 as Number, num2 as Number) as Number {
        return num1 < num2 ? num1 : num2;
    }

    protected static var screenWidth as Number;
    protected static var screenHeight as Number;
    protected static var screenCenterX as Number;
    protected static var screenCenterY as Number;

    protected const themeColors = {
        Properties.backgroundColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Classic */ Graphics.COLOR_BLACK,
            /* 2 Light */ Graphics.COLOR_WHITE,
            /* 3 Dark */ Graphics.COLOR_BLACK,
            /* 4 Colorful */ Graphics.COLOR_DK_BLUE
        ],
        Properties.backgroundPatternColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Classic */ Graphics.COLOR_BLUE,
            /* 2 Light */ Graphics.COLOR_LT_GRAY,
            /* 3 Dark */ Graphics.COLOR_DK_GRAY,
            /* 4 Colorful */ Graphics.COLOR_BLACK
        ],
        Properties.tickRingColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Classic */ Graphics.COLOR_WHITE,
            /* 2 Light */ Graphics.COLOR_BLACK,
            /* 3 Dark */ Graphics.COLOR_WHITE,
            /* 4 Colorful */ Graphics.COLOR_PURPLE
        ],
        Properties.hourHandColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Classic */ Graphics.COLOR_WHITE,
            /* 2 Light */ Graphics.COLOR_DK_GRAY,
            /* 3 Dark */ Graphics.COLOR_WHITE,
            /* 4 Colorful */ Graphics.COLOR_ORANGE
        ],
        Properties.minuteHandColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Classic */ Graphics.COLOR_WHITE,
            /* 2 Light */ Graphics.COLOR_DK_GRAY,
            /* 3 Dark */ Graphics.COLOR_WHITE,
            /* 4 Colorful */ Graphics.COLOR_RED
        ],
        Properties.infoColor => [
            /* 0 None */ Graphics.COLOR_BLACK,
            /* 1 Classic */ Graphics.COLOR_WHITE,
            /* 2 Light */ Graphics.COLOR_BLACK,
            /* 3 Dark */ Graphics.COLOR_WHITE,
            /* 4 Colorful */ Graphics.COLOR_PINK
        ]
    };
}