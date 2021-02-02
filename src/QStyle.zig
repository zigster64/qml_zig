const dos = @import("DOtherSide.zig");

pub const QStyle = struct {
    pub fn set(self: QStyle, style: [*c]const u8) void {
        dos.dos_qquickstyle_set_style(style);
    }
};
