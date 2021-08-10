import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.Math;
import Toybox.Application;

class SPMPicker extends WatchUi.Picker {

    public function initialize() {
        var title = new WatchUi.Text({:text=>"Steps Per Minute", :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var factories = new Array<PickerFactory or Text>[3];
        factories[0] = new $.NumberFactory(1, 2, 1, {});
        factories[1] = new $.NumberFactory(0, 9, 1, {});
        factories[2] = new $.NumberFactory(0, 9, 1, {});
        var defaults = new Array<Number>[factories.size()];

        var defaultHundreds;
        var defaultTens;
        var defaultOnes;
        var defaultSpm;
        if (Toybox has :Storage) {
            defaultSpm = Storage.getValue("spm");
        } else {
            defaultSpm = Application.getApp().getProperty("spm");
        }

        defaultOnes = defaultSpm%10;
        defaultTens = Math.floor(defaultSpm/10)%10;
        defaultHundreds = Math.floor(defaultSpm/100);

        defaults[0] = (factories[0] as NumberFactory).getIndex(defaultHundreds);
        defaults[1] = (factories[1] as NumberFactory).getIndex(defaultTens);
        defaults[2] = (factories[2] as NumberFactory).getIndex(defaultOnes);

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }

    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class SPMPickerDelegate extends WatchUi.PickerDelegate {

    public function initialize() {
        PickerDelegate.initialize();
    }

    public function onCancel() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    public function onAccept(values as Array<Number?>) as Boolean {
        var hundreds = values[0];
        var tens = values[1];
        var ones = values[2];

        var spm = ones + tens * 10 + hundreds * 100;

        if(Toybox has :Storage) {
            Storage.setValue("spm", spm);
            
        } else {
            Application.getApp().setProperty("spm", spm);
        }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}