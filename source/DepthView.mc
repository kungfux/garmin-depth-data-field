import Toybox.System;
import Toybox.Time;
import Toybox.Lang;

using Toybox.Activity;
using Toybox.WatchUi;
using Toybox.SensorHistory;
using Toybox.FitContributor;

class DepthView extends WatchUi.SimpleDataField {

    const SALT_WATER_DENSITY = 1023.6;
    const FRESH_WATER_DENSITY = 997047.4;
    const GRAVITY_ACCELERATION = 9.80665;
    const DENSITY_GRAVITY = SALT_WATER_DENSITY * GRAVITY_ACCELERATION;

    var depthFitField = null;
    var localPressureSurface as Numeric or Null = null;

    function initialize() {
        SimpleDataField.initialize();
        label = "DEPTH";

        depthFitField = createField(
            "depth",
            0,
            FitContributor.DATA_TYPE_FLOAT,
            {
                :mesgType=>FitContributor.MESG_TYPE_RECORD,
                :units=>"m"
            }
        );
        depthFitField.setData(0.0);
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

        var depth = (pressureDiff / DENSITY_GRAVITY).toFloat();
        depthFitField.setData(depth);
        return depth;
    }
}