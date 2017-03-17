import 'dart:typed_data';
import 'dart:math' as Math;

/// 3D vector.
class Vector3 {

  // Number of components.
  static const int NUM_COMPONENTS = 3;

  // Component storage.
  final Float64List _storage;

  /// Constructs a new vector with all components set to zero.
  Vector3.zero() : _storage = new Float64List(NUM_COMPONENTS);

  /// Constructs a new vector from component values.
  factory Vector3(num x, num y, num z) =>
      new Vector3.zero()..setTo(x, y, z);

  /// Constructs a new vector with all components set to [value].
  factory Vector3.all(num value) => new Vector3.zero()..setAll(value);

  /// Constructs a new vector copying component values from [other], [z] set to zero.
  factory Vector3.from2(Vector2 other, [num z = 0.0]) => new Vector3.zero()..setFrom2(other, z);

  /// Constructs a new vector copying component values from [other].
  factory Vector3.from3(Vector3 other) => new Vector3.zero()..setFrom3(other);

  /// Constructs a new vector copying component values from [iterable].
  /// 
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  factory Vector3.fromIterable(Iterable<num> iterable) =>
      new Vector3.zero()..setFromIterable(iterable);

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
  Vector3.view(ByteBuffer buffer, [int offset = 0]):
      _storage = new Float64List.view(buffer, offset * Float64List.BYTES_PER_ELEMENT, NUM_COMPONENTS);

  /// Set all components to zero.
  void setZero() {
    _storage[0] = 0.0;
    _storage[1] = 0.0;
    _storage[2] = 0.0;
  }

  /// Set the component values.
  void setTo(num x, num y, num z) {
    _storage[0] = x.toDouble();
    _storage[1] = y.toDouble();
    _storage[2] = z.toDouble();
  }

  /// Set all components to [value].
  void setAll(num value) {
    _storage[0] = value.toDouble();
    _storage[1] = value.toDouble();
    _storage[2] = value.toDouble();
  }

