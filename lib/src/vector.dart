// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vectors;

abstract class Vector {

  /// Components as a [List].
  List<double> asList();

  /// Components as a [Float64List].
  Float64List asFloat64List();

  /// True if all components are zero.
  bool get isZero;

  // The number of components in this vector.
  int get numComponents;

  /// Length.
  double get length;

  /// Set the length of the vector.
  set length(double value);

  /// Length squared.
  double get lengthSquared;

  /// Set all components to zero.
  setZero();

  /// Set all components to [value].
  setAll(double value);

  /// Set the components by copying them from [other].
  setFrom2(Vector2 other);

  /// Set the components by copying them from [other].
  setFrom3(Vector3 other);

  /// Set the components by copying them from [iterable].
  setFromIterable(Iterable<double> iterable);

  /// Set [this] to its absolute value.
  absolutize();

  /// Negate [this].
  negate();

  /// Normalize [this].
  normalize();

  /// Scale [this] by a scalar value.
  scale(double scalar);
}
