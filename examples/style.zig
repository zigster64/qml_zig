const std = @import("std");
usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");
usingnamespace @import("QQuickStyle");

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    // This should work, but doesnt seem to work :(
    QQuickStyle.set("Flat");

    // You can however get the same effect by doing
    // export export QT_QUICK_CONTROLS_STYLE=Flat
    // in the shell and then running any app - it will use the Flat style

    // TODO  - investigate why setStyle() doesnt seem to work

    engine.loadData(@embedFile("style.qml"));
    QGuiApplication.exec();
}
