// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 3D column vector.
class Vector3 implements Vector {

  final Float32List _v3storage;

  /// '[*x*,*y*,*z*]'
  String toString() => '[${storage[0]},${storage[1]},${storage[2]}]';

  /// Underlying component storage.
  Float32List get storage => _v3storage;

  double get x => _v3storage[0];
  double get y => _v3storage[1];
  double get z => _v3storage[2];
  double get r => _v3storage[0];
  double get g => _v3storage[1];
  double get b => _v3storage[2];
  set x(double value) => _v3storage[0] = value;
  set y(double value) => _v3storage[1] = value;
  set z(double value) => _v3storage[2] = value;
  set r(double value) => _v3storage[0] = value;
  set g(double value) => _v3storage[1] = value;
  set b(double value) => _v3storage[2] = value;

  /// True if *any* component is infinite.
  bool get isInfinite => _v3storage[0].isInfinite || _v3storage[1].isInfinite || _v3storage[2].isInfinite;

  /// True if *any* component is NaN.
  bool get isNaN => _v3storage[0].isNaN || _v3storage[1].isNaN || _v3storage[2].isNaN;

  /// True if *all* components are zero.
  bool get isZero => _v3storage[0] == 0.0 && _v3storage[1] == 0.0 && _v3storage[2] == 0.0;

  // The number of components in this vector (3).
  int get numComponents => 3;

  /// Length.
  double get length => Math.sqrt(lengthSquared);

  /// Set the length of the vector. A negative [value] will reverse the vector's
  /// orientation and a [value] of zero will set the vector to zero.
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

  /// Constructs a new vector with all components set to zero.
  Vector3.zero() : _v3storage = new Float32List(3);

  /// Constructs a new vector from component values.
  factory Vector3.components(double x, double y, double z) =>
      new Vector3.zero()..setComponents(x, y, z);

  /// Constructs a new vector with all components to [value].
  factory Vector3.all(double value) => new Vector3.zero()..setAll(value);

  /// Constructs a new vector copying [x] and [y] component values from [other], [z] set to zero.
  factory Vector3.from2(Vector2 other) => new Vector3.zero()..setFrom2(other)..z=0.0;

  /// Constructs a new vector copying component values from [other].
  factory Vector3.from3(Vector3 other) => new Vector3.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector3.from4(Vector4 other) => new Vector3.zero()..setFrom4(other);

  /// Constructs a new vector copying component values from [list] starting at [offset].
  /// Length of [list] after [offset] must be greater than or equal to [numComponents].
  factory Vector3.fromList(List<double> list, [int offset = 0]) =>
      new Vector3.zero()..setFromList(list, offset);

  /// Constructs a new vector which is the cross product of [a] and [b].
  factory Vector3.crossProduct3(Vector3 a, Vector3 b) =>
      new Vector3.zero()..takeCrossProduct3(a, b);

  /// Constructs a new vector which is the cross product of [a] and [b].
  factory Vector3.crossProduct2(Vector2 a, Vector2 b)
      => new Vector3.zero()..takeCrossProduct2(a, b);

  /// View onto a [Float32List].
  /// Length of [list] must be greater than or equal to [numComponents].
  Vector3.view(Float32List list): _v3storage = list;

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

