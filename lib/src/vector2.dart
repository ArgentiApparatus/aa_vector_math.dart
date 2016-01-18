// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vectors;

/// 2D column vector.
class Vector2 implements Vector {

  // Number of components.
  static const int NUM_COMPONENTS = 2;

  // Component storage.
  final Float64List _storage;
 
  /// Constructs a new vector with all components set to zero.
  Vector2.zero() : _storage = new Float64List(NUM_COMPONENTS);

  /// Constructs a new vector from component values.
  factory Vector2(double x, double y) => new Vector2.zero()..setComponents(x, y);

  /// Constructs a new vector with all components set to [value].
  factory Vector2.all(double value) => new Vector2.zero()..setAll(value);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from2(Vector2 other) => new Vector2.zero()..setFrom2(other);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from3(Vector3 other) => new Vector2.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [iterable].
  /// 
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  factory Vector2.fromIterable(Iterable<double> iterable) =>
      new Vector2.zero()..setFromIterable(iterable);

  /// View onto a [ByteBuffer].
  /// 
  /// Changes made to the vector will be visible in the byte buffer and vice versa.
  /// 
  /// The view onto the [ByteBuffer] starts at
  /// [offset] * [Float64List.BYTES_PER_ELEMENT].
  /// If [offset] is not specified, it defaults to zero.
  /// 
  /// Throws RangeError if [offset] is negative, or if
  /// ([offset] + [NUM_COMPONENTS]) * [Float64List.BYTES_PER_ELEMENT]
  /// is greater than the length of buffer.
  Vector2.view(ByteBuffer buffer, [int offset = 0]):
      _storage = new Float64List.view(buffer, offset * Float64List.BYTES_PER_ELEMENT, NUM_COMPONENTS);

  /// Set all components to zero.
  setZero() {
    _storage[0] = 0.0;
    _storage[1] = 0.0;
  }

  /// Set the component values.
  setComponents(double x, double y) {
    _storage[0] = x;
    _storage[1] = y;
  }

  /// Set all components to [value].
  setAll(double value) {
    _storage[0] = value;
    _storage[1] = value;
  }

  /// Set [x] and [y] components by copying them from [other].
  setFrom2(Vector2 other) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
  }

  /// Set the components by copying them from [other].
  setFrom3(Vector3 other) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
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

  String toString() => '[${_storage[0]},${_storage[1]}]';

  /// Components as a list: [x, y].
  List<double> get components => _storage;

  double get x => _storage[0];
  double get y => _storage[1];

  set x(double value) { _storage[0] = value; }
  set y(double value) { _storage[1] = value; }

  /// True if all components are zero.
  bool get isZero => _storage[0] == 0.0 && _storage[1] == 0.0;

  // The number of components in this vector.
  int get numComponents => NUM_COMPONENTS;

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
      }
    }
  }

  /// Length squared.
  double get lengthSquared {
    double sum;
    sum = (_storage[0] * _storage[0]);
    sum += (_storage[1] * _storage[1]);
    return sum;
  }

  /// Set [this] to its absolute value.
  absolutize() {
    _storage[0] = _storage[0].abs();
    _storage[1] = _storage[1].abs();
  }

  /// Negate [this].
  negate() {
    _storage[0] = -_storage[0];
    _storage[1] = -_storage[1];
  }

  /// Normalize [this].
  normalize() {
    double l = length;
    if (l != 0.0) {
      l = 1.0 / l;
      _storage[0] *= l;
      _storage[1] *= l;
    }
  }

  /// Add [other] to [this].
  add(Vector2 other) {
    final otherStorage = other._storage;
    _storage[0] += otherStorage[0];
    _storage[1] += otherStorage[1];
  }

  /// Subtract [other] from [this].
  subtract(Vector2 other) {
    final otherStorage = other._storage;
    _storage[0] -= otherStorage[0];
    _storage[1] -= otherStorage[1];
  }

  /// Scale [this] by a scalar value.
  scale(double scalar) {
    _storage[0] *= scalar;
    _storage[1] *= scalar;
  }
  
  /// Set [this] to absolute value of [other].
  setAbsoluteOf(Vector2 other) {
    this..setFrom2(other)..absolutize();
  }

  /// Set [this] to negative value of [other].
  setNegativeOf(Vector2 other) {
    this..setFrom2(other)..negate();
  }

  /// Set [this] to normal value of [other].
  setNormalOf(Vector2 other) {
    this..setFrom2(other)..normalize();
  }

  /// Set [this] to addition of [a] and [b].
  setAdditionOf(Vector2 a, Vector2 b) {
    this..setFrom2(a)..add(b);
  }
  
  /// Set [this] to subtraction of [a] and [b].
  setSubtractionOf(Vector2 a, Vector2 b) {
    this..setFrom2(a)..subtract(b);
  }

  /// Set [this] to scaled value of [other].
  setScaledOf(Vector2 other, double scalar) {
    this..setFrom2(other)..scale(scalar);
  }

  /// Returns absolute property of [this].
  Vector2 get absolute => new Vector2.from2(this)..absolutize();

  /// Returns negative property of [this].
  Vector2 get negative => new Vector2.from2(this)..negate();

  /// Returns normal property of [this].
  Vector2 get normal => new Vector2.from2(this)..normalize();

  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    } else {
      return
        (other is Vector2) &&
        (_storage[0] == other._storage[0]) &&
        (_storage[1] == other._storage[1]);
    }
  }

  Vector2 operator -() => new Vector2.from2(this)..negate();

  Vector2 operator -(Vector2 other) => new Vector2.from2(this)..subtract(other);

  Vector2 operator +(Vector2 other) => new Vector2.from2(this)..add(other);

  /// Division by a scalar.
  Vector2 operator /(double scalar) => new Vector2.from2(this)..scale(1.0 / scalar);

  /// Multiplication by a scalar.
  Vector2 operator *(double scalar) => new Vector2.from2(this)..scale(scalar);

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector2 other) {
    final d = dot2(this, other);
    return Math.acos(d / Math.sqrt(lengthSquared * other.lengthSquared));
  }

  /// Distance from [this] to [other]
  double distanceTo(Vector2 other) => Math.sqrt(distanceToSquared(other));

  /// Squared distance from [this] to [other]
  double distanceToSquared(Vector2 other) {
    final otherStorage = other._storage;
    final dx = _storage[0] - otherStorage[0];
    final dy = _storage[1] - otherStorage[1];
    return dx * dx + dy * dy;
  }
}
