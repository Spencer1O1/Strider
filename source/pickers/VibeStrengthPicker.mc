import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Math;
import Toybox.Application;
import Toybox.System;

class VibeStrengthPicker extends WatchUi.Picker {

    public function initialize() {
        var title = new WatchUi.Text({:text=>"Strength Percentage", :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var factories = new Array<PickerFactory or Text>[1];
        factories[0] = new $.NumberFactory(5, 100, 5, {});
        var defaults = new Array<Number>[factories.size()];

        var defaultStrength;
        if (Toybox has :Storage) {
            defaultStrength = Storage.getValue("vibeStrength");
        } else {
            defaultStrength = Application.getApp().getProperty("vibeStrength");
        }

        defaults[0] = (factories[0] as NumberFactory).getIndex(defaultStrength);
        System.println(defaultStrength);
        System.println(defaults[0]);
        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }

    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

}

class VibeStrengthPickerDelegate extends WatchUi.PickerDelegate {

    public function initialize() {
        PickerDelegate.initialize();
    }

    public function onCancel() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    public function onAccept(values as Array<Number?>) as Boolean {
        var vibeStrength = values[0];

        if(Toybox has :Storage) {
            Storage.setValue("vibeStrength", vibeStrength);
            
        } else {
            Application.getApp().setProperty("vibeStrength", vibeStrength);
        }

        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}