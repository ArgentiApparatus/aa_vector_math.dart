// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

/// 4D column vector.
class Vector4 implements Vector {

  static const int NUM_COMPONENTS = 4;

  final Float32List _storage;

  /// Construct a new vector with all components set to zero.
  Vector4.zero() : _storage = new Float32List(NUM_COMPONENTS);

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
      _storage = new Float32List.view(buffer, offset * Float32List.BYTES_PER_ELEMENT, NUM_COMPONENTS);

  /// Component as a list: [x, y, z, w].
  List<double> get components => _storage;

  String toString() => '[${_storage[0]},${_storage[1]},${_storage[2]},${_storage[3]}]';

  double get x => _storage[0];
  double get y => _storage[1];
  double get z => _storage[2];
  double get w => _storage[3];
  double get r => _storage[0];
  double get g => _storage[1];
  double get b => _storage[2];
  double get a => _storage[3];

  set x(double value) { _storage[0] = value; }
  set y(double value) { _storage[1] = value; }
  set z(double value) { _storage[2] = value; }
  set w(double value) { _storage[3] = value; }
  set r(double value) { _storage[0] = value; }
  set g(double value) { _storage[1] = value; }
  set b(double value) { _storage[2] = value; }
  set a(double value) { _storage[3] = value; }

  /// True if *all* components are zero.
  bool get isZero => _storage[0] == 0.0 && _storage[1] == 0.0 && _storage[2] == 0.0 && _storage[3] == 0.0;

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
        _storage[3] *= l;
      }
    }
  }

  /// Length squared.
  double get lengthSquared {
    double sum;
    sum = (_storage[0] * _storage[0]);
    sum += (_storage[1] * _storage[1]);
    sum += (_storage[2] * _storage[2]);
    sum += (_storage[3] * _storage[3]);
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
    _storage[0] = 0.0;
    _storage[1] = 0.0;
    _storage[2] = 0.0;
    _storage[3] = 0.0;
  }

  /// Set the component values.
  setComponents(double x, double y, double z, double w) {
    _storage[0] = x;
    _storage[1] = y;
    _storage[2] = z;
    _storage[3] = w;
  }

  /// Set all components to [value].
  setAll(double value) {
    _storage[0] = value;
    _storage[1] = value;
    _storage[2] = value;
    _storage[3] = value;
  }

  /// Set [x] and [y] components by copying them from [other].
  ///
  /// If [z] or [w] are not provided they default to zero;
  setFrom2(Vector2 other, [double z = 0.0, double w = 0.0]) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = z;
    _storage[3] = w;
  }

  /// Set [x], [y] and [z] components by copying them from [other].
  /// 
  /// If [w] is not provided it defaults to zero;
  setFrom3(Vector3 other, [double w = 0.0]) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = otherStorage[2];
    _storage[3] = w;
  }

  /// Set the components by copying them from [other].
  setFrom4(Vector4 other) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = otherStorage[2];
    _storage[3] = otherStorage[3];
  }

  /// Set the components by copying them from [iterable].
  /// 
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  setFromIterable(Iterable<double> iterable) {
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
        (other is Vector4) &&
        (_storage[0] == other._storage[0]) &&
        (_storage[1] == other._storage[1]) &&
        (_storage[2] == other._storage[2]) &&
        (_storage[4] == other._storage[4]);
    }
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
    _storage[0] = _storage[0].abs();
    _storage[1] = _storage[1].abs();
    _storage[2] = _storage[2].abs();
    _storage[3] = _storage[3].abs();
  }

  /// Negate [this].
  negate() {
    _storage[0] = -_storage[0];
    _storage[1] = -_storage[1];
    _storage[2] = -_storage[2];
    _storage[3] = -_storage[3];
  }

  /// Normalize [this].
  normalize() {
    double l = length;
    if (l != 0.0) {
      l = 1.0 / l;
      _storage[0] *= l;
      _storage[1] *= l;
      _storage[2] *= l;
      _storage[3] *= l;
    }
  }

  /// Scale [this] by a scalar value.
  scale(double scalar) {
    _storage[0] *= scalar;
    _storage[1] *= scalar;
    _storage[2] *= scalar;
    _storage[3] *= scalar;
  }

  /// Add [other] to [this].
  add(Vector4 other) {
    final otherStorage = other._storage;
    _storage[0] += otherStorage[0];
    _storage[1] += otherStorage[1];
    _storage[2] += otherStorage[2];
    _storage[3] += otherStorage[3];
  }

  /// Subtract [other] from [this].
  subtract(Vector4 other) {
    final otherStorage = other._storage;
    _storage[0] -= otherStorage[0];
    _storage[1] -= otherStorage[1];
    _storage[2] -= otherStorage[2];
    _storage[3] -= otherStorage[3];
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
    final otherStorage = other._storage;
    final dx = _storage[0] - otherStorage[0];
    final dy = _storage[1] - otherStorage[1];
    final dz = _storage[2] - otherStorage[2];
    final dw = _storage[3] - otherStorage[3];
    return dx * dx + dy * dy + dz * dz + dw * dw;
  }
}
