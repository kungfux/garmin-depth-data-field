import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class DepthApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new DepthView() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as DepthApp {
    return Application.getApp() as DepthApp;
}