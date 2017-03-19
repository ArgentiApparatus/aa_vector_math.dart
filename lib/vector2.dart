import 'dart:typed_data';
import 'dart:math' as Math;

/// 2D vector.
class Vector2 {

  String toString() => '[${_storage[0]},${_storage[1]}]';

  // Number of components.
  static const int DIM = 2;

  // Component storage.
  final Float64List _storage;

  /// Constructs a new vector with all components set to zero.
  Vector2.zero() : _storage = new Float64List(DIM);

  /// Constructs a new vector from component values.
  factory Vector2(num x, num y) => new Vector2.zero()..setTo(x, y);

  /// Constructs a new vector copying component values from [other].
  factory Vector2.from(Vector2 other) => new Vector2.zero()..setFrom(other);

  /// Constructs a new vector copying component values from [iterable].
  ///
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  factory Vector2.fromIterable(Iterable<num> iterable) =>
      new Vector2.zero()..setFromIterable(iterable);

  /// Set all components to zero.
  void setZero() {
    _storage[0] = 0.0;
    _storage[1] = 0.0;
  }

  /// Set the component values.
  void setTo(num x, num y) {
    _storage[0] = x.toDouble();
    _storage[1] = y.toDouble();
  }

  /// Set [x] and [y] components by copying them from [other].
  void setFrom(Vector2 other) {
    final otherStorage = other._storage;
    _storage[0] = otherStorage[0];
    _storage[1] = otherStorage[1];
  }

  /// Set the components by copying them from [iterable].
  ///
  /// If [iterable] contains *n* elements which is less than [NUM_COMPONENTS],
  /// only the first *n* components of [this] will be set.
  void setFromIterable(Iterable<num> iterable) {
    int i=0;
    for(num d in iterable.take(DIM)) {
      _storage[i++] = d.toDouble();
    }
  }

  double get x => _storage[0];
  double get y => _storage[1];

  set x(num value) { _storage[0] = value.toDouble(); }
  set y(num value) { _storage[1] = value.toDouble(); }

  /// True if all components are zero.
  bool get isZero => _storage[0] == 0.0 && _storage[1] == 0.0;

  // The number of components (dimension) in this vector.
  int get dim => DIM;

  /// Length.
  double get length => Math.sqrt(lengthSquared);

  /// Set the length of the vector.
  ///
  /// A negative [value] will reverse the vector's orientation and a [value] of
  /// zero will set the vector to zero.
  ///
  /// If [this] is zero, invoking this method has no effect.
  set length(num value) {
    if (value == 0.0) {
      setZero();
    } else {
      double l = length; // TODO reimplement?
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
  void absolutize() {
    _storage[0] = _storage[0].abs();
    _storage[1] = _storage[1].abs();
  }

  /// Negate [this].
  void negate() {
    _storage[0] = -_storage[0];
    _storage[1] = -_storage[1];
  }

  /// Normalize [this].
  ///
  /// If [this] is zero, invoking this method has no effect.
  void normalize() {
    double l = length; //TODO reimplement based on set length
    if (l != 0.0) {
      l = 1.0 / l;
      _storage[0] *= l;
      _storage[1] *= l;
    }
  }

  /// Add [other] to [this].
  void add(Vector2 other) {
    final otherStorage = other._storage;
    _storage[0] += otherStorage[0];
    _storage[1] += otherStorage[1];
  }

  /// Subtract [other] from [this].
  void subtract(Vector2 other) {
    final otherStorage = other._storage;
    _storage[0] -= otherStorage[0];
    _storage[1] -= otherStorage[1];
  }

  /// Scale [this] by a scalar value.
  void scale(num scalar) {
    _storage[0] *= scalar;
    _storage[1] *= scalar;
  }

  /// Divide [this] by a scalar value.
  void divide(num scalar) {
    _storage[0] /= scalar;
    _storage[1] /= scalar;
  }

  /// Set [this] to absolute value of [other].
  void setAbsoluteOf(Vector2 other) {
    this..setFrom(other)..absolutize();
  }

  /// Set [this] to negative value of [other].
  void setNegativeOf(Vector2 other) {
    this..setFrom(other)..negate();
  }

  /// Set [this] to normal value of [other].
  ///
  /// Note: normal of zero vector is zero vector.
  void setNormalOf(Vector2 other) {
    this..setFrom(other)..normalize();
  }

  // TODO does not work if another is self
  /// Set [this] to addition of [other] and [another].
  ///
  /// Note: copies [other] to [this] then adds [another], so if [another] is [this] the resulting value of [this] will be [other]+[other].
  void setAdditionOf(Vector2 other, Vector2 another) {
    this..setFrom(other)..add(another);
  }

  // TODO does not work if another is self
  /// Set [this] to subtraction of [other] and [another].
  /// Note: copies [other] to [this] then adds [another], so if [another] is [this] the resulting value of [this] will be [other]-[other].
  void setSubtractionOf(Vector2 other, Vector2 another) {
    this..setFrom(other)..subtract(another);
  }

  /// Set [this] to scaling of [other] by [scalar].
  void setScalingOf(Vector2 other, num scalar) {
    this..setFrom(other)..scale(scalar);
  }

  /// Set [this] to division of [other] by [scalar].
  void setDivisionOf(Vector2 other, num scalar) {
    this..setFrom(other)..divide(scalar);
  }

  /// Returns absolute version of [this].
  Vector2 absolute() => new Vector2.from(this)..absolutize();

  /// Returns normal version of [this].
  ///
  /// Note: normal of zero vector is zero vector.
  Vector2 normal() => new Vector2.from(this)..normalize();

  bool operator==(Object other) {
    if(identical(this, other)) {
      return true;
    } else {
      return
        (other is Vector2) &&
        (_storage[0] == other._storage[0]) &&
        (_storage[1] == other._storage[1]);
    }
  }

  Vector2 operator +(Vector2 other) => new Vector2.from(this)..add(other);

  Vector2 operator -() => new Vector2.from(this)..negate();

  Vector2 operator -(Vector2 other) => new Vector2.from(this)..subtract(other);

  /// Multiplication by a scalar.
  Vector2 operator *(num scalar) => new Vector2.from(this)..scale(scalar);

  /// Division by a scalar.
  Vector2 operator /(num scalar) => new Vector2.from(this)..divide(scalar);

  /// Absolute angle between [this] and [other] in radians.
  double angleBetween(Vector2 other) {
    final d = dot(other);
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

  /// Dot product of [this] and [other].
  double dot(Vector2 other) {
    double sum = this._storage[0] * other._storage[0];
    sum += this._storage[1] * other._storage[1];
    return sum;
  }

  /// Cross product vector length.
  double crossed(Vector2 other) {
    return this._storage[0] * other._storage[1] - this._storage[1] * other._storage[0];
  }

  /// Copy components to list starting at [offset], return the supplied list.
  List<num> copyToList(List<num> list, { int offset: 0 }) {
    list[offset] = x;
    list[offset + 1] = y;
    return list;
  }

  /// Components as a list.
  List<double> toList() => [x, y];

}