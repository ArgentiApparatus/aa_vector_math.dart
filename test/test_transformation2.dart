// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_transformation2;

import 'dart:math';
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:aa_vectors/vectors.dart';
import 'utilities.dart';

void main() {

  group('Transformation2:', () {

    group('Properties:', () {

      test('Radians Property', () {
      });

      test('Something Properties', () {
        Rotation2 r;
        r = new Rotation2.withTurns(0.25);
        expect(r.turnsSomething, 0.25);
        expect(r.radiansSomething, 0.5 * PI);
        r = new Rotation2.withTurns(1.25);
        expect(r.turnsSomething, 0.25);
        expect(r.radiansSomething, 0.5 * PI);
      });
    });

    group('Constructors:', () {

      test('Zero Constructor', () {
        Rotation2 r = new Rotation2.zero();
        expect(r.turns, 0.0);
        expect(r.radians, 0.0);
      });

      test('Turns Constructor', () {
        double t = 0.25;
        Rotation2 r = new Rotation2.withTurns(t);
        expect(r.turns, t);
        expect(r.radians, t * (2 * PI));
      });

      test('Radians Constructor', () {
        double a = 0.25;
        Rotation2 r = new Rotation2.withRadians(a);
        expect(r.turns, a / (2 * PI));
        expect(r.radians, a);
      });

      test('From Constructor', () {
        double t = 0.25;
        Rotation2 r = new Rotation2.from(new Rotation2.withTurns(t));
        expect(r.turns, t);
        expect(r.radians, t * (2 * PI));
      });
    });

    group('***:', () {

      test('Set Zero', () {
        double t = 0.25;
        Rotation2 r = new Rotation2.withTurns(t)..setZero();
        expect(r.turns, 0.0);
        expect(r.radians, 0.0);
      });

      test('Set From', () {
        double t = 0.25;
        Rotation2 r = new Rotation2.zero()..setFrom(new Rotation2.withTurns(t));
        expect(r.turns, t);
        expect(r.radians, t * (2 * PI));
      });
    });

    group('Named Operations:', () {

      test('Unwind', () {
        Rotation2 r;
        r = new Rotation2.withTurns(0.25)..unwind();
        expect(r.turns, 0.25);
        expect(r.radians, 0.5 * PI);
        r = new Rotation2.withTurns(1.25)..unwind();
        expect(r.turns, 0.25);
        expect(r.radians, 0.5 * PI);
      });

      test('Add', () {
        double t1 = 2.25;
        double t2 = 1.5;
        Rotation2 r = new Rotation2.withTurns(t1)..add(new Rotation2.withTurns(t2));
        expect(r.turns, t1 + t2);
        expect(r.radians, (t1 + t2) * (2 * PI));
      });

      test('Subtract', () {
        double t1 = 2.25;
        double t2 = 1.5;
        Rotation2 r = new Rotation2.withTurns(t1)..subtract(new Rotation2.withTurns(t2));
        expect(r.turns, t1 - t2);
        expect(r.radians, (t1 - t2) * (2 * PI));
      });

      test('Multiply', () {
        double t = 0.25;
        double multiplier = 2.2;
        Rotation2 r = new Rotation2.withTurns(t)..multiply(multiplier);
        expect(r.turns, (t) * multiplier);
        expect(r.radians, (t * multiplier) * 2 * PI);
      });

      test('Divide', () {
        double t = 0.25;
        double divisor = 2.2;
        Rotation2 r = new Rotation2.withTurns(t)..divide(divisor);
        expect(r.turns, (t) / divisor);
        expect(r.radians, (t / divisor) * 2 * PI);
      });

      test('Negate', () {
        double t = 0.25;
        Rotation2 r = new Rotation2.withTurns(t)..negate();
        expect(r.turns, -t);
        expect(r.radians, -t * 2 * PI);
      });
    });

    group('Operators:', () {

      test('Equality', () {
        Rotation2 rA, rB;
        rA = new Rotation2.withTurns(0.25);
        expect(rA, equals(rA));
        rB = new Rotation2.withTurns(0.25);
        expect(rA, equals(rB));
        rA = new Rotation2.withTurns(0.25);
        rB = new Rotation2.withTurns(1.25);
        expect(rA, equals(rB));
        rA = new Rotation2.withTurns(0.25);
        rB = new Rotation2.withTurns(0.50);
        expect(rA, isNot(equals(rB)));
      });

      test('Negation', () {
        Rotation2 a = new Rotation2.withTurns(0.25);
        Rotation2 v = -a;
        expect(v, isNot(same(a)));
        expect(v.turns, -(a.turns));
        expect(v.radians, -(a.radians));
      });

      test('Subtraction', () {
        double t1 = 2.25;
        double t2 = 1.5;
        Rotation2 a = new Rotation2.withTurns(t1);
        Rotation2 b = new Rotation2.withTurns(t2);
        Rotation2 r = a - b;
        expect(r, isNot(same(a)));
        expect(r, isNot(same(b)));
        expect(r.turns, t1 - t2);
        expect(r.radians, (t1 - t2) * (2 * PI));
      });

      test('Addition', () {
        double t1 = 2.25;
        double t2 = 1.5;
        Rotation2 a = new Rotation2.withTurns(t1);
        Rotation2 b = new Rotation2.withTurns(t2);
        Rotation2 r = a + b;
        expect(r, isNot(same(a)));
        expect(r, isNot(same(b)));
        expect(r.turns, t1 + t2);
        expect(r.radians, (t1 + t2) * (2 * PI));
      });

      test('Division', () {
        double t1 = 2.25;
        double divisor = 2.2;
        Rotation2 a = new Rotation2.withTurns(t1);
        Rotation2 r = a / divisor;
        expect(r, isNot(same(a)));
        expect(r.turns, t1 / divisor);
        expect(r.radians, (t1 / divisor) * (2 * PI));
       });

      test('Multiplication', () {
        double t1 = 2.25;
        double multiplier = 2.2;
        Rotation2 a = new Rotation2.withTurns(t1);
        Rotation2 r = a * multiplier;
        expect(r, isNot(same(a)));
        expect(r.turns, t1 * multiplier);
        expect(r.radians, (t1 * multiplier) * (2 * PI));
      });
    });

    group('Rotation:', () {

      test('Rotate < 2π', () {
        Rotation2 r = new Rotation2.withTurns(0.125);
        Vector2 v = new Vector2(1.0, 2.0);
        r.rotate(v);
        expect(v, closeToVector2(-0.707107, 2.121320, 0.000005));
      });

      test('Rotate > 2π', () {
        Rotation2 r = new Rotation2.withTurns(1.125);
        Vector2 v = new Vector2(1.0, 2.0);
        r.rotate(v);
        expect(v, closeToVector2(-0.707107, 2.121320, 0.000005));
      });

      test('Rotate into', () {
        Rotation2 r = new Rotation2.withTurns(0.125);
        Vector2 v = new Vector2(1.0, 2.0);
        Vector u = new Vector2.zero();
        Vector w = r.rotateInto(v, u);
        expect(w, closeToVector2(-0.707107, 2.121320, 0.000005));
        expect(w, isNot(same(v)));
        expect(w, same(u));
      });



    });
  });
}
