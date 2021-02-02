const std = @import("std");
const Builder = std.build.Builder;
const Pkg = std.build.Pkg;
const string = []const u8;
const alloc = std.heap.page_allocator;
const fmt_description = "Run the {s} example";

const Pkgs = struct {
    const QObject: Pkg = .{
        .name = "QObject",
        .path = "src/QObject.zig",
    };
    const QMetaObject: Pkg = .{
        .name = "QMetaObject",
        .path = "src/QMetaObject.zig",
    };
    const QVariant: Pkg = .{
        .name = "QVariant",
        .path = "src/QVariant.zig",
    };
    const QQmlContext: Pkg = .{
        .name = "QQmlContext",
        .path = "src/QQmlContext.zig",
    };
    const QMetaType: Pkg = .{
        .name = "QMetaType",
        .path = "src/QMetaType.zig",
    };
    const QUrl: Pkg = .{
        .name = "QUrl",
        .path = "src/QUrl.zig",
    };
    const QQuickStyle: Pkg = .{
        .name = "QQuickStyle",
        .path = "src/QQuickStyle.zig",
    };
    const QQmlApplicationEngine: Pkg = .{
        .name = "QQmlApplicationEngine",
        .path = "src/QQmlApplicationEngine.zig",
    };
    const QGuiApplication: Pkg = .{
        .name = "QGuiApplication",
        .path = "src/QGuiApplication.zig",
    };
    const DOtherSide: Pkg = .{
        .name = "DOtherSide",
        .path = "src/DOtherSide.zig",
    };
};

pub fn build(b: *Builder) !void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    try cmakeBuild(b);

    // Original examples
    try makeExample(b, mode, target, "examples/animated.zig", "Animated", "Animated block example");
    try makeExample(b, mode, target, "examples/hello.zig", "Hello", "Hello World in Zig QML");

    // More examples
    try makeExample(b, mode, target, "examples/button.zig", "Button", "Simple Button example");

    // 3rd party QML
    try makeExample(b, mode, target, "examples/style.zig", "Style", "Use 3rd Party Material Design Style");
    try makeExample(b, mode, target, "examples/plasma.zig", "Plasma", "Use KDE Plasma Widgets");

    // Copypasta from the Go QML eamples https://github.com/go-qml/qml/tree/v1/examples
    try makeExample(b, mode, target, "examples/particle.zig", "Particle", "Particle System example (WIP)");
    try makeExample(b, mode, target, "examples/layouts.zig", "Layouts", "Layouts example");
    try makeExample(b, mode, target, "examples/splitview.zig", "Splits", "Split Panes example");
    try makeExample(b, mode, target, "examples/tableview.zig", "Tables", "Tables example");

    // Cloned simple examples from the Qml doco
    try makeExample(b, mode, target, "examples/cells.zig", "Cells", "Cells example");
}

fn makeExample(b: *Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget, src: string, name: string, descr: string) !void {
    //Example 1
    const example = b.addExecutable(name, src);
    if (mode != .Debug) {
        example.strip = true;
    }
    example.setBuildMode(mode);
    example.setTarget(target);
    example.addPackage(Pkgs.QObject);
    example.addPackage(Pkgs.QVariant);
    example.addPackage(Pkgs.QUrl);
    example.addPackage(Pkgs.QQuickStyle);
    example.addPackage(Pkgs.QMetaType);
    example.addPackage(Pkgs.QMetaObject);
    example.addPackage(Pkgs.QQmlContext);
    example.addPackage(Pkgs.QGuiApplication);
    example.addPackage(Pkgs.QQmlApplicationEngine);
    example.addPackage(Pkgs.DOtherSide);
    example.addLibPath("deps/dotherside/build/lib");
    example.linkSystemLibraryName("DOtherSide");
    example.linkLibC();
    example.install();

    const run_cmd = example.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step(name, descr);
    run_step.dependOn(&run_cmd.step);
}

fn cmakeBuild(b: *Builder) !void {
    //CMake builds - DOtherSide build
    const DOtherSide_configure = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "-B",
        "deps/dotherside/build",
        "-S",
        "deps/dotherside",
        "-DCMAKE_BUILD_TYPE=Release",
    });
    const DOtherSide_build = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--build",
        "deps/dotherside/build",
        "-j",
    });

    // Note: If it is not necessary to compile DOtherSide library, please comment on these two lines.
    try DOtherSide_configure.step.make();
    try DOtherSide_build.step.make();
}
