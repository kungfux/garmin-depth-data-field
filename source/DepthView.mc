import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.SensorHistory;
import Toybox.System;

class DepthView extends WatchUi.SimpleDataField {

    const SALT_WATER_DENSITY = 1023.6;
    const FRESH_WATER_DENSITY = 997047.4;
    const GRAVITY_ACCELERATION = 9.80665;
    const DENSITY_GRAVITY = SALT_WATER_DENSITY * GRAVITY_ACCELERATION;

    var localPressureSurface as Numeric or Null = null;

    function initialize() {
        SimpleDataField.initialize();
        label = "DEPTH";
    }

    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        var pressure = info.ambientPressure;

        if (pressure == null) {
            return "N/A";
        }

        if (localPressureSurface == null) {
            localPressureSurface = pressure;
        }

        var pressureDiff = pressure - localPressureSurface;

        if (pressureDiff <= 0) {
            return 0;
        }

        return pressureDiff / DENSITY_GRAVITY;
    }
}