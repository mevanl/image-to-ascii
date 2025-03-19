const std = @import("std");
const parse = @import("parse_arguments.zig");

const help = @import("execution/help.zig");

pub const ExecutionError = error{};

pub fn execute_command(parsed_command: parse.ParsedCommand) ExecutionError!void {
    switch (parsed_command) {
        .help => {
            help.help();
        },
        .input_filename => {
            // check if file exists and is image format
            return;
        },
        .ComplexCommand => {
            // check if input file exists, is image, scale is valid,
            return;
        },
    }
}
