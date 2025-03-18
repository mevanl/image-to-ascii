const std = @import("std");

const ParseError = error{
    CommandNotFound,
    AllocationFailure,
    InvalidSubcommand,
};

const ParsedCommand = union {
    help: bool,
    input_filename: []u8,
    ComplexCommand: struct {
        input_filename: []u8,
        output_filename: []u8,
        scale: u8 = 1,
        color: bool = false,
    },
};

// maybe instead of void we return an enum/some object
// that can capture valid command info and execute on it.
pub fn parse_arguments(allocator: std.mem.Allocator) ParseError!ParsedCommand {
    const arguments = std.process.argsAlloc(allocator) catch |err| {
        std.debug.print("{}", .{err});
        return ParseError.AllocationFailure;
    };
    defer std.process.argsFree(allocator, arguments);

    // No arguments/help case
    if (arguments.len == 1 or std.mem.eql(u8, "help", arguments[1])) {
        if (arguments.len > 2) return ParseError.InvalidSubcommand;

        const parsed_command = ParsedCommand{ .help = true };
        return parsed_command;
    }

    // Base case, no subcommands
    if (arguments.len == 2) {
        // note: we will not be checking if this is a valid file,
        //       we only are only parsing it for now.

        const parsed_command = ParsedCommand{ .input_filename = arguments[1] };
        return parsed_command;
    }
}
