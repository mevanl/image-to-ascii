const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Setup stb_image as library
    const stb_image_library = b.addStaticLibrary(.{
        .name = "stb_image",
        .target = target,
        .optimize = optimize,
    });

    stb_image_library.addCSourceFile(.{ .file = b.path("src/lib/stb_wrapper.c") });
    stb_image_library.linkLibC();
    stb_image_library.installHeader(b.path("src/lib/stb_image.h"), "src/lib/stb_image.h");
    b.installArtifact(stb_image_library);

    // define our executable
    const exe = b.addExecutable(.{
        .name = "image-to-ascii",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibrary(stb_image_library);

    b.installArtifact(exe);
}
