const std = @import("std");
usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");
usingnamespace @import("QVariant");

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    var values = [_]u8{ 42, 43 };
    // Use a number of QVariants to pass values to the app
    engine.setValue("qVar1", QVariant.create(10));
    engine.setValue("qVar2", QVariant.create(20));
    engine.setValue("qVar3", QVariant.create(false));
    engine.setValue("qVar4", QVariant.create(@as(f64, 23.45)));
    engine.setValue("values", QVariant.create(&values));
    engine.setValue("title_field", QVariant.create("Pass some text"));

    // after setting values, is safe to load the QML
    engine.loadData(@embedFile("properties.qml"));

    QGuiApplication.exec();
}
