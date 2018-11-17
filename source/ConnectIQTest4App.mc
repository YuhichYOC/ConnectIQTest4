using Toybox.Application;

class ConnectIQTest4App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        if (Toybox.WatchUi has :WatchFaceDelegate) {
            return [ new ConnectIQTest4View(), new ConnectIQTest4Delegate() ];
        } else {
            return [ new ConnectIQTest4View() ];
        }
    }

}