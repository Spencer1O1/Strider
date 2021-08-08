import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

import Toybox.Attention;
import Toybox.Timer;

const spm = 180.0d;

class StriderDelegate extends WatchUi.BehaviorDelegate {

    var started = false;

    const spmTimer = new Timer.Timer();

    const vibeData = [new Attention.VibeProfile(100, 50)];

    function tick() {
        Attention.vibrate(vibeData);
    }

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        if(!self.started) {
            self.spmTimer.start(method(:tick), 60000.0d / $.spm, true);
            self.started = true;
        } else {
            self.spmTimer.stop();
            self.started = false;
        }
    }
}