import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class MainMenuDelegate extends WatchUi.MenuInputDelegate {
    public function initialize() {
        MenuInputDelegate.initialize();
    }

    public function onMenuItem(item as Symbol) as Void {
        if(item == :StepsPM) {
            WatchUi.pushView(new $.SPMPicker(), new $.SPMPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        } else if (item == :VibrationStrength) {
            WatchUi.pushView(new $.VibeStrengthPicker(), new $.VibeStrengthPickerDelegate(), WatchUi.SLIDE_IMMEDIATE);
        } else {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
    }
}