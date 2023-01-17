import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class InfoDrawable extends SightLinesDrawable {

    function initialize(params) {
        SightLinesDrawable.initialize(params);
        font = WatchUi.loadResource(Rez.Fonts.InfoFont);
        iconFont = WatchUi.loadResource(Rez.Fonts.IconFont);
        switch (params[:location]) {
            case Left: {
                leftX = 0;
                rightX = screenCenterX;
                infoY = screenCenterY;
                break;
            }
            case Right: {
                leftX = screenCenterX;
                rightX = screenWidth;
                infoY = screenCenterY;
                break;
            }
            case Bottom: {
                leftX = 0;
                rightX = screenWidth;
                infoY = params[:infoY];
                break;
            }
        }
        iconPadding = params[:iconPadding];
    }

    public function draw(dc as Dc) as Void {
        if (infoType == -1) {
            return;
        }

        // Draw the info value.
        var infoTypeString = infoType.toString();
        var currentValueString = infoType == SightLinesApp.INFO_TYPE_BATTERY ? Lang.format("$1$%", [currentValue]) : currentValue.toString();
        var iconWidth = dc.getTextWidthInPixels(infoTypeString, iconFont);
        var currentValueWidth = dc.getTextWidthInPixels(currentValueString, font);
        var startX = leftX + ((rightX - leftX) / 2) - ((iconWidth + currentValueWidth + iconPadding) / 2);

        dc.setColor(getColor(Properties.infoColor), Graphics.COLOR_TRANSPARENT);
        dc.drawText(startX, infoY, iconFont, infoTypeString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(startX + iconWidth + iconPadding, infoY, font, currentValueString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
    }

    public function setInfo(infoType as Number, currentValue as Number) {
        self.infoType = infoType;
        self.currentValue = currentValue;
    }

    enum Location {
        Left = 9,
        Right = 3,
        Bottom = 6
    }

    private var font as FontType;
    private var iconFont as FontType;
    private var leftX as Number = 0;
    private var rightX as Number = 0;
    private var infoY as Number = 0;
    private var iconPadding as Number = 0;

    private var infoType as Number = -1;
    private var currentValue as Number = 0;
}
