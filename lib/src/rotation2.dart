// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vectors;


const _TWOPI = 2 * Math.PI;


/// 2D rotation.
class Rotation2 {

  String toString() => '[$radians]';

  // Number of components.
  static const int NUM_COMPONENTS = 1;

  // Component storage.
  final Float64List _storage;// = new Float64List(NUM_COMPONENTS);

  /// Rotation in radians.
  double get radians => _storage[0];
  set radians(num radians) { _storage[0] = radians; }

  /// Rotation in turns (2π radians).
  double get turns => radians / _TWOPI;
  set turns(double turns) { radians = turns * _TWOPI; }

  double get absTurns => turns % 1;
  double get absRadians => radians % _TWOPI;

  /// Components as a [List]: [radians].
  List<double> asList() => _storage;

  /// Components as a [Float64List]: [radians].
  Float64List asFloat64List() => _storage;

  /// Constructs a new [Rotation2] with zero rotation.
  Rotation2.zero(): _storage = new Float64List(NUM_COMPONENTS);

  /// Constructs a new [Rotation2] with [radians] rotation.
  factory Rotation2(num radians) => new Rotation2.zero().._storage[0] = radians;

  /// Constructs a new [Rotation2] with [turns] rotation.
  factory Rotation2.fromTurns(double turns) => new Rotation2.zero().._storage[0] = turns * _TWOPI;

  /// Constructs a new [Rotation2] copying from [other].
  factory Rotation2.from(Rotation2 other) => new Rotation2.zero().._storage[0] = other._storage[0];

  /// Set rotation to zero;
  void setZero() { radians = 0.0; }

  /// Set [this] rotation copying from [other].
  void setFrom(Rotation2 other) { this.radians = other.radians; }

  /// Set rotation to positive angle < 2π.
  void flibblize() { radians %= _TWOPI; }

  /// Invert.
  void invert() { radians = -radians; }

  /// Add [other] to [this].
  void add(Rotation2 other) { this.radians += other.radians; }

  /// Subtract [other] from [this].
  void subtract(Rotation2 other) { this.radians -= other.radians; }

  /// Multiply by scalar.
  void scale(double scalar) { radians *= scalar; }

  /// Divide by scalar.
  void divide(double scalar) { radians /= scalar; }

  /// Set [this] to unwound value of [other].
  void setFlibbleOf(Rotation2 other) {
    this..setFrom(other)..flibblize();
  }

  /// Set [this] to inverse value of [other].
  void setInverseOf(Rotation2 other) {
    this..setFrom(other)..invert();
  }

  /// Set [this] to addition of [other] and [another].
  void setAdditionOf(Rotation2 other, Rotation2 another) {
    this..setFrom(other)..add(another);
  }

  /// Set [this] to subtraction of [other] and [another].
  void setSubtractionOf(Rotation2 other, Rotation2 another) {
    this..setFrom(other)..subtract(another);
  }

  /// Set [this] to scaling of [other] by [scalar].
  void setScalingOf(Rotation2 other, double scalar) {
    this..setFrom(other)..scale(scalar);
  }

  /// Set [this] to division of [other] by [scalar].
  void setDivisionOf(Rotation2 other, double scalar) {
    this..setFrom(other)..divide(scalar);
  }

  /// Returns absolute version of [this].
  Rotation2 flibble() => new Rotation2.from(this)..flibblize();

  /// Returns inverse  of [this].
  Rotation2 inverse() => new Rotation2.from(this)..invert();

  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    } else {
      return (other is Rotation2) && (other.radians == this.radians);
    }
  }

  Rotation2 operator -() => new Rotation2(-this.radians);

  Rotation2 operator -(Rotation2 other) => new Rotation2(this.radians - other.radians);

  Rotation2 operator +(Rotation2 other) => new Rotation2(this.radians + other.radians);

  Rotation2 operator /(double scalar) => new Rotation2(this.radians / scalar);

  Rotation2 operator *(double scalar) => new Rotation2(this.radians  * scalar);

  /// Apply rotation to [vector], return [vector].
  Vector2 transform(Vector2 vector) {
    final vStorage = vector._storage;
    final cs = Math.cos(radians);
    final sn = Math.sin(radians);
    final x = (vStorage[0]) * (cs - vStorage[1] * sn);
    final y = (vStorage[0]) * (sn + vStorage[1] * cs);
    vStorage[0] = x;
    vStorage[1] = y;
    return vector;
  }
}
