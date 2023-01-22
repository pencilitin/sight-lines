import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SightLinesApp extends Application.AppBase {

    public static const INFO_TYPE_BATTERY as Number = 8;
    public static const INFO_TYPE_CALORIES as Number = 9;

    function initialize() {
        AppBase.initialize();
        loadProperties();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new SightLinesView() ] as Array<Views or InputDelegates>;
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() as Void {
        loadProperties();
        WatchUi.requestUpdate();
    }

    public var properties = {};

    private function loadProperties() {
        properties.put(Properties.backgroundColor, Application.Properties.getValue(Properties.backgroundColor));
        properties.put(Properties.backgroundPattern, Application.Properties.getValue(Properties.backgroundPattern));
        properties.put(Properties.backgroundPatternColor, Application.Properties.getValue(Properties.backgroundPatternColor));
        properties.put(Properties.tickRingColor, Application.Properties.getValue(Properties.tickRingColor));
        properties.put(Properties.hourHandColor, Application.Properties.getValue(Properties.hourHandColor));
        properties.put(Properties.minuteHandColor, Application.Properties.getValue(Properties.minuteHandColor));
        properties.put(Properties.infoColor, Application.Properties.getValue(Properties.infoColor));
        properties.put(Properties.leftInfoType, Application.Properties.getValue(Properties.leftInfoType));
        properties.put(Properties.rightInfoType, Application.Properties.getValue(Properties.rightInfoType));
        properties.put(Properties.bottomInfoType, Application.Properties.getValue(Properties.bottomInfoType));
    }
}

function getApp() as SightLinesApp {
    return Application.getApp() as SightLinesApp;
}
