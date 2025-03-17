const std = @import("std");

const ParseError = error{
    CommandNotFound,
    FileNotFound,
    AllocationFailure,
    InvalidSubcommand,
};

const ParsedCommand = union {
    input_filename: []u8,
    ComplexCommand: struct {
        input_filename: []u8,
        output_filename: []u8,
        scale: u8,
        color: bool,
    },
};

// maybe instead of void we return an enum/some object
// that can capture valid command info and execute on it.
pub fn parse_arguments(allocator: std.mem.Allocator) ParseError!void {
    const arguments = std.process.argsAlloc(allocator) catch |err| {
        std.debug.print("{}", .{err});
        return ParseError.AllocationFailure;
    };
    defer std.process.argsFree(allocator, arguments);

    if (arguments.len == 1 or std.mem.eql(u8, "help", arguments[1])) {
        // check if there are more arguments are this
        if (arguments.len > 2) return ParseError.InvalidSubcommand;

        std.debug.print("HELP\n", .{});
        //instead of commands.help(); mayybe we return a command obj to execute on?
        return;
    }
}
