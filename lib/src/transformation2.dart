// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vectors;

abstract class Transformer2 {

  Vector2 transform(Vector2 other);

}


/// 2D transformation.
class Transformation2 implements Transformer2 {

  Rotation2 rotation;
  Vector2 translation;
  double scale;

  Transformation2(this.rotation, this.translation, this.scale);

  Transformation2.nothing():
    rotation = new Rotation2.zero(),
    translation = new Vector2.zero(),
    scale = 1.0;

  Transformation2.from(Transformation2 other):
    rotation = new Rotation2.from(other.rotation),
    translation = new Vector2.from2(other.translation),
    scale = other.scale;

  void setNothing() {
    rotation.setZero();
    translation.setZero();
    scale = 1.0;
  }

  void setFrom(Transformation2 other) {
    rotation.setFrom(other.rotation);
    translation.setFrom2(other.translation);
    scale = other.scale;
  }

  void add(Transformation2 other) {
    this.rotation.add(other.rotation);
    this.translation.add(other.translation);
    this.scale += other.scale;
  }

  Transformation2 operator+(Transformation2 other) => new Transformation2.from(this)..add(other);

  void setAdditionOf(Transformation2 other, Transformation2 another) {
    this.setFrom(other)..add(another);
  }

  void invert() {
    rotation.invert();
    translation.negate();
    scale = 1 / scale;
  }

  Transformation2 inverse() => new Transformation2.from(this)..invert();

  void setInverseOf(Transformation2 other, Transformation2 another) {
    this.setFrom(other)..invert();
  }
}