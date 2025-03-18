const std = @import("std");

pub const ParseError = error{
    CommandNotFound,
    AllocationFailure,
    InvalidSubcommand,
    DanglingSubcommand,
    InvalidScale,
};

pub const ParsedCommand = union {
    help: bool,
    input_filename: []u8,
    ComplexCommand: struct {
        input_filename: []u8,
        output_filename: []u8 = "",
        scale: u8 = 1,
    },
};

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

    // possible errors:
    // dangling subcommand: image-to-ascii file.png -o, image-to-ascii file.png -o -s 2
    // solution: if remaining arguments isnt even, must have dangling subcommand

    // Invalid Subcommand: image-to-ascii file.png -f w -o 2
    // solution: if passes all if statements, invalid

    // Duplicated subcommand: image-to-ascii file.png -o output.png -o file.png
    // solution: we could ignore and keep most recent change
    //           or have bools to track if changed before.
    //           currently: just rewriting it

    // Complex command
    var parsed_command = ParsedCommand{ .ComplexCommand = .{
        .input_filename = arguments[1],
    } };

    parsed_command.ComplexCommand.input_filename = arguments[1];

    var remaining_arguments: usize = arguments.len - 2;
    var current_subcommand: u8 = 2;

    if (remaining_arguments % 2 != 0) {
        return ParseError.DanglingSubcommand;
    }

    while (remaining_arguments != 0) {
        if (std.mem.eql(u8, "-o", arguments[current_subcommand])) {
            parsed_command.ComplexCommand.output_filename = arguments[current_subcommand + 1];

            current_subcommand += 2;
            remaining_arguments -= 2;
            continue;
        }

        if (std.mem.eql(u8, "-s", arguments[current_subcommand])) {
            parsed_command.ComplexCommand.scale = std.fmt.parseInt(u8, arguments[current_subcommand + 1], 10) catch {
                return ParseError.InvalidScale;
            };

            current_subcommand += 2;
            remaining_arguments -= 2;
            continue;
        }

        return ParseError.InvalidSubcommand;
    }

    return ParseError.CommandNotFound;
}
