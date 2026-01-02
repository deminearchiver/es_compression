// Copyright (c) 2021, Instantiations, Inc. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is governed by
// a BSD-style license that can be found in the LICENSE file.

// ignore: implementation_imports
import 'package:lz4_ffi/src/ffi_bindings.dart' as fb;

import '../../lz4.dart';

/// Exposes Lz4 options for input parameters.
abstract class Lz4Option {
  /// Default value for [Lz4Codec.level] and [Lz4Encoder.level].
  static const int defaultLevel = 0;

  /// Minimal value for [Lz4Codec.level] and [Lz4Encoder.level].
  static const int minLevel = -1;

  /// Maximal value for [Lz4Codec.level] and [Lz4Encoder.level].
  static const int maxLevel = 16;

  /// Default max block size for [Lz4Codec.blockSize] and
  /// [Lz4Encoder.blockSize].
  static final int defaultBlockSize = fb.LZ4F_blockSizeID_t.LZ4F_default.value;

  /// 64KB max block size for [Lz4Codec.blockSize] and [Lz4Encoder.blockSize].
  static final int blockSize64KB = fb.LZ4F_blockSizeID_t.LZ4F_max64KB.value;

  /// 256KB max block size for [Lz4Codec.blockSize] and [Lz4Encoder.blockSize].
  static final int blockSize256KB = fb.LZ4F_blockSizeID_t.LZ4F_max256KB.value;

  /// 1MB max block size for [Lz4Codec.blockSize] and [Lz4Encoder.blockSize].
  static final int blockSize1MB = fb.LZ4F_blockSizeID_t.LZ4F_max1MB.value;

  /// 4MB max block size for [Lz4Codec.blockSize] and [Lz4Encoder.blockSize].
  static final int blockSize4MB = fb.LZ4F_blockSizeID_t.LZ4F_max4MB.value;
}
