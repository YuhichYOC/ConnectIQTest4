class SHandPrinter {

    private var w;
    private var h;
    private var c;
    private var dotWidth;
    private var penWidth;

    public function initialize(arg1size, arg2center) {
        w = arg1size[0];
        h = arg1size[1];
        c = arg2center;
        dotWidth = 4;
        penWidth = 3;
    }

    public function print(dc, clockTime) {
        dc.setColor(Application.getApp().getProperty("SecondHandColor"), Graphics.COLOR_TRANSPARENT);

        var s = clockTime.sec;
        var position = [
            [ c[0], c[1] ],
            [ c[0], c[1] ],
            [ c[0], c[1] ],
            [ c[0], c[1] ],
            [ c[0], c[1] ]
        ];
        position = fillPosition(position, s);
        dc.setPenWidth(penWidth);
        for (var i = 0; i < 5; ++i) {
            if (c[0] != position[i][0] && c[1] != position[i][1]) {
                dc.drawCircle(position[i][0], position[i][1], dotWidth);
            }
        }
    }

    public function printWithClip(dc, clockTime) {
        dc.setColor(Application.getApp().getProperty("SecondHandColor"), Graphics.COLOR_TRANSPARENT);

        var s = clockTime.sec;
        var position = [
            [ c[0], c[1] ],
            [ c[0], c[1] ],
            [ c[0], c[1] ],
            [ c[0], c[1] ],
            [ c[0], c[1] ]
        ];
        position = fillPosition(position, s);
        var clipRect = generateClipRect(position);
        dc.setClip(
            clipRect[0][0] - (dotWidth * 2) - 1,
            clipRect[0][1] - (dotWidth * 2) - 1,
            clipRect[1][0] - clipRect[0][0] + (dotWidth * 4) + 1,
            clipRect[1][1] - clipRect[0][1] + (dotWidth * 4) + 1
        );
        /*
        dc.drawRectangle(
            clipRect[0][0] - (dotWidth * 2) - 1,
            clipRect[0][1] - (dotWidth * 2) - 1,
            clipRect[1][0] - clipRect[0][0] + (dotWidth * 4) + 1,
            clipRect[1][1] - clipRect[0][1] + (dotWidth * 4) + 1
        );
        */
        dc.setPenWidth(penWidth);
        for (var i = 0; i < 5; ++i) {
            if (c[0] != position[i][0] && c[1] != position[i][1]) {
                dc.drawCircle(position[i][0], position[i][1], dotWidth);
            }
        }
    }

    private function fillPosition(p, s) {
        var radius = (w / 2) - 12;
        /*
        for (var i = s; i >= 0; --i) {
            if (4 < (s - i)) {
                break;
            }
            var angle = (i / 30.0) * Math.PI;
            var cos = Math.cos(angle);
            var sin = Math.sin(angle);
            var x = 0.5 - (-(radius) * sin);
            var y = 0.5 + (-(radius) * cos);
            p[s - i] = [ c[0] + x, c[1] + y ];
        }
        */
        for (var i = s; i > (s - 5); --i) {
            var angle = (i / 30.0) * Math.PI;
            var cos = Math.cos(angle);
            var sin = Math.sin(angle);
            var x = 0.5 - (-(radius) * sin);
            var y = 0.5 + (-(radius) * cos);
            p[s - i] = [ c[0] + x, c[1] + y ];
        }
        return p;
    }

    private function generateClipRect(p) {
        var min = [ w, h ];
        var max = [ 0, 0 ];
        for (var i = 0; i < p.size(); ++i) {
            if (c[0] == p[i][0] && c[1] == p[i][1]) {
                continue;
            }
            if (p[i][0] < min[0]) {
                min[0] = p[i][0];
            }
            if (p[i][1] < min[1]) {
                min[1] = p[i][1];
            }
            if (p[i][0] > max[0]) {
                max[0] = p[i][0];
            }
            if (p[i][1] > max[1]) {
                max[1] = p[i][1];
            }
        }
        return [ min, max ];
    }

}