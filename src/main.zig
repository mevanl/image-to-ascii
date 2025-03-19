const std = @import("std");
const parse = @import("parse_arguments.zig");
const validate = @import("validate_command.zig");

pub fn main() !void {
    var buffer: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    // Parse command line input
    var parsed_command = parse.parse_arguments(allocator) catch |err| {
        switch (err) {
            parse.ParseError.AllocationFailure => {
                std.debug.print("Could not allocate arguments.\n", .{});
            },
            parse.ParseError.CommandNotFound => {
                std.debug.print("Command not found. See 'image-to-ascii help' for info.\n", .{});
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

    // Validate parsed command
    parsed_command = validate.validate_command(allocator, parsed_command) catch |err| {
        switch (err) {
            validate.ValidationError.InvalidParsedCommandFormat => {
                std.debug.print("Parsed command is not in valid format.\n", .{});
            },
        }
        return;
    };

    // Execute validated parsed command
    return;
}
