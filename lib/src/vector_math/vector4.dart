// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 4D column vector.
class Vector4 implements Vector {
  final Float32List _v4storage;

  /// Underlying component storage.
  Float32List get storage => _v4storage;

  /// '[*x*,*y*,*z*,*w*]'
  String toString() => '[${_v4storage[0]},${_v4storage[1]},'
      '${_v4storage[2]},${_v4storage[3]}]';

  double get x => _v4storage[0];
  double get y => _v4storage[1];
  double get z => _v4storage[2];
  double get w => _v4storage[3];
  double get r => _v4storage[0];
  double get g => _v4storage[1];
  double get b => _v4storage[2];
  double get a => _v4storage[4];
  set x(double value) => _v4storage[0] = value;
  set y(double value) => _v4storage[1] = value;
  set z(double value) => _v4storage[2] = value;
  set w(double value) => _v4storage[3] = value;
  set r(double value) => _v4storage[0] = value;
  set g(double value) => _v4storage[1] = value;
  set b(double value) => _v4storage[2] = value;
  set a(double value) => _v4storage[3] = value;

  /// True if *any* component is infinite.
  bool get isInfinite => _v4storage[0].isInfinite || _v4storage[1].isInfinite || _v4storage[2].isInfinite || _v4storage[3].isInfinite;

  /// True if *any* component is NaN.
  bool get isNaN => _v4storage[0].isNaN || _v4storage[1].isNaN || _v4storage[2].isNaN || _v4storage[3].isNaN;

  /// True if *all* components are zero.
  bool get isZero => _v4storage[0] == 0.0 && _v4storage[1] == 0.0 && _v4storage[2] == 0.0 && _v4storage[3] == 0.0;

