const dos = @import("DOtherSide");
const std = @import("std");
const c_str = [*c]u8;

usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");
usingnamespace @import("QMetaObject");
usingnamespace @import("QVariant");

const Person = struct {
    vptr: ?*dos.DosQObject,
    counter: i32,

    pub fn setCounter(self: *Person, i: i32) void {
        std.debug.print("setCounter: {}\n", .{i});
        self.counter = i;
        self.counterChanged();
    }
    pub fn getCounter(self: Person) i32 {
        std.debug.print("getCounter: {}\n", .{self.counter});
        return self.counter;
    }
    pub fn increment(self: *Person) void {
        self.counter += 1;
        self.counterChanged();
    }
    pub fn counterChanged(self: Person) void {
        std.debug.print("counterChanged to {}\n", .{self.counter});
    }
};

pub fn staticSlotCallback(vptr: ?*c_void, slot_name: ?*c_void, num_params: c_int, params: [*c]?*c_void) callconv(.C) void {
    var sn = QVariant.wrap(slot_name);
    std.debug.print("QML Wants to call slot {s}\n", .{sn.getValue(c_str)});
    // TODO find the function matching the slot name, somehow

    var i: usize = 1;
    while (i < num_params) : (i += 1) {
        var v = QVariant.wrap(params[i]);
        std.debug.print("  param {} = {}\n", .{ i, v.getValue(i32) });
    }
}

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    var meta = try QMetaObject.create(dos.dos_qobject_qmetaobject(), Person);

    var person = Person{ .counter = 11, .vptr = null };
    person.vptr = dos.dos_qobject_create(&person, meta.vptr, staticSlotCallback);
    std.debug.print("person vptr {}\n", .{person.vptr});

    var variant = QVariant.create(null);
    dos.dos_qvariant_setQObject(variant.vptr, person.vptr);

    engine.rootContext().setContextProperty("person", variant);
    engine.loadData(@embedFile("button.qml"));
    QGuiApplication.exec();
}
