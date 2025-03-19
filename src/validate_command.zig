const std = @import("std");
const parse = @import("parse_arguments.zig");

pub const ValidationError = error{
    InvalidParsedCommandFormat,
};

pub fn validate_command(allocator: std.mem.Allocator, parsed_command: parse.ParsedCommand) ValidationError!parse.ParsedCommand {
    // Check cases for parsed command
    _ = allocator;

    switch (parsed_command) {
        .help => {
            return parsed_command;
        },
        .input_filename => {
            return parsed_command;
        },
        .ComplexCommand => {
            return parsed_command;
        },
    }

    return ValidationError.InvalidParsedCommandFormat;
}
