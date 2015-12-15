// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 2D column vector.
class Vector2 implements Vector {

  static const int NUM_COMPONENTS = 2;

  final Float32List _v2storage;
 
  /// Constructs a new vector with all components set to zero.
  Vector2.zero() : _v2storage = new Float32List(2);

  /// Constructs a new vector from component values.
  factory Vector2(double x, double y) => new Vector2.zero()..setComponents(x, y);

  /// Constructs a new vector with all components set to [value].
  factory Vector2.all(double value) => new Vector2.zero()..setAll(value);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from2(Vector2 other) => new Vector2.zero()..setFrom2(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from3(Vector3 other) => new Vector2.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from4(Vector4 other) => new Vector2.zero()..setFrom4(other);

  /// Constructs a new vector copying component values from [iterable].
  /// 
  /// If [iterable] contains *n* elemnts which is less than [NUM_COMPONENTS],
  /// only the *n* components of [this] will be set.
  factory Vector2.fromIterable(Iterable<double> iterable) =>
      new Vector2.zero()..setFromIterable(iterable);

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
  Vector2.view(ByteBuffer buffer, [int offset = 0]):
      _v2storage = new Float32List.view(buffer, offset * Float32List.BYTES_PER_ELEMENT, NUM_COMPONENTS);

  /// Components as a list: [x, y].
  List<double> get components => _v2storage;

  String toString() => '[${_v2storage[0]},${_v2storage[1]}]';

  double get x => _v2storage[0];
  double get y => _v2storage[1];

  set x(double value) { _v2storage[0] = value; }
  set y(double value) { _v2storage[1] = value; }

  /// True if all components are zero.
  bool get isZero => _v2storage[0] == 0.0 && _v2storage[1] == 0.0;

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

  /// Returns absolute of [this].
  Vector2 get absolute => new Vector2.from2(this)..makeAbsolute();

  /// Returns negative of [this].
  Vector2 get negative => new Vector2.from2(this)..negate();

  /// Returns normal of [this].
  Vector2 get normal => new Vector2.from2(this)..normalize();

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
  /// 
  /// If [iterable] contains *n* elemnts which is less than [NUM_COMPONENTS],
  /// only the *n* components of [this] will be set.
  setFromIterable(Iterable<double> iterable) {
    int i=0;
    for(double d in iterable.take(NUM_COMPONENTS)) {
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

  /// Set [this] to its absolute value.
  makeAbsolute() {
    _v2storage[0] = _v2storage[0].abs();
    _v2storage[1] = _v2storage[1].abs();
  }

  /// Negate [this].
  negate() {
    _v2storage[0] = -_v2storage[0];
    _v2storage[1] = -_v2storage[1];
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

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector2 other) {
    final d = dot2(this, other);
    return Math.acos(d / Math.sqrt(lengthSquared * other.lengthSquared));
  }

  /// Distance from [this] to [other]
  double distanceTo(Vector2 other) => Math.sqrt(distanceToSquared(other));

  /// Squared distance from [this] to [other]
  double distanceToSquared(Vector2 other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return dx * dx + dy * dy;
  }
}
