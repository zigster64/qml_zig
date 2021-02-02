usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    engine.setStyle("Flat");

    engine.loadData(@embedFile("style.qml"));
    QGuiApplication.exec();
}
