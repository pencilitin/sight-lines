import Toybox.ActivityMonitor;
import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SightLinesView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        leftInfoDrawable = View.findDrawableById("LeftInfo") as InfoDrawable;
        rightInfoDrawable = View.findDrawableById("RightInfo") as InfoDrawable;
        bottomInfoDrawable = View.findDrawableById("BottomInfo") as InfoDrawable;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        dc.clearClip();
        updateInfo();
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

    private function updateInfo() {
        var leftInfoType = getApp().properties[Properties.leftInfoType];
        var leftInfoValue = getInfoValue(leftInfoType);
        leftInfoDrawable.setInfo(leftInfoType, leftInfoValue);
        var rightInfoType = getApp().properties[Properties.rightInfoType];
        var rightInfoValue = getInfoValue(rightInfoType);
        rightInfoDrawable.setInfo(rightInfoType, rightInfoValue);
        var bottomInfoType = getApp().properties[Properties.bottomInfoType];
        var bottomInfoValue = getInfoValue(bottomInfoType);
        bottomInfoDrawable.setInfo(bottomInfoType, bottomInfoValue);
    }

    private static function getInfoValue(infoType) as Number {
        var value = 0;
        var info = ActivityMonitor.getInfo();
        switch (infoType) {
            case Application.GOAL_TYPE_STEPS: {
                value = info.steps;
                break;
            }
            case Application.GOAL_TYPE_FLOORS_CLIMBED: {
                value = info.floorsClimbed;
                break;
            }
            case Application.GOAL_TYPE_ACTIVE_MINUTES: {
                value = info.activeMinutesWeek.total;
                break;
            }
            case SightLinesApp.INFO_TYPE_BATTERY: {
                value = System.getSystemStats().battery.toNumber();
                break;
            }
            case SightLinesApp.INFO_TYPE_CALORIES: {
                value = info.calories;
                break;
            }
        }

        return value;
    }

    private var leftInfoDrawable as InfoDrawable or Null;
    private var rightInfoDrawable as InfoDrawable or Null;
    private var bottomInfoDrawable as InfoDrawable or Null;
}
