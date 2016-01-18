// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vectors;

const _TWOPI = 2 * Math.PI;


/// 2D rotation.
class Rotation2 {

  /// Cummulative rotation in turns (2π radians).
  double turns;

  double get radians => turns * _TWOPI;
  set radians(double turns) { turns = radians / _TWOPI; }

  double get turnsSomething => turns % 1;
  double get radiansSomething => turnsSomething * _TWOPI;

  /// Constructs a new rotation with zero rotation.
  Rotation2.zero(): turns = 0.0;

  /// Constructs a new rotation with [turns] rotation.
  Rotation2.withTurns(this.turns);

  /// Constructs a new rotation with [radians] rotation.
  Rotation2.withRadians(double radians): turns = radians / _TWOPI;

  /// Constructs a new rotation copying from [other].
  Rotation2.from(Rotation2 other): this.turns = other.turns;

  /// Set rotation to zero;
  setZero() { turns = 0.0; }

  /// Set [this] rotation copying from [other].
  setFrom(Rotation2 other) { this.turns = other.turns; }

  /// Remove whole turns
  unwind() { turns %= 1; }

  /// Add [other] to [this].
  add(Rotation2 other) { this.turns += other.turns; }

  /// Subtract [other] from [this].
  subtract(Rotation2 other) { this.turns -= other.turns; }

  /// Multiply by scalar.
  multiply(double scalar) { turns *= scalar; }

  /// Divide by scalar.
  divide(double scalar) { turns /= scalar; }

  /// Negate.
  negate() { turns = -turns; }

  /// Returns true if rotations are equivalent.
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    } else {
      return (other is Rotation2) && ((other.turns % 1) == (this.turns % 1));
    }
  }

  Rotation2 operator -() => new Rotation2.withTurns(-this.turns);

  Rotation2 operator -(Rotation2 other) => new Rotation2.withTurns(this.turns - other.turns);

  Rotation2 operator +(Rotation2 other) => new Rotation2.withTurns(this.turns + other.turns);

  Rotation2 operator /(double scalar) => new Rotation2.withTurns(this.turns / scalar);
 
  Rotation2 operator *(double scalar) => new Rotation2.withTurns(this.turns  * scalar);

  /// Apply rotation to [vector], return [vector].
  Vector2 rotate(Vector2 vector) {
    double r = turns * _TWOPI;
    final vStorage = vector._storage;
    final cs = Math.cos(r);
    final sn = Math.sin(r);
    final x = (vStorage[0]) * (cs - vStorage[1] * sn); 
    final y = (vStorage[0]) * (sn + vStorage[1] * cs);
    vStorage[0] = x;
    vStorage[1] = y;
    return vector;
  }

  Vector2 rotateInto(Vector2 vector, Vector2 into) {
    into.setFrom2(vector);
    rotate(into);
    return into;
  }
}

/// Groups a rotation, tranlationa and scaling together
class Transformation2 {
  Rotation2 rotation;
  Vector2 translation;
  double scale;
  Transformation2(this.rotation, this.translation, this.scale);
}


