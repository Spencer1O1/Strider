import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

import Toybox.Attention;
import Toybox.Timer;
import Toybox.Application.Storage;

class StriderDelegate extends WatchUi.BehaviorDelegate {

    var started = false;

    private var _spm = 180;

    private const spmTimer = new Timer.Timer();

    private var _vibeStrength = 80;
    private var vibeData = [new Attention.VibeProfile(_vibeStrength, 50)];

    function tick() {
        Attention.vibrate(self.vibeData);
    }

    function initialize() {
        BehaviorDelegate.initialize();
    }

    public function onMenu() as Boolean {
        self.spmTimer.stop();
        self.started = false;
        WatchUi.pushView( new $.Rez.Menus.MainMenu(), new $.MainMenuDelegate(), WatchUi.SLIDE_LEFT);
        return true;
    }

    function onSelect() as Boolean {
        if(Toybox has :Storage) {
            self._spm = Storage.getValue("spm");
            self._vibeStrength = Storage.getValue("vibeStrength");
            self.vibeData = [new Attention.VibeProfile(self._vibeStrength, 50)];
        } else {
            self._spm = Application.getApp().getProperty("spm");
            self._vibeStrength = Application.getApp().getProperty("vibeStrength");
            self.vibeData = [new Attention.VibeProfile(self._vibeStrength, 50)];
        }
        
        if(!self.started) {
            self.spmTimer.start(method(:tick), 60000.0d / self._spm.toDouble(), true);
            self.started = true;
        } else {
            self.spmTimer.stop();
            self.started = false;
        }
        return true;
    }
}