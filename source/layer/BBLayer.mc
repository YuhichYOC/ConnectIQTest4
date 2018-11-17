class BBLayer {

    private var bb;
    private var s;
    private var w;
    private var h;
    private var cent;

    public function tryAlloc(dc) {
        s = false;
        if (Toybox.Graphics has :BufferedBitmap) {
            bb = new Toybox.Graphics.BufferedBitmap( {
                :width => dc.getWidth(),
                :height => dc.getHeight()
            } );
            s = true;
            w = bb.getDc().getWidth();
            h = bb.getDc().getHeight();
            cent = [ w / 2, h / 2 ];
        }
    }

    public function tryAllocWithPalette(arg1dc, arg2palette) {
        s = false;
        if (Toybox.Graphics has :BufferedBitmap) {
            bb = new Toybox.Graphics.BufferedBitmap( {
                :width => arg1dc.getWidth(),
                :height => arg1dc.getHeight(),
                :palette => arg2palette
            } );
            s = true;
            w = bb.getDc().getWidth();
            h = bb.getDc().getHeight();
            cent = [ w / 2, h / 2 ];
        }
    }

    public function tryAllocWithSize(size) {
        s = false;
        if (Toybox.Graphics has :BufferedBitmap) {
            bb = new Toybox.Graphics.BufferedBitmap( {
                :width => size[0],
                :height => size[1]
            } );
            s = true;
            w = bb.getDc().getWidth();
            h = bb.getDc().getHeight();
            cent = [ w / 2, h / 2 ];
        }
    }

    public function buffer() {
        return bb;
    }

    public function success() {
        return s;
    }

    public function context() {
        return bb.getDc();
    }

    public function size() {
        var ret = [ w, h ];
        return ret;
    }

    public function center() {
        return cent;
    }

}