const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "image-to-ascii",
        .root_source_file = b.path("src/main.zig"),
        .target = b.graph.host,
    });
    exe.linkLibC();
    exe.addCSourceFiles(&[_][]const u8{"src/lib/stb_wrapper.c"}, &[_][]const u8{ "-g", "-O3" });

    b.installArtifact(exe);
}
