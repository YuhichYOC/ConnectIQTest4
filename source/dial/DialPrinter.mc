class DialPrinter {

    private var penWidth;
    private var fc;
    private var bc;

    public function print(l) {
        penWidth = 2;
        setColorsToFill();
        fill(l);
        setColorsToPrint();
        printHashMarksForRound(l);
        printArbor(l);
    }

    private function setColorsToFill() {
        if (0x000000 == Application.getApp().getProperty("BackgroundColor")) {
            fc = Graphics.COLOR_BLACK;
            bc = Graphics.COLOR_WHITE;
        } else {
            fc = Graphics.COLOR_WHITE;
            bc = Graphics.COLOR_BLACK;
        }
    }

    private function fill(l) {
        if (l.success()) {
            var c = l.context();
            c.setColor(fc, bc);
            c.fillRectangle(0, 0, l.size()[0], l.size()[1]);
        }
    }

    private function setColorsToPrint() {
        if (0x000000 == Application.getApp().getProperty("BackgroundColor")) {
            fc = Graphics.COLOR_WHITE;
            bc = Graphics.COLOR_TRANSPARENT;
        } else {
            fc = Graphics.COLOR_BLACK;
            bc = Graphics.COLOR_TRANSPARENT;
        }
    }

    private function printHashMarksForRound(l) {
        if (l.success()) {
            var c = l.context();

            var outerRad = l.size()[0] / 2;
            var innerRad = outerRad - 20;
            var offset = 2;
            c.setColor(fc, bc);
            c.setPenWidth(penWidth);
            for (var i = 0; i < 12; ++i) {
                var sX = outerRad + innerRad * Math.cos((Math.PI / 6) * i);
                var eX = outerRad + outerRad * Math.cos((Math.PI / 6) * i);
                var sY = outerRad + innerRad * Math.sin((Math.PI / 6) * i);
                var eY = outerRad + outerRad * Math.sin((Math.PI / 6) * i);
                if (0 == i || 6 == i) {
                    c.drawLine(sX, sY - offset, eX, eY - offset);
                    c.drawLine(sX, sY + offset, eX, eY + offset);
                } else if (3 == i || 9 == i) {
                    c.drawLine(sX - offset, sY, eX - offset, eY);
                    c.drawLine(sX + offset, sY, eX + offset, eY);
                } else {
                    c.drawLine(sX, sY, eX, eY);
                }
            }
        }
    }

    private function printArbor(l) {
        if (l.success()) {
            var c = l.context();
            var r = 8;
            c.setColor(fc, bc);
            c.setPenWidth(penWidth);
            c.drawCircle(l.center()[0], l.center()[1], r);
        }
    }

}