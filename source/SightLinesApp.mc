import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SightLinesApp extends Application.AppBase {

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
        properties.put(Properties.tickRingColor, Application.Properties.getValue(Properties.tickRingColor));
        properties.put(Properties.dateColor, Application.Properties.getValue(Properties.dateColor));
    }
}

function getApp() as SightLinesApp {
    return Application.getApp() as SightLinesApp;
}
