const std = @import("std");

pub fn help() void {
    const help_message =
        \\
        \\ Usage
        \\ -----
        \\ image-to-ascii help
        \\      This prints out this message.
        \\ image-to-ascii "image file" [-o output file name] [-s scale]
        \\      Converts an image to ascii. Optional output filename and scale commands.
        \\
        \\
    ;

    std.debug.print("{s}", .{help_message});
}
