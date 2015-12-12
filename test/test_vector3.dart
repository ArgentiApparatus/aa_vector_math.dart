// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_vector3;

import 'dart:math';
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
        expect(v.components, orderedEquals([0.0, 0.0, 0.0]));
      });

      test("All", () {
        Vector3 v = new Vector3.all(9.0);
        expect(v.components, orderedEquals([9.0, 9.0, 9.0]));
      });

      test("From Vector3", () {
        Vector3 v = new Vector3.from2(new Vector2(1.0, 2.0));
        expect(v.components, orderedEquals([1.0, 2.0, 0.0]));
      });

      test("From Vector2", () {
        Vector3 v = new Vector3.from3(new Vector3(1.0, 2.0, 3.0));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("From Vector4", () {
        Vector3 v = new Vector3.from4(new Vector4(1.0, 2.0, 3.0, 4.0));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("From Iterable", () {
        Vector3 v = new Vector3.fromIterable([1.0, 2.0, 3.0]);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("Float32List View", () {
        Float32List list = new Float32List.fromList([1.0, 2.0, 3.0]);
        Vector3 v = new Vector3.view(list);
        expect([v.x, v.y, v.z], orderedEquals([1.0, 2.0, 3.0]));
        v.x = 9.0;
        expect(list, orderedEquals([9.0, 2.0, 3.0]));
      });
    });

    // Set froms that are not implicity tested via constructors
    group('Set Froms:', () {

      test("From 2", () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        v.setFrom2(new Vector2(10.0, 20.0));
        expect(v.components, orderedEquals([10.0, 20.0, 0.0]));
      });
    });

    group('Getters and Setters:', () {

      test("Get", () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        expect(v.x, 1.0);
        expect(v.y, 2.0);
        expect(v.z, 3.0);
        expect(v.r, 1.0);
        expect(v.g, 2.0);
        expect(v.b, 3.0);
      });

      test("Set", () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        v.x = 10.0;
        v.y = 20.0;
        v.z = 30.0;
        expect(v.x, 10.0);
        expect(v.y, 20.0);
        expect(v.z, 30.0);
        expect(v.r, 10.0);
        expect(v.g, 20.0);
        expect(v.b, 30.0);
        v.r = 100.0;
        v.g = 200.0;
        v.b = 300.0;
        expect(v.x, 100.0);
        expect(v.y, 200.0);
        expect(v.z, 300.0);
        expect(v.r, 100.0);
        expect(v.g, 200.0);
        expect(v.b, 300.0);
      });
    });

    group('Complex Getters and Setters:', () {

      test("Get Length", () {
        double l = new Vector3(1.0, 2.0, 3.0).length;
        expect(l, closeTo(3.741657, 0.000005));
      });

      test("Set Length", () {
        Vector3 v = new Vector3.zero();
        v.length = 1.0;
        expect(v.components, orderedEquals([0.0, 0.0, 0.0]));
        v = new Vector3(1.0, 2.0, 3.0)..length = 3.0;
        expect(v, closeToVector3(0.801784, 1.603568, 2.405351, 0.000005));
      });

      test("Get Length Squared", () {
        double l = new Vector3(1.0, 2.0, 3.0).lengthSquared;
        expect(l, closeTo(14.0, 0.000005));
      });

      test("Absolute", () {
        Vector3 a, v;
        a = new Vector3(1.0, 2.0, -3.0)..makeAbsolute();
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        a = new Vector3(1.0, -2.0, 3.0)..makeAbsolute();
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        a = new Vector3(-1.0, 2.0, 3.0)..makeAbsolute();
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("Negative", () {
        Vector3 a, v;
        a = new Vector3(1.0, 2.0, -3.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, -2.0, 3.0]));
        a = new Vector3(1.0, -2.0, 3.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, 2.0, -3.0]));
        a = new Vector3(-1.0, 2.0, 3.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, -2.0, -3.0]));
      });

      test("Normal", () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = a.normal;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(0.267261, 0.534523, 0.801784, 0.000005));
      });
    });

    group('Operators:', () {

      test("Addition", () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 b = new Vector3(2.5, 3.5, 4.5);
        Vector3 v = a + b;
        expect(v, isNot(same(a))); // Check operator returned a new object, 
        expect(v, isNot(same(b))); // not a modified input object
        expect(v, closeToVector3(3.5, 5.5, 7.5, 0.000005));
      });

      test("Subtraction", () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 b = new Vector3(2.5, 4.5, 6.5);
        Vector3 v = a - b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector3(-1.5, -2.5, -3.5, 0.000005));
      });

      test("Negatation", () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = -a;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, -2.0, -3.0]));
      });

      test("Multipication", () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = a * 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(2.0, 4.0, 6.0, 0.000005));
      });

      test("Division", () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = a / 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(0.5, 1.0, 1.5, 0.000005));
      });
    });

    group('Named Operations:', () {

      test("Make Absolute", () {
        Vector3 v;
        v = new Vector3(1.0, 2.0, -3.0)..makeAbsolute();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3(1.0, -2.0, 3.0)..makeAbsolute();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3(-1.0, 2.0, 3.0)..makeAbsolute();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test("Negate", () {
        Vector3 v;
        v = new Vector3(1.0, 2.0, -3.0)..negate();
        expect(v.components, orderedEquals([-1.0, -2.0, 3.0]));
        v = new Vector3(1.0, -2.0, 3.0)..negate();
        expect(v.components, orderedEquals([-1.0, 2.0, -3.0]));
        v = new Vector3(-1.0, 2.0, 3.0)..negate();
        expect(v.components, orderedEquals([1.0, -2.0, -3.0]));
      });

      test("Normalize", () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..normalize();
        expect(v, closeToVector3(0.267261, 0.534523, 0.801784, 0.000005));
      });

      test("Scale", () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..scale(2.5);
        expect(v, closeToVector3(2.5, 5.0, 7.5, 0.000005));
      });

      test("Add", () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..add(new Vector3(2.5, 3.5, 4.5));
        expect(v, closeToVector3(3.5, 5.5, 7.5, 0.000005));
      });

      test("Subtract", () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..subtract(new Vector3(2.5, 4.5, 6.5));
        expect(v, closeToVector3(-1.5, -2.5, -3.5, 0.000005));
      });
    });

    group('Calculated Values:', () {

      test("Angle Between", () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        expect(a.angleBetween(b), closeTo(0.190717, 0.000005));
        expect(b.angleBetween(a), closeTo(0.190717, 0.000005));

        a.setComponents(1.0, 0.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        expect(a.angleBetween(b), closeTo(PI/2, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0);
        expect(a.angleBetween(b), closeTo(PI/2, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        expect(a.angleBetween(b), closeTo(0.0, 0.000005));
      });

      test("DistanceTo", () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        expect(a.distanceTo(b), closeTo(6.928203, 0.000005));
      });

      test("DistanceToSquared", () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        expect(a.distanceToSquared(b), closeTo(48.0, 0.000005));
      });

      test("Dot Product", () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        expect(a.dot(b), closeTo(50.75, 0.000005));

        a.setComponents(1.0, 0.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        expect(a.dot(b), closeTo(0.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0);
        expect(a.dot(b), closeTo(0.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        expect(a.dot(b), closeTo(1.0, 0.000005));
      });
    });

    group('Cross Products:', () {

      test("Cross Product 3", () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        Vector3 v = new Vector3.cross3(a, b);
        expect(v, closeToVector3(-4.0, 8.0, -4.0, 0.000005));

        a.setComponents(1.0, 0.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        v = new Vector3.cross3(a, b);
        expect(v, closeToVector3(0.0, 0.0, 1.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0);
        v = new Vector3.cross3(a, b);
        expect(v, closeToVector3(1.0, 0.0, 0.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        v = new Vector3.cross3(a, b);
        expect(v, closeToVector3(0.0, 0.0, 0.0, 0.000005));
      });

      test("Cross Product 2", () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        Vector3 v = new Vector3.cross2(a, b);
        expect(v, closeToVector3(0.0, 0.0, -4.0, 0.000005));
      });
    });
  });
}
