// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// Immutable 3D column vector interface.
abstract class ImmVector4 {

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

  double get x;
  double get y;
  double get z;
  double get w;

    /// Returns absolute of [this].
  Vector4 get absolute;

  /// Returns negative of [this].
  Vector4 get negative;

  /// Returns normal of [this].
  Vector4 get normal;

  Vector4 operator -();

  Vector4 operator -(ImmVector4 other);

  Vector4 operator +(ImmVector4 other);

  /// Division by a scalar.
  Vector4 operator /(double scalar);

  /// Multiplication by a scalar.
  Vector4 operator *(double scalar);
}


/// 4D column vector.
class Vector4 implements Vector, ImmVector4 {

  static const int NUM_COMPONENTS = 4;

  final Float32List _v4storage;

  /// Construct a new vector with all components set to zero.
  Vector4.zero() : _v4storage = new Float32List(NUM_COMPONENTS);

  /// Construct a new vector from component values.
  factory Vector4(double x, double y, double z, double w) =>
      new Vector4.zero()..setComponents(x, y, z, w);

  /// Constructs a new vector with all components set to [value].
  factory Vector4.all(double value) => new Vector4.zero()..setAll(value);

  /// Constructs a new vector copying component values from [other], [z], [w] set to zero.
  factory Vector4.from2(ImmVector2 other) => new Vector4.zero()..setFrom2(other);

  /// Constructs a new vector copying component values from [other], [w] set to zero.
  factory Vector4.from3(ImmVector3 other) => new Vector4.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector4.from4(ImmVector4 other) => new Vector4.zero()..setFrom4(other);

  /// Constructs a new vector copying component values from [iterable].
  /// 
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  factory Vector4.fromIterable(Iterable<double> iterable) =>
      new Vector4.zero()..setFromIterable(iterable);

  /// View onto a [ByteBuffer].
  /// 
  /// Changes made to the vector will be visible in the byte buffer and vice versa.
  /// 
  /// The view onto the [ByteBuffer] starts at
  /// [offset] * [Float32List.BYTES_PER_ELEMENT].
  /// If [offset] is not specified, it defaults to zero.
  /// 
  /// Throws RangeError if [offset] is negative, or if
  /// ([offset] + [NUM_COMPONENTS]) * [Float32List.BYTES_PER_ELEMENT]
  /// is greater than the length of buffer.
  Vector4.view(ByteBuffer buffer, [int offset = 0]):
      _v4storage = new Float32List.view(buffer, offset * Float32List.BYTES_PER_ELEMENT, NUM_COMPONENTS);

  /// Component as a list.
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

  // The number of components in this vector.
  int get numComponents => NUM_COMPONENTS;

  // The dimension this vector (same as [numComponents]).
  int get dimension => NUM_COMPONENTS;

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

  /// Set [x] and [y] components by copying them from [other].
  ///
  /// If [z] or [w] are not provided they default to zero;
  setFrom2(ImmVector2 other, [double z = 0.0, double w = 0.0]) {
    _v4storage[0] = other.x;
    _v4storage[1] = other.y;
    _v4storage[2] = z;
    _v4storage[3] = w;
  }

  /// Set [x], [y] and [z] components by copying them from [other].
  /// 
  /// If [w] is not provided it defaults to zero;
  setFrom3(ImmVector3 other, [double w = 0.0]) {
    _v4storage[0] = other.x;
    _v4storage[1] = other.y;
    _v4storage[2] = other.z;
    _v4storage[3] = w;
  }

  /// Set the components by copying them from [other].
  setFrom4(ImmVector4 other) {
    _v4storage[0] = other.x;
    _v4storage[1] = other.y;
    _v4storage[2] = other.z;
    _v4storage[3] = other.w;
  }

  /// Set the components by copying them from [iterable].
  /// 
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  setFromIterable(Iterable<double> iterable) {
    int i=0;
    for(double d in iterable.take(NUM_COMPONENTS)) {
      _v4storage[i++] = d;
    }
  }

  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    } else {
      return (other is ImmVector4) &&
        (_v4storage[0] == other.x) &&
        (_v4storage[1] == other.y) &&
        (_v4storage[2] == other.z) &&
        (_v4storage[3] == other.w);
    }
  }

  Vector4 operator -() => new Vector4.from4(this)..negate();

  Vector4 operator -(ImmVector4 other) => new Vector4.from4(this)..subtract(other);

  Vector4 operator +(ImmVector4 other) => new Vector4.from4(this)..add(other);

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
  scale(double scalar) {
    _v4storage[0] *= scalar;
    _v4storage[1] *= scalar;
    _v4storage[2] *= scalar;
    _v4storage[3] *= scalar;
  }

  /// Add [other] to [this].
  add(ImmVector4 other) {
    _v4storage[0] += other.x;
    _v4storage[1] += other.y;
    _v4storage[2] += other.z;
    _v4storage[3] += other.w;
  }

  /// Subtract [other] from [this].
  subtract(ImmVector4 other) {
    _v4storage[0] -= other.x;
    _v4storage[1] -= other.y;
    _v4storage[2] -= other.z;
    _v4storage[3] -= other.w;
  }

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(ImmVector4 other) {
    final d = dot4(this, other);
    return Math.acos(d / Math.sqrt(lengthSquared * other.lengthSquared));
  }

  /// Distance from [this] to [other]
  double distanceTo(ImmVector4 other) => Math.sqrt(distanceToSquared(other));

  /// Squared distance from [this] to [other]
  double distanceToSquared(ImmVector4 other) {
    final dx = _v4storage[0] - other.x;
    final dy = _v4storage[1] - other.y;
    final dz = _v4storage[2] - other.z;
    final dw = _v4storage[3] - other.w;
    return dx * dx + dy * dy + dz * dz + dw * dw;
  }
}
