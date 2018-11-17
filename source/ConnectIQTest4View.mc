using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;

var partialUpdatesAllowed = false;

class ConnectIQTest4View extends WatchUi.WatchFace {

    private var p;

    function initialize() {
        WatchFace.initialize();
        partialUpdatesAllowed = (Toybox.WatchUi.WatchFace has :onPartialUpdate);
    }

    function onLayout(dc) {
        try {
            p = new Printer(dc);
        } catch (ex) {
            System.println(ex.getErrorMessage());
            ex.printStackTrace();
        }
    }

    function onShow() {
    }

    function onUpdate(dc) {
        try {
            p.AllowPartial(partialUpdatesAllowed);
            p.run(dc);
        } catch (ex) {
            System.println(ex.getErrorMessage());
            ex.printStackTrace();
        }
    }

    function onPartialUpdate(dc) {
        try {
            p.AllowPartial(partialUpdatesAllowed);
            p.runPartial(dc);
        } catch (ex) {
            System.println(ex.getErrorMessage());
            ex.printStackTrace();
        }
    }

    function onHide() {
    }

    function onExitSleep() {
        p.Awaken(true);
    }

    function onEnterSleep() {
        p.Awaken(false);
    }

}

class ConnectIQTest4Delegate extends WatchUi.WatchFaceDelegate {

    function initialize() {
        WatchFaceDelegate.initialize();
    }

    function onPowerBudgetExceeded(powerInfo) {
        System.println("Average execution time: " + powerInfo.executionTimeAverage);
        System.println("Allowed execution time: " + powerInfo.executionTimeLimit);
        partialUpdatesAllowed = false;
    }

}