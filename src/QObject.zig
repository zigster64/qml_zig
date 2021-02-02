const std = @import("std");
usingnamespace @import("./DOtherSide.zig");

pub const QConnectionType = enum(c_int) {
    Auto = 0,
    Direct = 1,
    Queued = 2,
    BlockingQueued = 3,
    Unique = 0x80,
};

pub fn QObject(comptime T: type) type {
    const typeInfo: std.builtin.TypeInfo = @typeInfo(T);
    const str: std.builtin.TypeInfo.Struct = typeInfo.Struct;

    return struct {
        pub const parentType = T;
        const Self = @This();
        const name: []const u8 = @typeName(T);

        pub fn create() type {
            for (str.fields) |field| {
                std.debug.print("name: {}\n", .{field.name});
            }
            return Self{};
        }
    };
}
