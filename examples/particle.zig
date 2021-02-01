usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");
usingnamespace @import("QObject");
usingnamespace @import("QVariant");

const string = []u8;

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();
    engine.loadData(@embedFile("particle.qml"));

    var context = engine.rootContext();

    QGuiApplication.exec();
}

const Control = struct {
    pub fn textReleased(self: *Control, text: QObject) void {
        const x = text.Int("x");
        const y = text.Int("y");
        const w = text.Int("width");
        const h = text.Int("height");
        self.Emit(x + 15, y + h / 2);
        self.Emit(x + w / 2, y + h / 2);
        self.Emit(x + w - 15, y + h / 2);
        // go func() {
        // time.Sleep(500 * time.Millisecond)
        // messages := []string{"Hello", "Hello", "Hacks"}
        // ctrl.Message = messages[rand.Intn(len(messages))] + " from Go!"
        // qml.Changed(ctrl, &ctrl.Message)
        // }(
        //)
    }

    pub fn emit(self: *Control, x: i8, y: i8) void {
        const c = self.root.Object("emitterComponent");
        var i: u8 = 0;
        while (i < 8) : (i += 1) {
            const e = c.create();
            e.Set("x", x);
            e.Set("y", y);
            //emitter.Set("targetX", rand.Intn(240)-120+x)
            //emitter.Set("targetY", rand.Intn(240)-120+y)
            //emitter.Set("life", rand.Intn(2400)+200)
            //emitter.Set("emitRate", rand.Intn(32)+32)
            //emitter.ObjectByName("xAnim").Call("start")
            //emitter.ObjectByName("yAnim").Call("start")
            //emitter.Set("enabled", true)
        }
    }

    pub fn done(self: *Control, emitter: QObject) void {
        // emitter.Destroy();
    }
};