  /// Set [x] and [y] components by copying them from [other].
  setFrom2(Vector2 other) {
    final otherStorage = other._v2storage;
    _v3storage[0] = otherStorage[0];
    _v3storage[1] = otherStorage[1];
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

  /// Set the components by copying them from [list] starting at [offset].
  /// Length of [list] after [offset] must be greater than or equal to [numComponents].
  void setFromList(List<double> list, [int offset = 0]) {
    _v3storage[0] = list[offset];
    _v3storage[1] = list[offset + 1];
    _v3storage[2] = list[offset + 2];
  }

  /// Set [this] to cross product of [a] and [b].
  takeCrossProduct3(Vector3 a, Vector3 b) {
    final ax = a._v3storage[0];
    final ay = a._v3storage[1];
    final az = a._v3storage[2];
    final bx = b._v3storage[0];
    final by = b._v3storage[1];
    final bz = b._v3storage[2];
    _v3storage[0] = ay * bz - az * by;
    _v3storage[1] = az * bx - ax * bz;
    _v3storage[2] = ax * by - ay * bx;
  }

  /// Set [this] to cross product of [a] and [b].
  takeCrossProduct2(Vector2 a, Vector2 b) {
    final ax = a._v2storage[0];
    final ay = a._v2storage[1];
    final bx = b._v2storage[0];
    final by = b._v2storage[1];
    _v3storage[0] = 0.0;
    _v3storage[1] = 0.0;
    _v3storage[2] = ax * by - ay * bx;
  }

  /// Copies values of components into [list] starting at [offset].
  /// Length of [list] after [offset] must be greater than or equal to [numComponents].
  void copyIntoList(List<double> list, [int offset = 0]) {
    list[offset] = _v3storage[0];
    list[offset + 1] = _v3storage[1];
    list[offset + 2] = _v3storage[2];
  }

  /// Angle between [this] and [other] in radians.
  double angleTo(Vector3 other) {
    final otherStorage = other._v3storage;
    if (_v3storage[0] == otherStorage[0] &&
        _v3storage[1] == otherStorage[1] &&
        _v3storage[2] == otherStorage[2]) {
      return 0.0;
    }
    final d = dotProduct(other);
    return Math.acos(d.clamp(-1.0, 1.0));
  }

  /// Returns the signed angle between [this] and [other] around [normal]
  /// in radians.
  double angleToAround(Vector3 other, Vector3 normal) {
    final angle = angleTo(other);
    final c = new Vector3.crossProduct3(this, other);
    final d = c.dotProduct(normal);
    return d < 0.0 ? -angle : angle;
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

  /// Dot product of [this] and [other].
  double dotProduct(Vector3 other) {
    final otherStorage = other._v3storage;
    double sum = _v3storage[0] * otherStorage[0];
    sum += _v3storage[1] * otherStorage[1];
    sum += _v3storage[2] * otherStorage[2];
    return sum;
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

  double operator [](int i) => _v3storage[i];

  void operator []=(int i, double v) {
    _v3storage[i] = v;
  }

  /// Negate [this].
  void negate() {
    _v3storage[0] = -_v3storage[0];
    _v3storage[1] = -_v3storage[1];
    _v3storage[2] = -_v3storage[2];
  }

  /// Set [this] to its absolute value.
  makeAbsolute() {
    _v3storage[0] = _v3storage[0].abs();
    _v3storage[1] = _v3storage[1].abs();
    _v3storage[2] = _v3storage[2].abs();
  }

  /// Floor components.
  floorComponents() {
    _v3storage[0] = _v3storage[0].floorToDouble();
    _v3storage[1] = _v3storage[1].floorToDouble();
    _v3storage[2] = _v3storage[2].floorToDouble();
  }

  /// Ceil components.
  ceilComponents() {
    _v3storage[0] = _v3storage[0].ceilToDouble();
    _v3storage[1] = _v3storage[1].ceilToDouble();
    _v3storage[2] = _v3storage[2].ceilToDouble();

  }

  /// Round components.
  roundComponents() {
    _v3storage[0] = _v3storage[0].roundToDouble();
    _v3storage[1] = _v3storage[1].roundToDouble();
    _v3storage[2] = _v3storage[2].roundToDouble();
  }

  /// Truncate components.
  truncateComponents() {
    _v3storage[0] = _v3storage[0].truncateToDouble();
    _v3storage[1] = _v3storage[1].truncateToDouble();
    _v3storage[2] = _v3storage[2].truncateToDouble();
  }

  /// Clamp [this[n]] into the range [lowerLimits[n]] → [upperLimits[*n*]].
  /// [lowerLimits[n]] must be less than or equal to [upperLimits[*n*]].
  clamp(Vector3 lowerLimits, Vector3 upperLimits) {
    var lowerStorage = lowerLimits.storage;
    var upperStorage = upperLimits.storage;
    _v3storage[0] = _v3storage[0].clamp(lowerStorage[0], upperStorage[0]);
    _v3storage[1] = _v3storage[1].clamp(lowerStorage[1], upperStorage[1]);
    _v3storage[2] = _v3storage[2].clamp(lowerStorage[2], upperStorage[2]);
  }

  /// Clamp each component into the range [lowerLimit] → [upperLimit].
  /// [lowerLimit] must be less than or equal to [upperLimit].
  clampScalar(double lowerLimit, double upperLimit) {
    _v3storage[0] = _v3storage[0].clamp(lowerLimit, upperLimit);
    _v3storage[1] = _v3storage[1].clamp(lowerLimit, upperLimit);
    _v3storage[2] = _v3storage[2].clamp(lowerLimit, upperLimit);
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

  /// Multiply [this] by [other] component-wise.
  multiply(Vector3 other) {
    final argStorage = other._v3storage;
    _v3storage[0] = _v3storage[0] * argStorage[0];
    _v3storage[1] = _v3storage[1] * argStorage[1];
    _v3storage[2] = _v3storage[2] * argStorage[2];
  }

  /// Divide [this] by [other] component-wise.
  divide(Vector3 other) {
    final argStorage = other._v3storage;
    _v3storage[0] = _v3storage[0] / argStorage[0];
    _v3storage[1] = _v3storage[1] / argStorage[1];
    _v3storage[2] = _v3storage[2] / argStorage[2];
  }

}
