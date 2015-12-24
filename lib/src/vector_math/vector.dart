// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

abstract class Vector {

  /// Components as a list.
  List<double> get components;

  /// True if all components are zero.
  bool get isZero;

  // The number of components in this vector.
  int get numComponents;

  // The dimension this vector (same as [numComponents]).
  int get dimension;

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

  /// Set the components by copying them from [other].
  setFrom4(Vector4 other);

  /// Set the components by copying them from [iterable].
  setFromIterable(Iterable<double> iterable);

  /// Set [this] to its absolute value.
  makeAbsolute();

  /// Negate [this].
  negate();

  /// Normalize [this].
  normalize();

  /// Scale [this] by a scalar value.
  scale(double scalar);
}

/// Dot product of [a] and [b].
double dot2(Vector2 a, Vector2 b) {
  double sum = a._storage[0] * b._storage[0];
  sum += a._storage[1] * b._storage[1];
  return sum;
}

/// Dot product of [a] and [b].
double dot3(Vector3 a, Vector3 b) {
  double sum = a._storage[0] * b._storage[0];
  sum += a._storage[1] * b._storage[1];
  sum += a._storage[2] * b._storage[2];
  return sum;
}

/// Dot product of [a] and [b].
double dot4(Vector4 a, Vector4 b) {
  double sum = a._storage[0] * b._storage[0];
  sum += a._storage[1] * b._storage[1];
  sum += a._storage[2] * b._storage[2];
  sum += a._storage[3] * b._storage[3];
  return sum;
}

/// Cross product.
double cross2Length(Vector2 a, Vector2 b) {
  return a._storage[0] * b._storage[1] - a._storage[1] * b._storage[0];
}

/// Cross product of [a] and [b].
/// 
/// If [into] is supplied, the result will be written into it.
cross2(Vector2 a, Vector2 b, [Vector3 into]) {
  final ax = a._storage[0];
  final ay = a._storage[1];
  final bx = b._storage[0];
  final by = b._storage[1];
  Vector3 out = into != null ? into : new Vector3.zero();
  out._storage[0] = 0.0;
  out._storage[1] = 0.0;
  out._storage[2] = ax * by - ay * bx;
  return out;
}

/// Cross product of [a] and [b].
/// 
/// If [into] is supplied, the result will be written into it.
cross3(Vector3 a, Vector3 b, [Vector3 into]) {
  final ax = a._storage[0];
  final ay = a._storage[1];
  final az = a._storage[2];
  final bx = b._storage[0];
  final by = b._storage[1];
  final bz = b._storage[2];
  Vector3 out = into != null ? into : new Vector3.zero();
  out._storage[0] = ay * bz - az * by;
  out._storage[1] = az * bx - ax * bz;
  out._storage[2] = ax * by - ay * bx;
  return out;
}
