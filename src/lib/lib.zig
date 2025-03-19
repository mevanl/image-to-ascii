const std = @import("std");

pub fn check_file_exists(filename: []u8) bool {
    const file = std.fs.cwd().openFile(filename, .{}) catch {
        return false;
    };
    defer file.close();

    return true;
}
