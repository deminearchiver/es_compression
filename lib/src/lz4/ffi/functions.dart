// Copyright (c) 2021, Instantiations, Inc. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is governed by
// a BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';

import 'package:ffi/ffi.dart';

// ignore: implementation_imports
import 'package:lz4_ffi/src/ffi_bindings.dart' as fb;

mixin Lz4Functions {
  int lz4VersionNumber() => fb.LZ4_versionNumber();

  int lz4FIsError(int code) => fb.LZ4F_isError(code);

  Pointer<Utf8> lz4FGetErrorName(int code) => fb.LZ4F_getErrorName(code).cast();

  int lz4FCreateCompressionContext(
          Pointer<Pointer<fb.LZ4F_cctx>> cctxPtr, int version) =>
      fb.LZ4F_createCompressionContext(cctxPtr, version);

  int lz4FFreeCompressionContext(Pointer<fb.LZ4F_cctx> cctx) =>
      fb.LZ4F_freeCompressionContext(cctx);

  int lz4FCompressBegin(Pointer<fb.LZ4F_cctx> cctx, Pointer<Uint8> dstBuffer,
          int dstCapacity, Pointer<fb.LZ4F_preferences_t> prefsPtr) =>
      fb.LZ4F_compressBegin(cctx, dstBuffer.cast(), dstCapacity, prefsPtr);

  int lz4FCompressBound(int srcSize, Pointer<fb.LZ4F_preferences_t> prefsPtr) =>
      fb.LZ4F_compressBound(srcSize, prefsPtr);

  int lz4FCompressFrame(
          Pointer<Uint8> dstBuffer,
          int dstCapacity,
          Pointer<Uint8> srcBuffer,
          int srcSize,
          Pointer<fb.LZ4F_preferences_t> preferencesPtr) =>
      fb.LZ4F_compressFrame(dstBuffer.cast(), dstCapacity, srcBuffer.cast(),
          srcSize, preferencesPtr);

  int lz4FCompressFrameBound(
          int srcSize, Pointer<fb.LZ4F_preferences_t> preferencesPtr) =>
      fb.LZ4F_compressFrameBound(srcSize, preferencesPtr);

  int lz4FCompressUpdate(
          Pointer<fb.LZ4F_cctx> cctx,
          Pointer<Uint8> dstBuffer,
          int dstCapacity,
          Pointer<Uint8> srcBuffer,
          int srcSize,
          Pointer<fb.LZ4F_compressOptions_t> cOptPtr) =>
      fb.LZ4F_compressUpdate(cctx, dstBuffer.cast(), dstCapacity,
          srcBuffer.cast(), srcSize, cOptPtr);

  int lz4FCompressEnd(Pointer<fb.LZ4F_cctx> cctx, Pointer<Uint8> dstBuffer,
          int dstCapacity, Pointer<fb.LZ4F_compressOptions_t> cOptPtr) =>
      fb.LZ4F_compressEnd(cctx, dstBuffer.cast(), dstCapacity, cOptPtr);

  int lz4FFlush(Pointer<fb.LZ4F_cctx> cctx, Pointer<Uint8> dstBuffer,
          int dstCapacity, Pointer<fb.LZ4F_compressOptions_t> cOptPtr) =>
      fb.LZ4F_flush(cctx, dstBuffer.cast(), dstCapacity, cOptPtr);

  int lz4FCreateDecompressionContext(
          Pointer<Pointer<fb.LZ4F_dctx>> dctxPtr, int version) =>
      fb.LZ4F_createDecompressionContext(dctxPtr, version);

  int lz4FFreeDecompressionContext(Pointer<fb.LZ4F_dctx> dctx) =>
      fb.LZ4F_freeDecompressionContext(dctx);

  int lz4FGetFrameInfo(
          Pointer<fb.LZ4F_dctx> dctx,
          Pointer<fb.LZ4F_frameInfo_t> frameInfoPtr,
          Pointer<Uint8> srcBuffer,
          Pointer<IntPtr> srcSizePtr) =>
      fb.LZ4F_getFrameInfo(
          dctx, frameInfoPtr, srcBuffer.cast(), srcSizePtr.cast());

  void lz4FResetDecompressionContext(Pointer<fb.LZ4F_dctx> dctx) =>
      fb.LZ4F_resetDecompressionContext(dctx);

  int lz4FDecompress(
          Pointer<fb.LZ4F_dctx> dctx,
          Pointer<Uint8> dstBuffer,
          Pointer<IntPtr> dstSizePtr,
          Pointer<Uint8> srcBuffer,
          Pointer<IntPtr> srcSizePtr,
          Pointer<fb.LZ4F_decompressOptions_t> dOptPtr) =>
      fb.LZ4F_decompress(dctx, dstBuffer.cast(), dstSizePtr.cast(),
          srcBuffer.cast(), srcSizePtr.cast(), dOptPtr);
}
