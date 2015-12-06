// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 2D column vector.
class Vector2 implements Vector {

  final Float32List _v2storage;
 
  /// Underlying component storage.
  Float32List get storage => _v2storage;

  /// '[*x*,*y*]'
  String toString() => '[${_v2storage[0]},${_v2storage[1]}]';

  double get x => _v2storage[0];
  double get y => _v2storage[1];
  set x(double value) => _v2storage[0] = value;
  set y(double value) => _v2storage[1] = value;

  /// True if *any* component is infinite.
  bool get isInfinite => _v2storage[0].isInfinite || _v2storage[1].isInfinite;

  /// True if *any* component is NaN.
  bool get isNaN => _v2storage[0].isNaN || _v2storage[1].isNaN;

  /// True if *all* components are zero.
  bool get isZero => _v2storage[0] == 0.0 && _v2storage[1] == 0.0;

  // The number of components in this vector (2).
  int get numComponents => 2;

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
        _v2storage[0] *= l;
        _v2storage[1] *= l;
      }
    }
  }

  /// Length squared.
  double get lengthSquared {
    double sum;
    sum = (_v2storage[0] * _v2storage[0]);
    sum += (_v2storage[1] * _v2storage[1]);
    return sum;
  }

  /// Constructs a new vector with all components set to zero.
  Vector2.zero() : _v2storage = new Float32List(2);

  /// Constructs a new vector from component values.
  factory Vector2.components(double x, double y) => new Vector2.zero()..setComponents(x, y);

  /// Constructs a new vector with all components set to [value].
  factory Vector2.all(double value) => new Vector2.zero()..setAll(value);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from2(Vector2 other) => new Vector2.zero()..setFrom2(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from3(Vector3 other) => new Vector2.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from4(Vector4 other) => new Vector2.zero()..setFrom4(other);

  /// Constructs a new vector copying component values from [iterable] starting at [offset].
  /// Length of [iterable] after [offset] must be greater than or equal to [numComponents].
  factory Vector2.fromIterable(Iterable<double> iterable, [int offset = 0]) =>
      new Vector2.zero()..setFromIterable(iterable, offset);

  /// View onto a [Float32List].
  /// Length of [list] must be greater than or equal to [numComponents].
  Vector2.view(Float32List list): _v2storage = list;

  /// Set all components to zero.
  setZero() {
    _v2storage[0] = 0.0;
    _v2storage[1] = 0.0;
  }

  /// Set the component values.
  setComponents(double x, double y) {
    _v2storage[0] = x;
    _v2storage[1] = y;
  }

  /// Set all components to [value].
  setAll(double value) {
    _v2storage[0] = value;
    _v2storage[1] = value;
  }

  /// Set the components by copying them from [other].
  setFrom2(Vector2 other) {
    final otherStorage = other._v2storage;
    _v2storage[0] = otherStorage[0];
    _v2storage[1] = otherStorage[1];
  }

  /// Set the components by copying them from [other].
  setFrom3(Vector3 other) {
    final otherStorage = other._v3storage;
    _v2storage[0] = otherStorage[0];
    _v2storage[1] = otherStorage[1];
  }

  /// Set the components by copying them from [other].
  setFrom4(Vector4 other) {
    final otherStorage = other._v4storage;
    _v2storage[0] = otherStorage[0];
    _v2storage[1] = otherStorage[1];
  }

  /// Set the components by copying them from [iterable].
  /// If [iterable] contains *n* elemnts which is less than [numComponents],
  /// only the *n* components of [this] will be set.
  void setFromIterable(Iterable<double> iterable, [int offset = 0]) {
    int i=0;
    for(double d in iterable.take(numComponents)) {
      _v2storage[i++] = d;
    }
  }

  bool operator ==(other) {
    return (other is Vector2) &&
        (_v2storage[0] == other._v2storage[0]) &&
        (_v2storage[1] == other._v2storage[1]);
  }

  Vector2 operator -() => new Vector2.from2(this)..negate();

  Vector2 operator -(Vector2 other) => new Vector2.from2(this)..subtract(other);

  Vector2 operator +(Vector2 other) => new Vector2.from2(this)..add(other);

  /// Division by a scalar.
  Vector2 operator /(double scalar) => new Vector2.from2(this)..scale(1.0 / scalar);

  /// Multiplication by a scalar.
  Vector2 operator *(double scalar) => new Vector2.from2(this)..scale(scalar);

  double operator [](int i) => _v2storage[i];

  void operator []=(int i, double v) {
    _v2storage[i] = v;
  }

  /// Negate [this]
  negate() {
    _v2storage[0] = -_v2storage[0];
    _v2storage[1] = -_v2storage[1];
  }

  /// Set [this] to its absolute value.
  makeAbsolute() {
    _v2storage[0] = _v2storage[0].abs();
    _v2storage[1] = _v2storage[1].abs();
  }

  /// Ceil components.
  ceilComponents() {
    _v2storage[0] = _v2storage[0].ceilToDouble();
    _v2storage[1] = _v2storage[1].ceilToDouble();
  }

  /// Floor components.
  floorComponents() {
    _v2storage[0] = _v2storage[0].floorToDouble();
    _v2storage[1] = _v2storage[1].floorToDouble();
  }

  /// Round components.
  roundComponents() {
    _v2storage[0] = _v2storage[0].roundToDouble();
    _v2storage[1] = _v2storage[1].roundToDouble();
  }

  /// Truncate components.
  truncateComponents() {
    _v2storage[0] = _v2storage[0].truncateToDouble();
    _v2storage[1] = _v2storage[1].truncateToDouble();
  }

  /// Clamp [this[n]] into the range [min[n]] → [max[*n*]].
  /// [min[n]] must be less than or equal to [max[*n*]].
  clamp(Vector2 lowerLimits, Vector2 upperLimits) {
    var lowerStorage = lowerLimits.storage;
    var upperStorage = upperLimits.storage;
    _v2storage[0] = _v2storage[0].clamp(lowerStorage[0], upperStorage[0]);
    _v2storage[1] = _v2storage[1].clamp(lowerStorage[1], upperStorage[1]);
  }

  /// Clamp each component into the range [lowerLimit] → [upperLimit].
  /// [lowerLimit] must be less than or equal to [upperLimit].
  clampScalar(double lowerLimit, double upperLimit) {
    _v2storage[0] = _v2storage[0].clamp(lowerLimit, upperLimit);
    _v2storage[1] = _v2storage[1].clamp(lowerLimit, upperLimit);
  }

  /// Normalize [this].
  normalize() {
    double l = length;
    if (l != 0.0) {
      l = 1.0 / l;
      _v2storage[0] *= l;
      _v2storage[1] *= l;
    }
  }

  /// Scale [this] by a scalar value.
  scale(double scalar) {
    _v2storage[1] = _v2storage[1] * scalar;
    _v2storage[0] = _v2storage[0] * scalar;
  }

  /// Add [other] to [this].
  add(Vector2 other) {
    final otherStorage = other._v2storage;
    _v2storage[0] = _v2storage[0] + otherStorage[0];
    _v2storage[1] = _v2storage[1] + otherStorage[1];
  }

  /// Subtract [other] from [this].
  subtract(Vector2 other) {
    final otherStorage = other._v2storage;
    _v2storage[0] = _v2storage[0] - otherStorage[0];
    _v2storage[1] = _v2storage[1] - otherStorage[1];
  }

  /// Multiply [this] by [other] component-wise.
  multiply(Vector2 other) {
    final otherStorage = other._v2storage;
    _v2storage[0] = _v2storage[0] * otherStorage[0];
    _v2storage[1] = _v2storage[1] * otherStorage[1];
  }

  /// Divide [this] by [other] component-wise.
  divide(Vector2 other) {
    final otherStorage = other._v2storage;
    _v2storage[0] = _v2storage[0] / otherStorage[0];
    _v2storage[1] = _v2storage[1] / otherStorage[1];
  }

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector2 other) {
    final d = dot(other);
    return Math.acos(d / Math.sqrt(lengthSquared * other.lengthSquared));
  }

  /// Length of cross product of [this] and [other].
  /// (Cross product of two 2D vectors is a 3D vector parallel with z axis.)
  double cross2Length(Vector2 other) {
    return _v2storage[0] * other._v2storage[1] - _v2storage[1] * other._v2storage[0];
  }

  /// Distance from [this] to [other]
  double distanceTo(Vector2 other) => Math.sqrt(distanceToSquared(other));

  /// Squared distance from [this] to [other]
  double distanceToSquared(Vector2 other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return dx * dx + dy * dy;
  }

  /// Dot product of [this] and [other].
  double dot(Vector2 other) {
    final otherStorage = other._v2storage;
    double sum = _v2storage[0] * otherStorage[0];
    sum += _v2storage[1] * otherStorage[1];
    return sum;
  }
}