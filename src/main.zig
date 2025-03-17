const std = @import("std");
const parse = @import("parse_arguments.zig");

pub fn main() anyerror!void {
    var buffer: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    try parse.parse_arguments(allocator);

    // // get our commandline args
    // const cmdline_args = try std.process.argsAlloc(allocator);
    // defer std.process.argsFree(allocator, cmdline_args);

    // // Process cmdline args
    // if (cmdline_args.len == 1) {
    //     std.debug.print("image-to-ascii\n", .{});
    //     return;
    // }
}
