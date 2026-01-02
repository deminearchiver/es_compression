// Copyright (c) 2021, Instantiations, Inc. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is governed by
// a BSD-style license that can be found in the LICENSE file.

import 'functions.dart';
import 'types.dart';

/// An [Lz4Library] is the gateway to the native Lz4 shared library.
///
/// It has a series of mixins for making available constants, types and
/// functions that are described in C header files.
class Lz4Library with Lz4Functions, Lz4Types {
  /// Singleton instance.
  static final Lz4Library _instance = Lz4Library._();

  /// Return the [Lz4Library] singleton library instance.
  factory Lz4Library() => _instance;

  Lz4Library._();
}
