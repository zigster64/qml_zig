const dos = @import("DOtherSide.zig");

pub const QQuickStyle = struct {
    pub fn addStylePath(self: QQuickStyle, path: [*c]const u8) void {
        dos.dos_qquickstyle_add_style_path(style);
    }

    pub fn availableStyles(self: QQuickStyle) [][]const u8 {
        return dos.dos_qquickstyle_available_styles(style);
    }

    pub fn name(self: QQuickStyle) []const u8 {
        return dos.dos_qquickstyle_name();
    }

    pub fn path(self: QQuickStyle) []const u8 {
        return dos.dos_qquickstyle_path();
    }

    pub fn setFallbackStyle(self: QQuickStyle, style: [*c]const u8) void {
        dos.dos_qquickstyle_set_fallback_style(style);
    }

    pub fn setStyle(self: QQuickStyle, style: [*c]const u8) void {
        dos.dos_qquickstyle_set_style(style);
    }

    pub fn stylePathList(self: QQuickStyle) [][]const u8 {
        return dos.dos_qquickstyle_style_path_list(style);
    }
};
