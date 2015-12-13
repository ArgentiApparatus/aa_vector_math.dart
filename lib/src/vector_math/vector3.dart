// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 3D column vector.
class Vector3 implements Vector {

  final Float32List _v3storage;

  /// Constructs a new vector with all components set to zero.
  Vector3.zero() : _v3storage = new Float32List(3);

  /// Constructs a new vector from component values.
  factory Vector3(double x, double y, double z) =>
      new Vector3.zero()..setComponents(x, y, z);

  /// Constructs a new vector with all components set to [value].
  factory Vector3.all(double value) => new Vector3.zero()..setAll(value);

  /// Constructs a new vector copying component values from [other], [z] set to zero.
  factory Vector3.from2(Vector2 other) => new Vector3.zero()..setFrom2(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector3.from3(Vector3 other) => new Vector3.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector3.from4(Vector4 other) => new Vector3.zero()..setFrom4(other);

  /// Constructs a new vector copying component values from [iterable].
  /// 
  /// If [iterable] contains *n* elemnts which is less than [numComponents],
  /// only the *n* components of [this] will be set.
  factory Vector3.fromIterable(Iterable<double> iterable) =>
      new Vector3.zero()..setFromIterable(iterable);

  /// View onto a [Float32List].
  /// 
  /// Length of [list] must be greater than or equal to [numComponents].
  Vector3.view(Float32List list): _v3storage = list;

  String toString() => '[${_v3storage[0]},${_v3storage[1]},${_v3storage[2]}]';

  /// Components as a list: [x, y, z].
  List<double> get components => _v3storage;

  double get x => _v3storage[0];
  double get y => _v3storage[1];
  double get z => _v3storage[2];
  double get r => _v3storage[0];
  double get g => _v3storage[1];
  double get b => _v3storage[2];

  set x(double value) { _v3storage[0] = value; }
  set y(double value) { _v3storage[1] = value; }
  set z(double value) { _v3storage[2] = value; }
  set r(double value) { _v3storage[0] = value; }
  set g(double value) { _v3storage[1] = value; }
  set b(double value) { _v3storage[2] = value; }

  /// True if *all* components are zero.
  bool get isZero => _v3storage[0] == 0.0 && _v3storage[1] == 0.0 && _v3storage[2] == 0.0;

  // The number of components in this vector (3).
  int get numComponents => 3;

  /// Length.
  double get length => Math.sqrt(lengthSquared);

  /// Set the length of the vector.
  /// 
  /// A negative [value] will reverse the vector's orientation and a [value] of
  /// zero will set the vector to zero.
  /// 
  /// If the length of the vector is already zero, invoking this method has no effect. 
  set length(double value) {
    if (value == 0.0) {
      setZero();
    } else {
      double l = length;
      if (l != 0.0) {
        l = value / l;
        _v3storage[0] *= l;
        _v3storage[1] *= l;
        _v3storage[2] *= l;
      }
    }
  }

  /// Length squared.
  double get lengthSquared {
    double sum;
    sum = (_v3storage[0] * _v3storage[0]);
    sum += (_v3storage[1] * _v3storage[1]);
    sum += (_v3storage[2] * _v3storage[2]);
    return sum;
  }

  /// Returns absolute of [this].
  Vector3 get absolute => new Vector3.from3(this)..makeAbsolute();

  /// Returns negtive of [this].
  Vector3 get negative => new Vector3.from3(this)..negate();

  /// Returns normal of [this].
  Vector3 get normal => new Vector3.from3(this)..normalize();

  /// Set all components to zero.
  setZero() {
    _v3storage[0] = 0.0;
    _v3storage[1] = 0.0;
    _v3storage[2] = 0.0;
  }

  /// Set the component values.
  setComponents(double x, double y, double z) {
    _v3storage[0] = x;
    _v3storage[1] = y;
    _v3storage[2] = z;
  }

  /// Set all components to [value].
  setAll(double value) {
    _v3storage[0] = value;
    _v3storage[1] = value;
    _v3storage[2] = value;
  }

  /// Set [x] and [y] components by copying them from [other], set [z] to zero;
  setFrom2(Vector2 other) {
    final otherStorage = other._v2storage;
    _v3storage[0] = otherStorage[0];
    _v3storage[1] = otherStorage[1];
    _v3storage[2] = 0.0;
  }

  /// Set the components by copying them from [other].
  setFrom3(Vector3 other) {
    final otherStorage = other._v3storage;
    _v3storage[0] = otherStorage[0];
    _v3storage[1] = otherStorage[1];
    _v3storage[2] = otherStorage[2];
  }

  /// Set the components by copying them from [other].
  setFrom4(Vector4 other) {
    final otherStorage = other._v4storage;
    _v3storage[0] = otherStorage[0];
    _v3storage[1] = otherStorage[1];
    _v3storage[2] = otherStorage[2];
  }

  /// Set the components by copying them from [iterable].
  /// 
  /// If [iterable] contains *n* elemnts which is less than [numComponents],
  /// only the *n* components of [this] will be set.
  setFromIterable(Iterable<double> iterable, [int offset = 0]) {
    int i=0;
    for(double d in iterable.take(numComponents)) {
      _v3storage[i++] = d;
    }
  }

  bool operator ==(other) {
    return (other is Vector3) &&
        (_v3storage[0] == other._v3storage[0]) &&
        (_v3storage[1] == other._v3storage[1]) &&
        (_v3storage[2] == other._v3storage[2]);
  }

  Vector3 operator -() => new Vector3.from3(this)..negate();

  Vector3 operator -(Vector3 other) => new Vector3.from3(this)..subtract(other);

  Vector3 operator +(Vector3 other) => new Vector3.from3(this)..add(other);

  /// Division by a scalar.
  Vector3 operator /(double scalar) => new Vector3.from3(this)..scale(1.0 / scalar);

  /// Multiplication by a scalar.
  Vector3 operator *(double scalar) => new Vector3.from3(this)..scale(scalar);

  /// Set [this] to its absolute value.
  makeAbsolute() {
    _v3storage[0] = _v3storage[0].abs();
    _v3storage[1] = _v3storage[1].abs();
    _v3storage[2] = _v3storage[2].abs();
  }

  /// Negate [this].
  negate() {
    _v3storage[0] = -_v3storage[0];
    _v3storage[1] = -_v3storage[1];
    _v3storage[2] = -_v3storage[2];
  }

  /// Normalize [this].
  normalize() {
    double l = length;
    if (l != 0.0) {
      l = 1.0 / l;
      _v3storage[0] *= l;
      _v3storage[1] *= l;
      _v3storage[2] *= l;
    }
  }

  /// Scale [this] by a scalar value.
  scale(double scalar) {
    _v3storage[0] = _v3storage[0] * scalar;
    _v3storage[1] = _v3storage[1] * scalar;
    _v3storage[2] = _v3storage[2] * scalar;
  }

  /// Add [other] to [this].
  add(Vector3 other) {
    final argStorage = other._v3storage;
    _v3storage[0] = _v3storage[0] + argStorage[0];
    _v3storage[1] = _v3storage[1] + argStorage[1];
    _v3storage[2] = _v3storage[2] + argStorage[2];
  }

  /// Subtract [other] from [this].
  subtract(Vector3 other) {
    final argStorage = other._v3storage;
    _v3storage[0] = _v3storage[0] - argStorage[0];
    _v3storage[1] = _v3storage[1] - argStorage[1];
    _v3storage[2] = _v3storage[2] - argStorage[2];
  }

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector3 other) {
    final d = dot3(this, other);
    return Math.acos(d / Math.sqrt(lengthSquared * other.lengthSquared));
  }

  /// Distance from [this] to [other]
  double distanceTo(Vector3 other) => Math.sqrt(distanceToSquared(other));

  /// Squared distance from [this] to [other]
  double distanceToSquared(Vector3 other) {
    final otherStorage = other._v3storage;
    final dx = _v3storage[0] - otherStorage[0];
    final dy = _v3storage[1] - otherStorage[1];
    final dz = _v3storage[2] - otherStorage[2];
    return dx * dx + dy * dy + dz * dz;
  }
}
