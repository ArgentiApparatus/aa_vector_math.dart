// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_vector3;

import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:aa_vector_math/vector_math.dart';
import 'utilities.dart';

void main() {

  group('Vector3:', () {

    group('Contructors:', () {

      // Implicitly tests setter methods

      test("Zero", () {
        Vector3 v = new Vector3.zero();
        expect(v.storage, orderedEquals([0.0, 0.0, 0.0]));
      });

      test("All", () {
        Vector3 v = new Vector3.all(9.0);
        expect(v.storage, orderedEquals([9.0, 9.0, 9.0]));
      });

      test("From Vector3", () {
        Vector3 v = new Vector3.from2(new Vector2.components(1.0, 2.0));
        expect(v.storage, orderedEquals([1.0, 2.0, 0.0]));
      });

      test("From Vector2", () {
        Vector3 v = new Vector3.from3(new Vector3.components(1.0, 2.0, 3.0));
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("From Vector4", () {
        Vector3 v = new Vector3.from4(new Vector4.components(1.0, 2.0, 3.0, 4.0));
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("From Iterable", () {
        Vector3 v = new Vector3.fromIterable([1.0, 2.0, 3.0], 2);
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("Float32List View", () {
        Float32List list = new Float32List.fromList([1.0, 2.0, 3.0]);
        Vector3 v = new Vector3.view(list);
        expect([v.x, v.y, v.z], orderedEquals([1.0, 2.0, 3.0]));
        v.x = 9.0;
        expect(list, orderedEquals([9.0, 2.0, 3.0]));
      });
    });

    group('Simple Operations:', () {

      test("Make Absolute", () {
        Vector3 v;
        v = new Vector3.components(1.0, 2.0, 3.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3.components(1.0, 2.0, -3.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3.components(1.0, -2.0, 3.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3.components(-1.0, 2.0, 3.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3.components(-1.0, -2.0, -3.0)..makeAbsolute();
        expect(v.storage, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("Ceil Components", () {
        Vector3 v;
        v = new Vector3.components(1.1, 2.2, -3.3)..ceilComponents();
        expect(v.storage, orderedEquals([2.0, 3.0, -3.0]));
        v = new Vector3.components(1.1, -2.2, 3.3)..ceilComponents();
        expect(v.storage, orderedEquals([2.0, -2.0, 4.0]));
        v = new Vector3.components(-1.1, 2.2, 3.3)..ceilComponents();
        expect(v.storage, orderedEquals([-1.0, 3.0, 4.0]));
      });

      test("Floor Components", () {
        Vector3 v;
        v = new Vector3.components(1.1, 2.2, -3.3)..floorComponents();
        expect(v.storage, orderedEquals([1.0, 2.0, -4.0]));
        v = new Vector3.components(1.1, -2.2, 3.3)..floorComponents();
        expect(v.storage, orderedEquals([1.0, -3.0, 3.0]));
        v = new Vector3.components(-1.1, 2.2, 3.3)..floorComponents();
        expect(v.storage, orderedEquals([-2.0, 2.0, 3.0]));
      });

      test("Round Components", () {
        Vector3 v;
        v = new Vector3.components(1.1, 2.2, -3.3)..roundComponents();
        expect(v.storage, orderedEquals([1.0, 2.0, -3.0]));
        v = new Vector3.components(1.1, -2.2, 3.3)..roundComponents();
        expect(v.storage, orderedEquals([1.0, -2.0, 3.0]));
        v = new Vector3.components(-1.1, 2.2, 3.3)..roundComponents();
        expect(v.storage, orderedEquals([-1.0, 2.0, 3.0]));
      });

      test("truncate Components", () {
        Vector3 v;
        v = new Vector3.components(1.1, 2.2, -3.3)..truncateComponents();
        expect(v.storage, orderedEquals([1.0, 2.0, -3.0]));
        v = new Vector3.components(1.1, -2.2, 3.3)..truncateComponents();
        expect(v.storage, orderedEquals([1.0, -2.0, 3.0]));
        v = new Vector3.components(-1.1, 2.2, 3.3)..truncateComponents();
        expect(v.storage, orderedEquals([-1.0, 2.0, 3.0]));
      });

      test("Negate", () {
        Vector3 v;
        v = new Vector3.components(1.0, 2.0, -3.0)..negate();
        expect(v.storage, orderedEquals([-1.0, -2.0, 3.0]));
        v = new Vector3.components(1.0, -2.0, 3.0)..negate();
        expect(v.storage, orderedEquals([-1.0, 2.0, -3.0]));
        v = new Vector3.components(-1.0, 2.0, 3.0)..negate();
        expect(v.storage, orderedEquals([1.0, -2.0, -3.0]));
      });

      test("Clamp", () {
        Vector3 v;
        Vector3 lower = new Vector3.components(-2.0, -3.0, -4.0);
        Vector3 upper = new Vector3.components(2.0, 3.0, 4.0);
        v = new Vector3.components(0.0, 0.0, 0.0)..clamp(lower, upper);
        expect(v.storage, orderedEquals([0.0, 0.0, 0.0]));
        v = new Vector3.components(7.0, 7.0, -7.0)..clamp(lower, upper);
        expect(v.storage, orderedEquals([2.0, 3.0, -4.0]));
        v = new Vector3.components(7.0, -7.0, 7.0)..clamp(lower, upper);
        expect(v.storage, orderedEquals([2.0, -3.0, 4.0]));
        v = new Vector3.components(-7.0, 7.0, 7.0)..clamp(lower, upper);
        expect(v.storage, orderedEquals([-2.0, 3.0, 4.0]));
      });

      test("Clamp Scalar", () {
        Vector3 v;
        v = new Vector3.components(0.0, 0.0, 0.0)..clampScalar(-2.0, 3.0);
        expect(v.storage, orderedEquals([0.0, 0.0, 0.0]));
        v = new Vector3.components(5.0, 5.0, -5.0)..clampScalar(-2.0, 3.0);
        expect(v.storage, orderedEquals([3.0, 3.0, -2.0]));
        v = new Vector3.components(5.0, -5.0, 5.0)..clampScalar(-2.0, 3.0);
        expect(v.storage, orderedEquals([3.0, -2.0, 3.0]));
        v = new Vector3.components(-5.0, 5.0, 5.0)..clampScalar(-2.0, 3.0);
        expect(v.storage, orderedEquals([-2.0, 3.0, 3.0]));
      });
    });

    group('Complex Getters and Setters:', () {

      test("Get Length", () {
        double l = new Vector3.components(1.0, 2.0, 3.0).length;
        expect(l, closeTo(3.741657, 0.000005));
      });

      test("Set Length", () {
        Vector3 v = new Vector3.zero();
        v.length = 1.0;
        expect(v.storage, orderedEquals([0.0, 0.0, 0.0]));
        v = new Vector3.components(1.0, 2.0, 3.0)..length = 3.0;
        expect(v, closeToVector3(0.801784, 1.603568, 2.405351, 0.000005));
      });

      test("Get Length Squared", () {
        double l = new Vector3.components(1.0, 2.0, 3.0).lengthSquared;
        expect(l, closeTo(14.0, 0.000005));
      });
    });

    group('Complex Operations:', () {

      test("Normalize", () {
        Vector3 v = new Vector3.components(1.0, 2.0, 3.0)..normalize();
        expect(v, closeToVector3(0.267261, 0.534523, 0.801784, 0.000005));
      });

      test("Scale", () {
        Vector3 v = new Vector3.components(1.0, 2.0, 3.0)..scale(2.5);
        expect(v, closeToVector3(2.5, 5.0, 7.5, 0.000005));
      });

      test("Add", () {
        Vector3 v = new Vector3.components(1.0, 2.0, 3.0)..add(new Vector3.components(2.5, 3.5, 4.5));
        expect(v, closeToVector3(3.5, 5.5, 7.5, 0.000005));
      });

      test("Subtract", () {
        Vector3 v = new Vector3.components(1.0, 2.0, 3.0)..subtract(new Vector3.components(2.5, 4.5, 6.5));
        expect(v, closeToVector3(-1.5, -2.5, -3.5, 0.000005));
      });

      test("Multiply", () {
        Vector3 v = new Vector3.components(1.0, 2.0, 3.0)..multiply(new Vector3.components(2.5, 3.5, 4.5));
        expect(v, closeToVector3(2.5, 7.0, 13.5, 0.000005));
      });

      test("Divide", () {
        Vector3 v = new Vector3.components(1.0, 2.0, 3.0)..divide(new Vector3.components(2.5, 3.5, 4.5));
        expect(v, closeToVector3(0.400000, 0.571429, 0.666667, 0.000005));
      });
    });

    group('Operators:', () {

      test("Addition", () {
        Vector3 a = new Vector3.components(1.0, 2.0, 3.0);
        Vector3 b = new Vector3.components(2.5, 3.5, 4.5);
        Vector3 v = a + b;
        expect(v, isNot(same(a))); // Check operator returned a new object, 
        expect(v, isNot(same(b))); // not a modified input object
        expect(v, closeToVector3(3.5, 5.5, 7.5, 0.000005));
      });

      test("Subtraction", () {
        Vector3 a = new Vector3.components(1.0, 2.0, 3.0);
        Vector3 b = new Vector3.components(2.5, 4.5, 6.5);
        Vector3 v = a - b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector3(-1.5, -2.5, -3.5, 0.000005));
      });

      test("Negatation", () {
        Vector3 a = new Vector3.components(1.0, 2.0, 3.0);
        Vector3 v = -a;
        expect(v, isNot(same(a)));
        expect(v.storage, orderedEquals([-1.0, -2.0, -3.0]));
      });

      test("Multipication", () {
        Vector3 a = new Vector3.components(1.0, 2.0, 3.0);
        Vector3 v = a * 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(2.0, 4.0, 6.0, 0.000005));
      });

      test("Division", () {
        Vector3 a = new Vector3.components(1.0, 2.0, 3.0);
        Vector3 v = a / 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(0.5, 1.0, 1.5, 0.000005));
      });

      test("Indexing", () {
        Vector3 v = new Vector3.components(1.0, 2.0, 3.0);
        expect([v[0], v[1], v[2]], orderedEquals([1.0, 2.0, 3.0]));
        v.x = 9.0;
        v.y = 10.0;
        v.z = 11.0;
        expect([v[0], v[1], v[2]], orderedEquals([9.0, 10.0, 11.0]));
      });
    });

    group('Calculated Values:', () {

      test("DistanceTo", () {
        Vector3 a = new Vector3.components(1.5, 2.5, 3.5);
        Vector3 b = new Vector3.components(5.5, 6.5, 7.5);
        expect(a.distanceTo(b), closeTo(6.928203, 0.000005));
      });

      test("DistanceToSquared", () {
        Vector3 a = new Vector3.components(1.5, 2.5, 3.5);
        Vector3 b = new Vector3.components(5.5, 6.5, 7.5);
        expect(a.distanceToSquared(b), closeTo(48.0, 0.000005));
      });

      test("Dot Product", () {
        Vector3 a = new Vector3.components(1.5, 2.5, 3.5);
        Vector3 b = new Vector3.components(5.5, 6.5, 7.5);
        expect(a.dot(b), closeTo(50.75, 0.000005));
      });
    });

    group('Cross Products:', () {

      test("Cross Product 3", () {
        Vector3 a = new Vector3.components(1.5, 2.5, 3.5);
        Vector3 b = new Vector3.components(5.5, 6.5, 7.5);
        Vector3 v = new Vector3.cross3(a, b);
        expect(v, closeToVector3(-4.0, 8.0, -4.0, 0.000005));
      });

      test("Cross Product 2", () {
        Vector2 a = new Vector2.components(1.5, 2.5);
        Vector2 b = new Vector2.components(5.5, 6.5);
        Vector3 v = new Vector3.cross2(a, b);
        expect(v, closeToVector3(0.0, 0.0, -4.0, 0.000005));
      });
    });
  });
}