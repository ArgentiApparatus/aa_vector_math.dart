// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 4D column vector.
class Vector4 implements Vector {

  final Float32List _v4storage;

  /// Construct a new vector with all components set to zero.
  Vector4.zero() : _v4storage = new Float32List(4);

  /// Construct a new vector from component values.
  factory Vector4(double x, double y, double z, double w) =>
      new Vector4.zero()..setComponents(x, y, z, w);

  /// Constructs a new vector with all components set to [value].
  factory Vector4.all(double value) => new Vector4.zero()..setAll(value);

  /// Constructs a new vector copying component values from [other], [z], [w] set to zero.
  factory Vector4.from2(Vector2 other) => new Vector4.zero()..setFrom2(other);

  /// Constructs a new vector copying component values from [other], [w] set to zero.
  factory Vector4.from3(Vector3 other) => new Vector4.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector4.from4(Vector4 other) => new Vector4.zero()..setFrom4(other);

  /// Constructs a new vector copying component values from [iterable].
  /// 
  /// If [iterable] contains *n* elemnts which is less than [numComponents],
  /// only the *n* components of [this] will be set.
  factory Vector4.fromIterable(Iterable<double> iterable) =>
      new Vector4.zero()..setFromIterable(iterable);

  /// View onto a [Float32List].
  /// 
  /// Length of [list] must be greater than or equal to [numComponents].
   Vector4.view(Float32List list): _v4storage = list;

  /// Component as a list: [x, y, z, w].
  List<double> get components => _v4storage;

  String toString() => '[${_v4storage[0]},${_v4storage[1]},${_v4storage[2]},${_v4storage[3]}]';

  double get x => _v4storage[0];
  double get y => _v4storage[1];
  double get z => _v4storage[2];
  double get w => _v4storage[3];
  double get r => _v4storage[0];
  double get g => _v4storage[1];
  double get b => _v4storage[2];
  double get a => _v4storage[3];

  set x(double value) { _v4storage[0] = value; }
  set y(double value) { _v4storage[1] = value; }
  set z(double value) { _v4storage[2] = value; }
  set w(double value) { _v4storage[3] = value; }
  set r(double value) { _v4storage[0] = value; }
  set g(double value) { _v4storage[1] = value; }
  set b(double value) { _v4storage[2] = value; }
  set a(double value) { _v4storage[3] = value; }

  /// True if *all* components are zero.
  bool get isZero => _v4storage[0] == 0.0 && _v4storage[1] == 0.0 && _v4storage[2] == 0.0 && _v4storage[3] == 0.0;

  // The number of components in this vector (4).
  int get numComponents => 4;

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

  /// Returns absolute of [this].
  Vector4 get absolute => new Vector4.from4(this)..makeAbsolute();

  /// Returns negative of [this].
  Vector4 get negative => new Vector4.from4(this)..negate();

  /// Returns normal of [this].
  Vector4 get normal => new Vector4.from4(this)..normalize();

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

  /// Set [x] and [y] components by copying them from [other], set [z] and [w] to zero;
  setFrom2(Vector2 other) {
    final otherStorage = other._v2storage;
    _v4storage[0] = otherStorage[0];
    _v4storage[1] = otherStorage[1];
    _v4storage[2] = 0.0;
    _v4storage[3] = 0.0;
  }

  /// Set [x], [y] and [z] components by copying them from [other], set [w] to zero;.
  setFrom3(Vector3 other) {
    final otherStorage = other._v3storage;
    _v4storage[0] = otherStorage[0];
    _v4storage[1] = otherStorage[1];
    _v4storage[2] = otherStorage[2];
    _v4storage[3] = 0.0;
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
  /// 
  /// If [iterable] contains *n* elemnts which is less than [numComponents],
  /// only the *n* components of [this] will be set.
  setFromIterable(Iterable<double> iterable) {
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

  /// Set [this] to its absolute value.
  makeAbsolute() {
    _v4storage[0] = _v4storage[0].abs();
    _v4storage[1] = _v4storage[1].abs();
    _v4storage[2] = _v4storage[2].abs();
    _v4storage[3] = _v4storage[3].abs();
  }

  /// Negate [this].
  negate() {
    _v4storage[0] = -_v4storage[0];
    _v4storage[1] = -_v4storage[1];
    _v4storage[2] = -_v4storage[2];
    _v4storage[3] = -_v4storage[3];
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

  /// Scale [this] by a scalar value.
  scale(double scaler) {
    _v4storage[0] = _v4storage[0] * scaler;
    _v4storage[1] = _v4storage[1] * scaler;
    _v4storage[2] = _v4storage[2] * scaler;
    _v4storage[3] = _v4storage[3] * scaler;
  }

  /// Add [other] to [this].
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

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector4 other) {
    final d = dot4(this, other);
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
}
