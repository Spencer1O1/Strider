import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.System;

class StriderApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        if(Toybox has :Storage) {
            if(Storage.getValue("spm") == null) {
                Storage.setValue("spm", 180);
            }
            if(Storage.getValue("vibeStrength") == null) {
                Storage.setValue("vibeStrength", 80);
            }
        } else {
            if(AppBase.getProperty("spm") == null) {
                AppBase.setProperty("spm", 180);
            }
            if(AppBase.getProperty("vibeStrength") == null) {
                AppBase.setProperty("vibeStrength", 80);
            }
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new StriderView(), new StriderDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as StriderApp {
    return Application.getApp() as StriderApp;
}