  // The number of components in this vector (4).
  int get numComponents => 4;

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
        _v4storage[0] *= l;
        _v4storage[1] *= l;
        _v4storage[2] *= l;
        _v4storage[3] *= l;
      }
    }
  }

  /// Length squared.
  double get lengthSquared {
    double sum;
    sum = (_v4storage[0] * _v4storage[0]);
    sum += (_v4storage[1] * _v4storage[1]);
    sum += (_v4storage[2] * _v4storage[2]);
    sum += (_v4storage[3] * _v4storage[3]);
    return sum;
  }

  /// Construct a new vector with all components set to zero.
  Vector4.zero() : _v4storage = new Float32List(4);

  /// Construct a new vector from component values.
  factory Vector4.components(double x, double y, double z, double w) =>
      new Vector4.zero()..setComponents(x, y, z, w);

  /// Constructs a new vector with all components set to [value].
  factory Vector4.all(double value) => new Vector4.zero()..setAll(value);

  /// Constructs a new vector copying [x] and [y] component values from [other], [z], [w] set to zero.
  factory Vector4.from2(Vector2 other) => new Vector4.zero()..setFrom2(other)..z=0.0..w=0.0;

  /// Constructs a new vector copying [x] and [y] component values from [other], [w] set to zero.
  factory Vector4.from3(Vector3 other) => new Vector4.zero()..setFrom3(other)..w=0.0;

  /// Constructs a new vector copying component values from [other].
  factory Vector4.from4(Vector4 other) => new Vector4.zero()..setFrom4(other);

  /// Constructs a new vector copying component values from [iterable] starting at [offset].
  /// Length of [iterable] after [offset] must be greater than or equal to [numComponents].
  factory Vector4.fromIterable(Iterable<double> iterable, [int offset = 0]) =>
      new Vector4.zero()..setFromIterable(iterable, offset);

  /// View onto a [Float32List].
  /// Length of [list] must be greater than or equal to [numComponents].
   Vector4.view(Float32List list): _v4storage = list;

  /// Set all components to zero.
  setZero() {
    _v4storage[0] = 0.0;
    _v4storage[1] = 0.0;
    _v4storage[2] = 0.0;
    _v4storage[3] = 0.0;
  }

  /// Set the component values.
  setComponents(double x, double y, double z, double w) {
    _v4storage[0] = x;
    _v4storage[1] = y;
    _v4storage[2] = z;
    _v4storage[3] = w;
  }

  /// Set all components to [value].
  setAll(double value) {
    _v4storage[0] = value;
    _v4storage[1] = value;
    _v4storage[2] = value;
    _v4storage[3] = value;
  }

  /// Set [x] and [y] components by copying them from [other].
  setFrom2(Vector2 other) {
    final otherStorage = other._v2storage;
    _v4storage[0] = otherStorage[0];
    _v4storage[1] = otherStorage[1];
  }

  /// Set [x], [y] and [z] components by copying them from [other].
  setFrom3(Vector3 other) {
    final otherStorage = other._v3storage;
    _v4storage[0] = otherStorage[0];
    _v4storage[1] = otherStorage[1];
    _v4storage[2] = otherStorage[2];
  }

  /// Set the components by copying them from [other].
  setFrom4(Vector4 other) {
    final otherStorage = other._v4storage;
    _v4storage[0] = otherStorage[0];
    _v4storage[1] = otherStorage[1];
    _v4storage[2] = otherStorage[2];
    _v4storage[3] = otherStorage[3];
  }

  /// Set the components by copying them from [iterable].
  /// If [iterable] contains *n* elemnts which is less than [numComponents],
  /// only the *n* components of [this] will be set.
  void setFromIterable(Iterable<double> iterable, [int offset = 0]) {
    int i=0;
    for(double d in iterable.take(numComponents)) {
      _v4storage[i++] = d;
    }
  }

  bool operator ==(other) {
    return (other is Vector4) &&
        (_v4storage[0] == other._v4storage[0]) &&
        (_v4storage[1] == other._v4storage[1]) &&
        (_v4storage[2] == other._v4storage[2]) &&
        (_v4storage[3] == other._v4storage[3]);
  }

  Vector4 operator -() => new Vector4.from4(this)..negate();

  Vector4 operator -(Vector4 other) => new Vector4.from4(this)..subtract(other);

  Vector4 operator +(Vector4 other) => new Vector4.from4(this)..add(other);

  /// Division by a scalar.
  Vector4 operator /(double scalar) => new Vector4.from4(this)..scale(1.0 / scalar);

  /// Multiplication by a scalar.
  Vector4 operator *(double scalar) => new Vector4.from4(this)..scale(scalar);

  double operator [](int i) => _v4storage[i];

  void operator []=(int i, double v) {
    _v4storage[i] = v;
  }

 /// Negate [this].
  void negate() {
    _v4storage[0] = -_v4storage[0];
    _v4storage[1] = -_v4storage[1];
    _v4storage[2] = -_v4storage[2];
    _v4storage[3] = -_v4storage[3];
  }

  /// Set [this] to its absolute value.
  makeAbsolute() {
    _v4storage[0] = _v4storage[0].abs();
    _v4storage[1] = _v4storage[1].abs();
    _v4storage[2] = _v4storage[2].abs();
    _v4storage[3] = _v4storage[3].abs();
  }

  /// Floor components.
  floorComponents() {
    _v4storage[0] = _v4storage[0].floorToDouble();
    _v4storage[1] = _v4storage[1].floorToDouble();
    _v4storage[2] = _v4storage[2].floorToDouble();
    _v4storage[3] = _v4storage[3].floorToDouble();
  }

  /// Ceil components.
  ceilComponents() {
    _v4storage[0] = _v4storage[0].ceilToDouble();
    _v4storage[1] = _v4storage[1].ceilToDouble();
    _v4storage[2] = _v4storage[2].ceilToDouble();
    _v4storage[3] = _v4storage[3].ceilToDouble();
  }

  /// Round components.
  roundComponents() {
    _v4storage[0] = _v4storage[0].roundToDouble();
    _v4storage[1] = _v4storage[1].roundToDouble();
    _v4storage[2] = _v4storage[2].roundToDouble();
    _v4storage[3] = _v4storage[3].roundToDouble();
  }

  /// Truncate components.
  truncateComponents() {
    _v4storage[0] = _v4storage[0].truncateToDouble();
    _v4storage[1] = _v4storage[1].truncateToDouble();
    _v4storage[2] = _v4storage[2].truncateToDouble();
    _v4storage[3] = _v4storage[3].truncateToDouble();
  }

  /// Clamp [this[n]] into the range [lowerLimits[n]] → [upperLimits[*n*]].
  /// [lowerLimits[n]] must be less than or equal to [upperLimits[*n*]].
  clamp(Vector4 lowerLimits, Vector4 upperLimits) {
    var lowerStorage = lowerLimits.storage;
    var upperStorage = upperLimits.storage;
    _v4storage[0] = _v4storage[0].clamp(lowerStorage[0], upperStorage[0]);
    _v4storage[1] = _v4storage[1].clamp(lowerStorage[1], upperStorage[1]);
    _v4storage[2] = _v4storage[2].clamp(lowerStorage[2], upperStorage[2]);
    _v4storage[3] = _v4storage[3].clamp(lowerStorage[3], upperStorage[3]);
  }

  /// Clamp each component into the range [lowerLimit] → [upperLimit].
  /// [lowerLimit] must be less than or equal to [upperLimit].
  clampScalar(double lowerLimit, double upperLimit) {
    _v4storage[0] = _v4storage[0].clamp(lowerLimit, upperLimit);
    _v4storage[1] = _v4storage[1].clamp(lowerLimit, upperLimit);
    _v4storage[2] = _v4storage[2].clamp(lowerLimit, upperLimit);
    _v4storage[3] = _v4storage[3].clamp(lowerLimit, upperLimit);
  }

  /// Normalize [this].
  normalize() {
    double l = length;
    if (l != 0.0) {
      l = 1.0 / l;
      _v4storage[0] *= l;
      _v4storage[1] *= l;
      _v4storage[2] *= l;
      _v4storage[3] *= l;
    }
  }

  /// Scale [this] by a scaler value.
  scale(double scaler) {
    _v4storage[0] = _v4storage[0] * scaler;
    _v4storage[1] = _v4storage[1] * scaler;
    _v4storage[2] = _v4storage[2] * scaler;
    _v4storage[3] = _v4storage[3] * scaler;
  }

  add(Vector4 other) {
    final otherStorage = other._v4storage;
    _v4storage[0] = _v4storage[0] + otherStorage[0];
    _v4storage[1] = _v4storage[1] + otherStorage[1];
    _v4storage[2] = _v4storage[2] + otherStorage[2];
    _v4storage[3] = _v4storage[3] + otherStorage[3];
  }

  /// Subtract [other] from [this].
  subtract(Vector4 other) {
    final otherStorage = other._v4storage;
    _v4storage[0] = _v4storage[0] - otherStorage[0];
    _v4storage[1] = _v4storage[1] - otherStorage[1];
    _v4storage[2] = _v4storage[2] - otherStorage[2];
    _v4storage[3] = _v4storage[3] - otherStorage[3];
  }

  /// Multiply [this] by [other] component-wise.
  multiply(Vector4 other) {final otherStorage = other._v4storage;
    _v4storage[0] = _v4storage[0] * otherStorage[0];
    _v4storage[1] = _v4storage[1] * otherStorage[1];
    _v4storage[2] = _v4storage[2] * otherStorage[2];
    _v4storage[3] = _v4storage[3] * otherStorage[3];
  }

  /// Divide [this] by [other] component-wise.
  divide(Vector4 other) {
    final otherStorage = other._v4storage;
    _v4storage[0] = _v4storage[0] / otherStorage[0];
    _v4storage[1] = _v4storage[1] / otherStorage[1];
    _v4storage[2] = _v4storage[2] / otherStorage[2];
    _v4storage[3] = _v4storage[3] / otherStorage[3];
  }

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector4 other) {
    final d = dot(other);
    return Math.acos(d / Math.sqrt(lengthSquared * other.lengthSquared));
  }

  /// Distance from [this] to [other]
  double distanceTo(Vector4 other) => Math.sqrt(distanceToSquared(other));

  /// Squared distance from [this] to [other]
  double distanceToSquared(Vector4 other) {
    final otherStorage = other._v4storage;
    final dx = _v4storage[0] - otherStorage[0];
    final dy = _v4storage[1] - otherStorage[1];
    final dz = _v4storage[2] - otherStorage[2];
    final dw = _v4storage[3] - otherStorage[3];

    return dx * dx + dy * dy + dz * dz + dw * dw;
  }

  /// Dot product of [this] and [other].
  double dot(Vector4 other) {
    final otherStorage = other._v4storage;
    double sum = _v4storage[0] * otherStorage[0];
    sum += _v4storage[1] * otherStorage[1];
    sum += _v4storage[2] * otherStorage[2];
    sum += _v4storage[3] * otherStorage[3];
    return sum;
  }
}
