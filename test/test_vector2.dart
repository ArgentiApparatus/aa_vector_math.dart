// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_vector2;

import 'dart:math';
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:aa_vector_math/vector_math.dart';
import 'utilities.dart';

void main() {

  group('Vector2:', () {

    group('Contructors:', () {

      // Implicitly tests setter methods

      test("Zero", () {
        Vector2 v = new Vector2.zero();
        expect(v.storage, orderedEquals([0.0, 0.0]));
      });

      test("All", () {
        Vector2 v = new Vector2.all(9.0);
        expect(v.storage, orderedEquals([9.0, 9.0]));
      });

      test("From Vector2", () {
        Vector2 v = new Vector2.from2(new Vector2.components(1.0, 2.0));
        expect(v.storage, orderedEquals([1.0, 2.0]));
      });

      test("From Vector3", () {
        Vector2 v = new Vector2.from3(new Vector3.components(1.0, 2.0, 3.0));
        expect(v.storage, orderedEquals([1.0, 2.0]));
      });

      test("From Vector2", () {
        Vector2 v = new Vector2.from4(new Vector4.components(1.0, 2.0, 3.0, 4.0));
        expect(v.storage, orderedEquals([1.0, 2.0]));
      });

      test("From Iterable", () {
        Vector2 v = new Vector2.fromIterable([1.0, 2.0], 2);
        expect(v.storage, orderedEquals([1.0, 2.0]));
      });

      test("Float32List View", () {
        Float32List list = new Float32List.fromList([1.0, 2.0]);
        Vector2 v = new Vector2.view(list);
        expect([v.x, v.y], orderedEquals([1.0, 2.0]));
        v.x = 9.0;
        expect(list, orderedEquals([9.0, 2.0]));
      });
    });

    group('Getters and Setters:', () {

      test("Get", () {
        Vector2 v = new Vector2.components(1.0, 2.0);
        expect(v.x, 1.0);
        expect(v.y, 2.0);
      });

      test("Set", () {
        Vector2 v = new Vector2.components(1.0, 2.0);
        v.x = 10.0;
        v.y = 20.0;
        expect(v.x, 10.0);
        expect(v.y, 20.0);
      });
    });

    group('Complex Getters and Setters:', () {

      test("Get Length", () {
        double l = new Vector2.components(1.0, 2.0).length;
        expect(l, closeTo(2.236068, 0.000005));
      });

      test("Set Length", () {
        Vector2 v = new Vector2.zero();
        v.length = 1.0;
        expect(v.storage, orderedEquals([0.0, 0.0]));
        v = new Vector2.components(1.0, 2.0)..length = 3.0;
        expect(v, closeToVector2(1.341641, 2.683282, 0.000005));
      });

      test("Get Length Squared", () {
        double l = new Vector2.components(1.0, 2.0).lengthSquared;
        expect(l, closeTo(5.0, 0.000005));
      });
    });

    group('Simple Operations:', () {

      test("Make Absolute", () {
        Vector v;
        v = new Vector2.components(1.0, 2.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0]));
        v = new Vector2.components(1.0, -2.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0]));
        v = new Vector2.components(-1.0, 2.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0]));
        v = new Vector2.components(-1.0, -2.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0]));
      });

      test("Ceil Components", () {
        Vector v;
        v = new Vector2.components(1.1, -2.2)..ceilComponents();
        expect(v.storage, orderedEquals([2.0, -2.0]));
        v = new Vector2.components(-1.1, 2.2)..ceilComponents();
        expect(v.storage, orderedEquals([-1.0, 3.0]));
      });

      test("Floor Components", () {
        Vector v;
        v = new Vector2.components(1.1, -2.2)..floorComponents();
        expect(v.storage, orderedEquals([1.0, -3.0]));
        v = new Vector2.components(-1.1, 2.2)..floorComponents();
        expect(v.storage, orderedEquals([-2.0, 2.0]));
      });

      test("Round Components", () {
        Vector v;
        v = new Vector2.components(1.1, -2.8)..roundComponents();
        expect(v.storage, orderedEquals([1.0, -3.0]));
        v = new Vector2.components(-1.1, 2.8)..roundComponents();
        expect(v.storage, orderedEquals([-1.0, 3.0]));
      });

      test("truncate Components", () {
        Vector v;
        v = new Vector2.components(1.1, -2.2)..truncateComponents();
        expect(v.storage, orderedEquals([1.0, -2.0]));
        v = new Vector2.components(-1.1, 2.2)..truncateComponents();
        expect(v.storage, orderedEquals([-1.0, 2.0]));
      });

      test("Negate", () {
        Vector v;
        v = new Vector2.components(1.0, -2.0)..negate();
        expect(v.storage, orderedEquals([-1.0, 2.0]));
        v = new Vector2.components(-1.0, 2.0)..negate();
        expect(v.storage, orderedEquals([1.0, -2.0]));
      });

      test("Clamp", () {
        Vector2 v;
        Vector2 lower = new Vector2.components(-2.0, -3.0);
        Vector2 upper = new Vector2.components(2.0, 3.0);
        v = new Vector2.components(0.0, 0.0)..clamp(lower, upper);
        expect(v.storage, orderedEquals([0.0, 0.0]));
        v = new Vector2.components(7.0, -7.0)..clamp(lower, upper);
        expect(v.storage, orderedEquals([2.0, -3.0]));
        v = new Vector2.components(-7.0, 7.0)..clamp(lower, upper);
        expect(v.storage, orderedEquals([-2.0, 3.0]));
      });

      test("Clamp Scalar", () {
        Vector2 v;
        v = new Vector2.components(0.0, 0.0)..clampScalar(-2.0, 3.0);
        expect(v.storage, orderedEquals([0.0, 0.0]));
        v = new Vector2.components(5.0, -5.0)..clampScalar(-2.0, 3.0);
        expect(v.storage, orderedEquals([3.0, -2.0]));
        v = new Vector2.components(-5.0, 5.0)..clampScalar(-2.0, 3.0);
        expect(v.storage, orderedEquals([-2.0, 3.0]));
      });
    });

    group('Complex Operations:', () {

      test("Normalize", () {
        Vector2 v = new Vector2.components(1.0, 2.0)..normalize();
        expect(v, closeToVector2(0.447214, 0.894427, 0.000005));
      });

      test("Scale", () {
        Vector2 v = new Vector2.components(1.0, 2.0)..scale(2.5);
        expect(v, closeToVector2(2.5, 5.0, 0.000005));
      });

      test("Add", () {
        Vector2 v = new Vector2.components(1.0, 2.0)..add(new Vector2.components(2.5, 3.5));
        expect(v, closeToVector2(3.5, 5.5, 0.000005));
      });

      test("Subtract", () {
        Vector2 v = new Vector2.components(1.0, 2.0)..subtract(new Vector2.components(2.5, 4.5));
        expect(v, closeToVector2(-1.5, -2.5, 0.000005));
      });

      test("Multiply", () {
        Vector2 v = new Vector2.components(1.0, 2.0)..multiply(new Vector2.components(2.5, 3.5));
        expect(v, closeToVector2(2.5, 7.0, 0.000005));
      });

      test("Divide", () {
        Vector2 v = new Vector2.components(1.0, 2.0)..divide(new Vector2.components(2.5, 3.5));
        expect(v, closeToVector2(0.400000, 0.571429, 0.000005));
      });
    });

    group('Operators:', () {

      test("Addition", () {
        Vector2 a = new Vector2.components(1.0, 2.0);
        Vector2 b = new Vector2.components(2.5, 3.5);
        Vector2 v = a + b;
        expect(v, isNot(same(a))); // Check operator returned a new object, 
        expect(v, isNot(same(b))); // not a modified input object
        expect(v, closeToVector2(3.5, 5.5, 0.000005));
      });

      test("Subtraction", () {
        Vector2 a = new Vector2.components(1.0, 2.0);
        Vector2 b = new Vector2.components(2.5, 4.5);
        Vector2 v = a - b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector2(-1.5, -2.5, 0.000005));
      });

      test("Negatation", () {
        Vector2 a = new Vector2.components(1.0, 2.0);
        Vector2 v = -a;
        expect(v, isNot(same(a)));
        expect(v.storage, orderedEquals([-1.0, -2.0]));
      });

      test("Multipication", () {
        Vector2 a = new Vector2.components(1.0, 2.0);
        Vector2 v = a * 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector2(2.0, 4.0, 0.000005));
      });

      test("Division", () {
        Vector2 a = new Vector2.components(1.0, 2.0);
        Vector2 v = a / 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector2(0.5, 1.0, 0.000005));
      });

      test("Indexing", () {
        Vector2 v = new Vector2.components(1.0, 2.0);
        expect([v[0], v[1]], orderedEquals([1.0, 2.0]));
        v.x = 9.0;
        v.y = 10.0;
        expect([v[0], v[1]], orderedEquals([9.0, 10.0]));
      });
    });

    group('Calculated Values:', () {

      test("Angle Between", () {
        Vector2 a = new Vector2.components(1.5, 2.5);
        Vector2 b = new Vector2.components(5.5, 6.5);
        expect(a.angleBetween(b), closeTo(0.161837, 0.000005));
        expect(b.angleBetween(a), closeTo(0.161837, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(0.0, 1.0);
        expect(a.angleBetween(b), closeTo(PI/2, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(1.0, 0.0);
        expect(a.angleBetween(b), closeTo(0.0, 0.000005));
      });

      test("DistanceTo", () {
        Vector2 a = new Vector2.components(1.5, 2.5);
        Vector2 b = new Vector2.components(5.5, 6.5);
        expect(a.distanceTo(b), closeTo(5.656854, 0.000005));
      });

      test("DistanceToSquared", () {
        Vector2 a = new Vector2.components(1.5, 2.5);
        Vector2 b = new Vector2.components(5.5, 6.5);
        expect(a.distanceToSquared(b), closeTo(32.0, 0.000005));
      });

      test("Dot Product", () {
        Vector2 a = new Vector2.components(1.5, 2.5);
        Vector2 b = new Vector2.components(5.5, 6.5);
        expect(a.dot(b), closeTo(24.5, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(0.0, 1.0);
        expect(a.dot(b), closeTo(0.0, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(1.0, 0.0);
        expect(a.dot(b), closeTo(1.0, 0.000005));
      });

      test("Cross Product Length", () {
        Vector2 a = new Vector2.components(1.5, 2.5);
        Vector2 b = new Vector2.components(5.5, 6.5);
        expect(a.cross2Length(b), closeTo(-4.0, 0.000005));
      });
    });
  });
}