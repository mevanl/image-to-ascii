const std = @import("std");
const parse = @import("parse_arguments.zig");

pub fn main() !void {
    var buffer: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const parsed_command = parse.parse_arguments(allocator) catch |err| {
        switch (err) {
            parse.ParseError.AllocationFailure => {
                std.debug.print("Could not allocate arguments.\n", .{});
            },
            parse.ParseError.CommandNotFound => {
                std.debug.print("Command not found. See 'image-to-ascii help' for info.\n", .{});
            },
            parse.ParseError.InvalidSubcommand => {
                std.debug.print("Subcommand is not valid.\n", .{});
            },
            parse.ParseError.DanglingSubcommand => {
                std.debug.print("Dangling subcommand. Subcommand entered without user input attached.\n", .{});
            },
            parse.ParseError.InvalidScale => {
                std.debug.print("Invalid Scale. Please enter a valid integer in scale.\n", .{});
            },
        }

        return;
    };

    _ = parsed_command;
}
