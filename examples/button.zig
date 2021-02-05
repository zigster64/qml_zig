usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    var mo = dos.dos_qobject_qmetaobject();
    //var metaObject = try QMetaObject.create(dos.dos_qobject_qmetaobject(), Person);
    var metaObject = try QMetaObject.create(mo, Person);

    var person = Person{ .counter = 1, .vptr = null };
    //person.vptr = dos.dos_qobject_create(&person, metaObject.vptr, generateQObjectCallback(Person));

    var variant = QVariant.create(null);
    dos.dos_qvariant_setQObject(variant.vptr, person.vptr);

    engine.rootContext().setContextProperty("person", variant);
    engine.loadData(@embedFile("button.qml"));
    QGuiApplication.exec();
}

const Person = struct {
    const counterChanged = Signal(Person, "counterChanged", .{i32});
    vptr: ?*dos.DosQObject,
    counter: i32,
    name: []u8 = undefined,

    pub fn setCounter(Self: *Person, i: i32) void {
        std.debug.print("setCounter: {}\n", .{i});
        Self.counter = i;
        Self.counterChanged(i);
    }
    pub fn getCounter(Self: Person) i32 {
        std.debug.print("getCounter: {}\n", .{Self.counter});
        return Self.counter;
    }
};
