class Printer {

    private var partialAllowed;
    private var awake;
    private var basicPalette = [
        Graphics.COLOR_BLACK,
        Graphics.COLOR_WHITE
    ];
    private var dialLayer;
    private var dialPrinter;
    private var hHandPrinter;
    private var mHandPrinter;
    private var c1;
    private var c2;

    public function AllowPartial(arg) {
        partialAllowed = arg;
    }

    public function Awaken(arg) {
        awake = arg;
    }

    public function initialize(argDc) {
        awake = true;
        tryAllocLayers(argDc);
        allocPrinters();
        if (dialLayer.success()) {
            c1 = new Class001Date(dialLayer.size());
            c2 = new Class002Second(dialLayer.size(), dialLayer.center());
        }
    }

    public function run(argDc) {
        argDc.clearClip();
        dialPrinter.print(dialLayer);
        hHandPrinter.init(System.getClockTime());
        hHandPrinter.print(dialLayer);
        mHandPrinter.init(System.getClockTime());
        mHandPrinter.print(dialLayer);
        if (dialLayer.success()) {
            argDc.drawBitmap(0, 0, dialLayer.buffer());
        }
        c1.run(argDc, dialLayer);
        c2.run(argDc, partialAllowed, awake);
    }

    public function runPartial(argDc) {
        if (partialAllowed) {
            if (dialLayer.success()) {
                argDc.drawBitmap(0, 0, dialLayer.buffer());
            }
            /*
            c1.runPartial(argDc);
            */
            c2.runPartial(argDc);
        }
    }

    private function tryAllocLayers(arg) {
        dialLayer = new BBLayer();
        dialLayer.tryAllocWithPalette(arg, basicPalette);
    }

    private function allocPrinters() {
        dialPrinter = new DialPrinter();
        hHandPrinter = new HHandPrinter();
        mHandPrinter = new MHandPrinter();
    }

}

class Class001Date {

    private var size;
    private var pos;
    private var dateLayer;
    private var datePrinter;

    public function initialize(arg1size) {
        size = [ arg1size[0], Toybox.Graphics.getFontHeight(Toybox.Graphics.FONT_SMALL) ];
        pos = [ 0, arg1size[1] * 3 / 5 ];
        dateLayer = new BBLayer();
        dateLayer.tryAllocWithSize(size);
        datePrinter = new DatePrinter();
    }

    public function run(argDc, dialLayer) {
        if (dateLayer.success()) {
            var c = dateLayer.context();
            c.drawBitmap(-(pos[0]), -(pos[1]), dialLayer.buffer());
            datePrinter.print(dateLayer);
            argDc.drawBitmap(pos[0], pos[1], dateLayer.buffer());
        }
    }

    public function runPartial(argDc) {
        if (dateLayer.success()) {
            argDc.drawBitmap(pos[0], pos[1], dateLayer.buffer());
        }
    }

}

class Class002Second {

    private var sHandPrinter;

    public function initialize(arg1size, arg2center) {
        sHandPrinter = new SHandPrinter(arg1size, arg2center);
    }

    public function run(argDc, partialAllowed, awake) {
        if (partialAllowed) {
            sHandPrinter.printWithClip(argDc, System.getClockTime());
        } else if (awake) {
            sHandPrinter.print(argDc, System.getClockTime());
        }
    }

    public function runPartial(argDc) {
        sHandPrinter.printWithClip(argDc, System.getClockTime());
    }

}