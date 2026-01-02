// Copyright (c) 2021, Instantiations, Inc. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is governed by
// a BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:ffi/ffi.dart';

// ignore: implementation_imports
import 'package:lz4_ffi/src/ffi_bindings.dart' as fb;

abstract final class Lz4FrameInfo {
  static Pointer<fb.LZ4F_frameInfo_t> allocate() {
    final frameInfo = calloc<fb.LZ4F_frameInfo_t>();
    frameInfo.ref
      ..blockSizeIDAsInt = fb.LZ4F_blockSizeID_t.LZ4F_max64KB.value
      ..blockModeAsInt = fb.LZ4F_blockMode_t.LZ4F_blockLinked.value
      ..contentChecksumFlagAsInt =
          fb.LZ4F_contentChecksum_t.LZ4F_noContentChecksum.value
      ..frameTypeAsInt = fb.LZ4F_frameType_t.LZ4F_frame.value
      ..contentSize = 0
      ..dictID = 0
      ..blockChecksumFlagAsInt =
          fb.LZ4F_blockChecksum_t.LZ4F_noBlockChecksum.value;
    return frameInfo;
  }
}

abstract final class Lz4Preferences {
  static Pointer<fb.LZ4F_preferences_t> allocate() {
    final prefs = calloc<fb.LZ4F_preferences_t>();
    prefs.ref
      ..frameInfo.blockSizeIDAsInt = fb.LZ4F_blockSizeID_t.LZ4F_default.value
      ..compressionLevel = 0
      ..autoFlush = 1
      ..favorDecSpeed = 0;
    return prefs;
  }
}

abstract final class Lz4CompressOptions {
  static Pointer<fb.LZ4F_compressOptions_t> allocate() {
    final options = calloc<fb.LZ4F_compressOptions_t>();
    options.ref.stableSrc = 0;
    return options;
  }
}

abstract final class Lz4DecompressOptions {
  static Pointer<fb.LZ4F_decompressOptions_t> allocate() {
    final options = calloc<fb.LZ4F_decompressOptions_t>();
    options.ref
      ..stableDst = 0
      ..skipChecksums = 0;
    return options;
  }
}

/// Contains refs to required types (structs...) referenced by the
/// following header files:
/// *lz4.h*
/// *lz4frame.h*
mixin Lz4Types {
  /// Return an allocated [Lz4Preferences] struct.
  Pointer<fb.LZ4F_preferences_t> newPreferences(
      {int? level = 0,
      bool? fastAcceleration,
      bool? contentChecksum,
      bool? blockChecksum,
      bool? blockLinked,
      int? blockSize,
      bool? optimizeForCompression = false}) {
    final prefs = Lz4Preferences.allocate();
    prefs.ref
      ..compressionLevel =
          (fastAcceleration ?? false) ? -(level ?? 0) : level ?? 0
      ..frameInfo.contentChecksumFlagAsInt = (contentChecksum ?? false) ? 1 : 0
      ..frameInfo.blockChecksumFlagAsInt = (blockChecksum ?? false) ? 1 : 0
      ..frameInfo.blockModeAsInt = (blockLinked ?? true)
          ? fb.LZ4F_blockMode_t.LZ4F_blockLinked.value
          : fb.LZ4F_blockMode_t.LZ4F_blockIndependent.value
      ..frameInfo.blockSizeIDAsInt =
          blockSize ?? fb.LZ4F_blockSizeID_t.LZ4F_max64KB.value
      ..favorDecSpeed = (optimizeForCompression ?? false) ? 1 : 0;
    return prefs;
  }

  /// Return an allocated [Lz4FrameInfo] struct.
  Pointer<fb.LZ4F_frameInfo_t> newFrameInfo() => Lz4FrameInfo.allocate();

  /// Return an allocated [Lz4CompressOptions] struct.
  Pointer<fb.LZ4F_compressOptions_t> newCompressOptions() =>
      Lz4CompressOptions.allocate();

  /// Return an allocated [Lz4DecompressOptions] struct.
  Pointer<fb.LZ4F_decompressOptions_t> newDecompressOptions() =>
      Lz4DecompressOptions.allocate();
}

extension BlockSizeIdExtension on fb.LZ4F_blockSizeID_t {
  int get size => switch (this) {
        fb.LZ4F_blockSizeID_t.LZ4F_default ||
        fb.LZ4F_blockSizeID_t.LZ4F_max64KB =>
          64 * 1024,
        fb.LZ4F_blockSizeID_t.LZ4F_max256KB => 256 * 1024,
        fb.LZ4F_blockSizeID_t.LZ4F_max1MB => 1 * 1024 * 1024,
        fb.LZ4F_blockSizeID_t.LZ4F_max4MB => 4 * 1024 * 1024,
      };
}