  /// Set [x] and [y] components by copying them from [other].
  /// 
  /// If [z] is not provided it defaults to zero;
  void setFrom2(Vector2 other, [num z = 0.0]) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = z.toDouble();
  }

  /// Set the components by copying them from [other].
  void setFrom3(Vector3 other) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
    _storage[2] = otherStorage[2];
  }

  /// Set the components by copying them from [iterable].
  /// 
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  void setFromIterable(Iterable<num> iterable) {
    int i=0;
    for(num d in iterable.take(NUM_COMPONENTS)) {
      _storage[i++] = d.toDouble();
    }
  }

  String toString() => '[${_storage[0]},${_storage[1]},${_storage[2]}]';

  /// Components as a [List]: [x, y, z].
  List<double> asList() => _storage;

  /// Components as a [Float64List]: [x, y, z].
  Float64List asFloat64List() => _storage;

  double get x => _storage[0];
  double get y => _storage[1];
  double get z => _storage[2];

  set x(num value) { _storage[0] = value.toDouble(); }
  set y(num value) { _storage[1] = value.toDouble(); }
  set z(num value) { _storage[2] = value.toDouble(); }

  /// True if all components are zero.
  bool get isZero => _storage[0] == 0.0 && _storage[1] == 0.0 && _storage[2] == 0.0;

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
  set length(num value) {
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

  /// Set [this] to its absolute value.
  void absolutize() {
    _storage[0] = _storage[0].abs();
    _storage[1] = _storage[1].abs();
    _storage[2] = _storage[2].abs();
  }

  /// Negate [this].
  void negate() {
    _storage[0] = -_storage[0];
    _storage[1] = -_storage[1];
    _storage[2] = -_storage[2];
  }

  /// Normalize [this].
  void normalize() {
    double l = length;
    if (l != 0.0) {
      l = 1.0 / l;
      _storage[0] *= l;
      _storage[1] *= l;
      _storage[2] *= l;
    }
  }

  /// Add [other] to [this].
  void add(Vector3 other) {
    final otherStorage = other._storage;
    _storage[0] += otherStorage[0];
    _storage[1] += otherStorage[1];
    _storage[2] += otherStorage[2];
  }

  /// Subtract [other] from [this].
  void subtract(Vector3 other) {
    final otherStorage = other._storage;
    _storage[0] -= otherStorage[0];
    _storage[1] -= otherStorage[1];
    _storage[2] -= otherStorage[2];
  }

  /// Scale [this] by a scalar value.
  void scale(num scalar) {
    _storage[0] *= scalar;
    _storage[1] *= scalar;
    _storage[2] *= scalar;
  }

  /// Divide [this] by a scalar value.
  void divide(num scalar) {
    _storage[0] /= scalar;
    _storage[1] /= scalar;
    _storage[2] /= scalar;
  }

  /// Set [this] to absolute value of [other].
  void setAbsoluteOf(Vector3 other) {
    this..setFrom3(other)..absolutize();
  }

  /// Set [this] to negative value of [other].
  void setNegativeOf(Vector3 other) {
    this..setFrom3(other)..negate();
  }

  /// Set [this] to negative value of [other].
  void setNormalOf(Vector3 other) {
    this..setFrom3(other)..normalize();
  }

  /// Set [this] to addition of [a] and [another].
  void setAdditionOf(Vector3 other, Vector3 another) {
    this..setFrom3(other)..add(another);
  }

  /// Set [this] to subtraction of [other] and [another].
  void setSubtractionOf(Vector3 other, Vector3 another) {
    this..setFrom3(other)..subtract(another);
  }

  /// Set [this] to scaling of [other] by [scalar].
  void setScalingOf(Vector3 other, num scalar) {
    this..setFrom3(other)..scale(scalar);
  }

  /// Set [this] to division of [other] by [scalar].
  void setDivisionOf(Vector3 other, num scalar) {
    this..setFrom3(other)..divide(scalar);
  }

  /// Set [this] to cross product of [other] and [another].
  void setCrossOf2(Vector2 other, Vector2 another) {
    _cross2(other, another, this);
  }

  /// Set [this] to cross product of [other] and [another].
  void setCrossOf3(Vector3 other, Vector3 another) {
    _cross3(other, another, this);
  }

  /// Returns absolute version of [this].
  Vector3 absolute() => new Vector3.from3(this)..absolutize();

  /// Returns normal version of [this].
  Vector3 normal() => new Vector3.from3(this)..normalize();

  /// Returns cross product of [this] and [other].
  Vector3 cross3(Vector3 other) => _cross3(this, other, new Vector3.zero());

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

  Vector3 operator +(Vector3 other) => new Vector3.from3(this)..add(other);

  Vector3 operator -() => new Vector3.from3(this)..negate();

  Vector3 operator -(Vector3 other) => new Vector3.from3(this)..subtract(other);

  /// Multiplication by a scalar.
  Vector3 operator *(num scalar) => new Vector3.from3(this)..scale(scalar);

  /// Division by a scalar.
  Vector3 operator /(num scalar) => new Vector3.from3(this)..scale(1.0 / scalar);

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector3 other) {
    final d = dot(other);
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

  /// Dot product of [this] and [other].
  double dot(Vector3 other) {
    double sum = this._storage[0] * other._storage[0];
    sum += this._storage[1] * other._storage[1];
    sum += this._storage[2] * other._storage[2];
    return sum;
  }
}

/// Set [into] to the cross product of [other] and [another], return into.
Vector3 _cross3(Vector3 other, Vector3 another, Vector3 into) {
  final ax = other._storage[0];
  final ay = other._storage[1];
  final az = other._storage[2];
  final bx = another._storage[0];
  final by = another._storage[1];
  final bz = another._storage[2];
  into._storage[0] = ay * bz - az * by;
  into._storage[1] = az * bx - ax * bz;
  into._storage[2] = ax * by - ay * bx;
  return into;
}

