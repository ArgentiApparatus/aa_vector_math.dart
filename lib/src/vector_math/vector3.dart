// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 3D column vector.
class Vector3 implements Vector {

  static const int NUM_COMPONENTS = 3;

  final Float32List _storage;

  /// Constructs a new vector with all components set to zero.
  Vector3.zero() : _storage = new Float32List(NUM_COMPONENTS);

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
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  factory Vector3.fromIterable(Iterable<double> iterable) =>
      new Vector3.zero()..setFromIterable(iterable);

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
  Vector3.view(ByteBuffer buffer, [int offset = 0]):
      _storage = new Float32List.view(buffer, offset * Float32List.BYTES_PER_ELEMENT, NUM_COMPONENTS);

  String toString() => '[${_storage[0]},${_storage[1]},${_storage[2]}]';

  /// Components as a list: [x, y, z].
  List<double> get components => _storage;

  double get x => _storage[0];
  double get y => _storage[1];
  double get z => _storage[2];
  double get r => _storage[0];
  double get g => _storage[1];
  double get b => _storage[2];

  set x(double value) { _storage[0] = value; }
  set y(double value) { _storage[1] = value; }
  set z(double value) { _storage[2] = value; }
  set r(double value) { _storage[0] = value; }
  set g(double value) { _storage[1] = value; }
  set b(double value) { _storage[2] = value; }

  /// True if *all* components are zero.
  bool get isZero => _storage[0] == 0.0 && _storage[1] == 0.0 && _storage[2] == 0.0;

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
        _storage[0] *= l;
        _storage[1] *= l;
        _storage[2] *= l;
      }
    }
  }

  /// Length squared.
  double get lengthSquared {
    double sum;
    sum = (_storage[0] * _storage[0]);
    sum += (_storage[1] * _storage[1]);
    sum += (_storage[2] * _storage[2]);
    return sum;
  }

  /// Returns absolute of [this].
  Vector3 get absolute => new Vector3.from3(this)..makeAbsolute();

  /// Returns negative of [this].
  Vector3 get negative => new Vector3.from3(this)..negate();

  /// Returns normal of [this].
  Vector3 get normal => new Vector3.from3(this)..normalize();

  /// Set all components to zero.
  setZero() {
    _storage[0] = 0.0;
    _storage[1] = 0.0;
    _storage[2] = 0.0;
  }

  /// Set the component values.
  setComponents(double x, double y, double z) {
    _storage[0] = x;
    _storage[1] = y;
    _storage[2] = z;
  }

  /// Set all components to [value].
  setAll(double value) {
    _storage[0] = value;
    _storage[1] = value;
    _storage[2] = value;
  }

  /// Set [x] and [y] components by copying them from [other].
  /// 
  /// If [z] is not provided it defaults to zero;
  setFrom2(Vector2 other, [double z = 0.0]) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = z;
  }

  /// Set the components by copying them from [other].
  setFrom3(Vector3 other) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = otherStorage[2];
  }

  /// Set the components by copying them from [other].
  setFrom4(Vector4 other) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = otherStorage[2];
  }

  /// Set the components by copying them from [iterable].
  /// 
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  setFromIterable(Iterable<double> iterable, [int offset = 0]) {
    int i=0;
    for(double d in iterable.take(NUM_COMPONENTS)) {
      _storage[i++] = d;
    }
  }

  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    } else {
      return
        (other is Vector3) &&
        (_storage[0] == other._storage[0]) &&
        (_storage[1] == other._storage[1]) &&
        (_storage[2] == other._storage[2]);
    }
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
    _storage[0] = _storage[0].abs();
    _storage[1] = _storage[1].abs();
    _storage[2] = _storage[2].abs();
  }

  /// Negate [this].
  negate() {
    _storage[0] = -_storage[0];
    _storage[1] = -_storage[1];
    _storage[2] = -_storage[2];
  }

  /// Normalize [this].
  normalize() {
    double l = length;
    if (l != 0.0) {
      l = 1.0 / l;
      _storage[0] *= l;
      _storage[1] *= l;
      _storage[2] *= l;
    }
  }

  /// Scale [this] by a scalar value.
  scale(double scalar) {
    _storage[0] *= scalar;
    _storage[1] *= scalar;
    _storage[2] *= scalar;
  }

  /// Add [other] to [this].
  add(Vector3 other) {
    final otherStorage = other._storage;
    _storage[0] += otherStorage[0];
    _storage[1] += otherStorage[1];
    _storage[2] += otherStorage[2];
  }

  /// Subtract [other] from [this].
  subtract(Vector3 other) {
    final otherStorage = other._storage;
    _storage[0] -= otherStorage[0];
    _storage[1] -= otherStorage[1];
    _storage[2] -= otherStorage[2];
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
    final otherStorage = other._storage;
    final dx = _storage[0] - otherStorage[0];
    final dy = _storage[1] - otherStorage[1];
    final dz = _storage[2] - otherStorage[2];
    return dx * dx + dy * dy + dz * dz;
  }
}
