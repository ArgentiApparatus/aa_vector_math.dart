// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_vector4;

import 'dart:math';
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:aa_vector_math/vector_math.dart';
import 'utilities.dart';

void main() {

  group('Vector4:', () {

    group('Contructors:', () {

      // Implicitly tests setter methods

      test("Zero", () {
        Vector4 v = new Vector4.zero();
        expect(v.components, orderedEquals([0.0, 0.0, 0.0, 0.0]));
      });

      test("All", () {
        Vector4 v = new Vector4.all(9.0);
        expect(v.components, orderedEquals([9.0, 9.0, 9.0, 9.0]));
      });

      test("From Vector4", () {
        Vector4 v = new Vector4.from2(new Vector2(1.0, 2.0));
        expect(v.components, orderedEquals([1.0, 2.0, 0.0, 0.0]));
      });

      test("From Vector2", () {
        Vector4 v = new Vector4.from3(new Vector3(1.0, 2.0, 3.0));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 0.0]));
      });

      test("From Vector4", () {
        Vector4 v = new Vector4.from4(new Vector4(1.0, 2.0, 3.0, 4.0));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
      });

      test("From List", () {
        Vector4 v = new Vector4.fromIterable([1.0, 2.0, 3.0, 4.0]);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
      });

      test("Float32List View", () {
        Float32List list = new Float32List.fromList([1.0, 2.0, 3.0, 4.0]);
        Vector4 v = new Vector4.view(list);
        expect([v.x, v.y, v.z, v.w], orderedEquals([1.0, 2.0, 3.0, 4.0]));
        v.x = 9.0;
        expect(list, orderedEquals([9.0, 2.0, 3.0, 4.0]));
      });
    });

    // Set froms that are not implicity tested via constructors
    group('Set Froms:', () {

      test("From 2", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0);
        v.setFrom2(new Vector2(10.0, 20.0));
        expect(v.components, orderedEquals([10.0, 20.0, 0.0, 0.0]));
      });

      test("From 4", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0);
        v.setFrom3(new Vector3(10.0, 20.0, 30.0));
        expect(v.components, orderedEquals([10.0, 20.0, 30.0, 0.0]));
      });
    });

    group('Getters and Setters:', () {

      test("Get", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0);
        expect(v.x, 1.0);
        expect(v.y, 2.0);
        expect(v.z, 3.0);
        expect(v.w, 4.0);
        expect(v.r, 1.0);
        expect(v.g, 2.0);
        expect(v.b, 3.0);
        expect(v.a, 4.0);
      });

      test("Set", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0);
        v.x = 10.0;
        v.y = 20.0;
        v.z = 30.0;
        v.w = 40.0;
        expect(v.x, 10.0);
        expect(v.y, 20.0);
        expect(v.z, 30.0);
        expect(v.w, 40.0);
        expect(v.r, 10.0);
        expect(v.g, 20.0);
        expect(v.b, 30.0);
        expect(v.a, 40.0);
        v.r = 100.0;
        v.g = 200.0;
        v.b = 300.0;
        v.a = 400.0;
        expect(v.x, 100.0);
        expect(v.y, 200.0);
        expect(v.z, 300.0);
        expect(v.a, 400.0);
        expect(v.r, 100.0);
        expect(v.g, 200.0);
        expect(v.b, 300.0);
        expect(v.a, 400.0);
      });
    });

    group('Complex Getters and Setters:', () {

      test("Get Length", () {
        double l = new Vector4(1.0, 2.0, 3.0, 4.0).length;
        expect(l, closeTo(5.477226, 0.000005));
      });

      test("Set Length", () {
        Vector4 v = new Vector4.zero();
        v.length = 1.0;
        expect(v.components, orderedEquals([0.0, 0.0, 0.0, 0.0]));
        v = new Vector4(1.0, 2.0, 3.0, 4.0)..length = 3.0;
        expect(v, closeToVector4(0.547723, 1.095445, 1.643168, 2.190890, 0.000005));
      });

      test("Get Length Squared", () {
        double l = new Vector4(1.0, 2.0, 3.0, 4.0).lengthSquared;
        expect(l, closeTo(30.0, 0.000005));
      });

      test("Absolute", () {
        Vector4 a, v;
        a = new Vector4(1.0, 2.0, 3.0, -4.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
        a = new Vector4(1.0, 2.0, -3.0, 4.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
        a = new Vector4(1.0, -2.0, 3.0, 4.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
        a = new Vector4(-1.0, 2.0, 3.0 ,4.0)..makeAbsolute();
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
      });

      test("Negative", () {
        Vector4 a, v;
        a = new Vector4(1.0, 2.0, 3.0, -4.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, -2.0, -3.0, 4.0]));
        a = new Vector4(1.0, 2.0, -3.0, 4.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, -2.0, 3.0, -4.0]));
        a = new Vector4(1.0, -2.0, 3.0, 4.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, 2.0, -3.0, -4.0]));
        a = new Vector4(-1.0, 2.0, 3.0, 4.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, -2.0, -3.0, -4.0]));
      });

      test("Normal", () {
        Vector4 a = new Vector4(1.0, 2.0, 3.0, 4.0);
        Vector4 v = a.normal;
        expect(v, isNot(same(a)));
        expect(v, closeToVector4(0.182574, 0.365148, 0.547723, 0.730297, 0.000005));
      });
    });

    group('Operators:', () {

      test("Addition", () {
        Vector4 a = new Vector4(1.0, 2.0, 3.0, 4.0);
        Vector4 b = new Vector4(2.5, 3.5, 4.5, 5.5);
        Vector4 v = a + b;
        expect(v, isNot(same(a))); // Check operator returned a new object, 
        expect(v, isNot(same(b))); // not a modified input object
        expect(v, closeToVector4(3.5, 5.5, 7.5, 9.5, 0.000005));
      });

      test("Subtraction", () {
        Vector4 a = new Vector4(1.0, 2.0, 3.0, 4.0);
        Vector4 b = new Vector4(2.5, 4.5, 6.5, 8.5);
        Vector4 v = a - b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector4(-1.5, -2.5, -3.5, -4.5, 0.000005));
      });

      test("Negatation", () {
        Vector4 a = new Vector4(1.0, 2.0, 3.0, 4.0);
        Vector4 v = -a;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, -2.0, -3.0, -4.0]));
      });

      test("Multipication", () {
        Vector4 a = new Vector4(1.0, 2.0, 3.0, 4.0);
        Vector4 v = a * 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector4(2.0, 4.0, 6.0, 8.0, 0.000005));
      });

      test("Division", () {
        Vector4 a = new Vector4(1.0, 2.0, 3.0, 4.0);
        Vector4 v = a / 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector4(0.5, 1.0, 1.5, 2.0, 0.000005));
      });
    });

    group('Named Operations:', () {

      test("Make Absolute", () {
        Vector4 v;
        v = new Vector4(1.0, 2.0, 3.0, -4.0)..makeAbsolute();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
        v = new Vector4(1.0, 2.0, -3.0, 4.0)..makeAbsolute();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
        v = new Vector4(1.0, -2.0, 3.0, 4.0)..makeAbsolute();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
        v = new Vector4(-1.0, 2.0, 3.0 ,4.0)..makeAbsolute();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0, 4.0]));
      });

      test("Negate", () {
        Vector4 v;
        v = new Vector4(1.0, 2.0, 3.0, -4.0)..negate();
        expect(v.components, orderedEquals([-1.0, -2.0, -3.0, 4.0]));
        v = new Vector4(1.0, 2.0, -3.0, 4.0)..negate();
        expect(v.components, orderedEquals([-1.0, -2.0, 3.0, -4.0]));
        v = new Vector4(1.0, -2.0, 3.0, 4.0)..negate();
        expect(v.components, orderedEquals([-1.0, 2.0, -3.0, -4.0]));
        v = new Vector4(-1.0, 2.0, 3.0, 4.0)..negate();
        expect(v.components, orderedEquals([1.0, -2.0, -3.0, -4.0]));
      });

      test("Normalize", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0)..normalize();
        expect(v, closeToVector4(0.182574, 0.365148, 0.547723, 0.730297, 0.000005));
      });

      test("Scale", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0)..scale(2.5);
        expect(v, closeToVector4(2.5, 5.0, 7.5, 10, 0.000005));
      });

      test("Add", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0)..add(new Vector4(2.5, 3.5, 4.5, 5.5));
        expect(v, closeToVector4(3.5, 5.5, 7.5, 9.5, 0.000005));
      });

      test("Subtract", () {
        Vector4 v = new Vector4(1.0, 2.0, 3.0, 4.0)..subtract(new Vector4(2.5, 4.5, 6.5, 8.5));
        expect(v, closeToVector4(-1.5, -2.5, -3.5, -4.5, 0.000005));
      });
    });

    group('Calculated Values:', () {

      test("Angle Between", () {
        Vector4 a = new Vector4(1.5, 2.5, 3.5, 4.5);
        Vector4 b = new Vector4(5.5, 6.5, 7.5, 8.5);
        expect(a.angleBetween(b), closeTo(0.198352, 0.000005));
        expect(b.angleBetween(a), closeTo(0.198352, 0.000005));

        a.setComponents(1.0, 0.0, 0.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0, 0.0);
        expect(a.angleBetween(b), closeTo(PI/2, 0.000005));

        a.setComponents(0.0, 1.0, 0.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0, 0.0);
        expect(a.angleBetween(b), closeTo(PI/2, 0.000005));

        a.setComponents(0.0, 0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 0.0, 1.0);
        expect(a.angleBetween(b), closeTo(PI/2, 0.000005));

        a.setComponents(0.0, 0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0, 0.0);
        expect(a.angleBetween(b), closeTo(0.0, 0.000005));
      });

      test("DistanceTo", () {
        Vector4 a = new Vector4(1.5, 2.5, 3.5, 4.5);
        Vector4 b = new Vector4(5.5, 6.5, 7.5, 8.5);
        expect(a.distanceTo(b), closeTo(8.000000, 0.000005));
      });

      test("DistanceToSquared", () {
        Vector4 a = new Vector4(1.5, 2.5, 3.5, 4.5);
        Vector4 b = new Vector4(5.5, 6.5, 7.5, 8.5);
        expect(a.distanceToSquared(b), closeTo(64.0, 0.000005));
      });

      test("Dot Product", () {
        Vector4 a = new Vector4(1.5, 2.5, 3.5, 4.5);
        Vector4 b = new Vector4(5.5, 6.5, 7.5, 8.5);
        expect(a.dot(b), closeTo(89.0, 0.000005));

        a.setComponents(1.0, 0.0, 0.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0, 0.0);
        expect(a.dot(b), closeTo(0.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0, 0.0);
        expect(a.dot(b), closeTo(0.0, 0.000005));

        a.setComponents(0.0, 0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 0.0, 1.0);
        expect(a.dot(b), closeTo(0.0, 0.000005));

        a.setComponents(0.0, 0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0, 0.0);
        expect(a.dot(b), closeTo(1.0, 0.000005));
      });
    });
  });
}
