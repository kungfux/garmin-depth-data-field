import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.SensorHistory;
import Toybox.System;

class DepthView extends WatchUi.SimpleDataField {

    const DEFAULT_PRESSURE_SURFACE = 100930;
    const SALT_WATER_DENSITY = 1023.6;
    const FRESH_WATER_DENSITY = 997047.4;
    const GRAVITY_ACCELERATION = 9.80665;
    const DENSITY_GRAVITY = SALT_WATER_DENSITY * GRAVITY_ACCELERATION;

    function initialize() {
        SimpleDataField.initialize();
        label = "DEPTH";
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        var pressure = info.ambientPressure;

        var pressureDiff = pressure - DEFAULT_PRESSURE_SURFACE;

        if (pressureDiff <= 0) {
            return 0;
        }

        return pressureDiff / DENSITY_GRAVITY;
    }
}