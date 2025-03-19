const std = @import("std");
const parse = @import("parse_arguments.zig");

pub const ValidationError = error{
    InvalidParsedCommandFormat,
};

pub fn validate_command(parsed_command: parse.ParsedCommand) ValidationError!parse.ParsedCommand {
    // Check cases for parsed command

    switch (parsed_command) {
        .help => {
            return parsed_command;
        },
        .input_filename => {
            // check if file exists and is image format
            return parsed_command;
        },
        .ComplexCommand => {
            // check if input file exists, is image, scale is valid,
            return parsed_command;
        },
    }

    return ValidationError.InvalidParsedCommandFormat;
}
