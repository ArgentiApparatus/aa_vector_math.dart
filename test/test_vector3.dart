// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_vector3;

import 'dart:math';
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:aa_vectors/vectors.dart';
import 'utilities.dart';

void main() {

  group('Vector3:', () {

    group('Constructors:', () {

      test('Default', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test('Zero', () {
        Vector3 v = new Vector3.zero();
        expect(v.components, orderedEquals([0.0, 0.0, 0.0]));
      });

      test('All', () {
        Vector3 v = new Vector3.all(9.0);
        expect(v.components, orderedEquals([9.0, 9.0, 9.0]));
      });

      test('From Vector2', () {
        Vector3 v = new Vector3.from3(new Vector3(1.0, 2.0, 3.0));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test('From Vector3', () {
        Vector3 v = new Vector3.from2(new Vector2(1.0, 2.0));
        expect(v.components, orderedEquals([1.0, 2.0, 0.0]));
      });

      test('From Iterable', () {
        Vector3 v = new Vector3.fromIterable([1.0, 2.0, 3.0]);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test('Float32List View', () {
        Float64List list = new Float64List.fromList([1.0, 2.0, 3.0, 4.0, 5.0]);
        Vector3 v = new Vector3.view(list.buffer);
        expect([v.x, v.y, v.z], orderedEquals([1.0, 2.0, 3.0]));

        v = new Vector3.view(list.buffer, 2);
        expect([v.x, v.y, v.z], orderedEquals([3.0, 4.0, 5.0]));

        v.x = 9.0;
        expect(list, orderedEquals([1.0, 2.0, 9.0, 4.0, 5.0]));
      });
    });

    // Set froms that are not implicity tested via constructors
    group('Set Methods:', () {

      test('Set Components', () {
        Vector3 v = new Vector3.zero();
        v.setComponents(1.0, 2.0, 3.0);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test('Set Zero', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        v.setZero();
        expect(v.components, orderedEquals([0.0, 0.0, 0.0]));
      });

      test('Set All', () {
        Vector3 v = new Vector3.zero();
        v.setAll(9.0);
        expect(v.components, orderedEquals([9.0, 9.0, 9.0]));
      });

      test('From 2', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        v.setFrom2(new Vector2(10.0, 20.0));
        expect(v.components, orderedEquals([10.0, 20.0, 0.0]));
      
        v.setFrom2(new Vector2(10.0, 20.0), 300.0);
        expect(v.components, orderedEquals([10.0, 20.0, 300.0]));
      });

      test('From 3', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        v.setFrom3(new Vector3(10.0, 20.0, 30.0));
        expect(v.components, orderedEquals([10.0, 20.0, 30.0]));
      });
    });

    group('Simple Properties:', () {

      test('Get x, y, z', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        expect(v.x, 1.0);
        expect(v.y, 2.0);
        expect(v.z, 3.0);
      });

      test('Set x, y, z', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        v.x = 10.0;
        v.y = 20.0;
        v.z = 30.0;
        expect(v.x, 10.0);
        expect(v.y, 20.0);
        expect(v.z, 30.0);
      });
    });

    group('Calculated Properties:', () {

      test('isZero', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0);
        expect(false, v.isZero);
        v.x = 0.0;
        expect(false, v.isZero);
        v.y = 0.0;
        expect(false, v.isZero);
        v.z = 0.0;
        expect(true, v.isZero);
      });

      test('Get Length', () {
        double l = new Vector3(1.0, 2.0, 3.0).length;
        expect(l, closeTo(3.741657, 0.000005));
      });

      test('Set Length', () {
        Vector3 v = new Vector3.zero();
        v.length = 1.0;
        expect(v.components, orderedEquals([0.0, 0.0, 0.0]));
        v = new Vector3(1.0, 2.0, 3.0)..length = 3.0;
        expect(v, closeToVector3(0.801784, 1.603568, 2.405351, 0.000005));
      });

      test('Get Length Squared', () {
        double l = new Vector3(1.0, 2.0, 3.0).lengthSquared;
        expect(l, closeTo(14.0, 0.000005));
      });

    });

    group('Vector Operations:', () {

      test('Absolutize', () {
        Vector3 v;
        v = new Vector3(1.0, 2.0, -3.0)..absolutize();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3(1.0, -2.0, 3.0)..absolutize();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        v = new Vector3(-1.0, 2.0, 3.0)..absolutize();
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test('Negate', () {
        Vector3 v;
        v = new Vector3(1.0, 2.0, -3.0)..negate();
        expect(v.components, orderedEquals([-1.0, -2.0, 3.0]));
        v = new Vector3(1.0, -2.0, 3.0)..negate();
        expect(v.components, orderedEquals([-1.0, 2.0, -3.0]));
        v = new Vector3(-1.0, 2.0, 3.0)..negate();
        expect(v.components, orderedEquals([1.0, -2.0, -3.0]));
      });

      test('Normalize', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..normalize();
        expect(v, closeToVector3(0.267261, 0.534523, 0.801784, 0.000005));
      });

      test('Scale', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..scale(2.5);
        expect(v, closeToVector3(2.5, 5.0, 7.5, 0.000005));
      });

      test('Add', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..add(new Vector3(2.5, 3.5, 4.5));
        expect(v, closeToVector3(3.5, 5.5, 7.5, 0.000005));
      });

      test('Subtract', () {
        Vector3 v = new Vector3(1.0, 2.0, 3.0)..subtract(new Vector3(2.5, 4.5, 6.5));
        expect(v, closeToVector3(-1.5, -2.5, -3.5, 0.000005));
      });
    });

    group('Set Result Of:', () {

      test('Absolute Of', () {
        Vector3 a, v;
        a = new Vector3(1.0, 2.0, -3.0);
        v = new Vector3.zero()..setAbsoluteOf(a);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        a = new Vector3(1.0, -2.0, 3.0);
        v = new Vector3.zero()..setAbsoluteOf(a);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        a = new Vector3(-1.0, 2.0, 3.0);
        v = new Vector3.zero()..setAbsoluteOf(a);
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test('Negative Of', () {
        Vector3 a, v;
        a = new Vector3(1.0, 2.0, -3.0);
        v = new Vector3.zero()..setNegativeOf(a);
        expect(v.components, orderedEquals([-1.0, -2.0, 3.0]));
        a = new Vector3(1.0, -2.0, 3.0);
        v = new Vector3.zero()..setNegativeOf(a);
        expect(v.components, orderedEquals([-1.0, 2.0, -3.0]));
        a = new Vector3(-1.0, 2.0, 3.0);
        v = new Vector3.zero()..setNegativeOf(a);
        expect(v.components, orderedEquals([1.0, -2.0, -3.0]));
      });

      test('Normal Of', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = new Vector3.zero()..setNormlOf(a);
        expect(v, closeToVector3(0.267261, 0.534523, 0.801784, 0.000005));
      });

      test('Addition Of', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 b = new Vector3(2.5, 3.5, 4.5);
        Vector3 v = new Vector3.zero()..setAdditionOf(a, b);
        expect(v, closeToVector3(3.5, 5.5, 7.5, 0.000005));
      });

      test('Subtraction Of', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 b = new Vector3(2.5, 4.5, 6.5);
        Vector3 v = new Vector3.zero()..setSubtractionOf(a, b);
        expect(v, closeToVector3(-1.5, -2.5, -3.5, 0.000005));
      });

      test('Scaled Of', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = new Vector3.zero()..setScaledOf(a, 2.0);
        expect(v, closeToVector3(2.0, 4.0, 6.0, 0.000005));
      });

    });

    group('Vector Operation Properties:', () {

      test('Absolute', () {
        Vector3 a, v;
        a = new Vector3(1.0, 2.0, -3.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        a = new Vector3(1.0, -2.0, 3.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
        a = new Vector3(-1.0, 2.0, 3.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0, 3.0]));
      });

      test('Negative', () {
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

      test('Normal', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = a.normal;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(0.267261, 0.534523, 0.801784, 0.000005));
      });
    });

    group('Operators:', () {

      test('Addition', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 b = new Vector3(2.5, 3.5, 4.5);
        Vector3 v = a + b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector3(3.5, 5.5, 7.5, 0.000005));
      });

      test('Subtraction', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 b = new Vector3(2.5, 4.5, 6.5);
        Vector3 v = a - b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector3(-1.5, -2.5, -3.5, 0.000005));
      });

      test('Negatation', () {
        Vector3 a, v;
        a = new Vector3(1.0, 2.0, -3.0);
        v = -a;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, -2.0, 3.0]));
        a = new Vector3(1.0, -2.0, 3.0);
        v = -a;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, 2.0, -3.0]));
        a = new Vector3(-1.0, 2.0, 3.0);
        v = -a;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, -2.0, -3.0]));
      });

      test('Multipication', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = a * 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(2.0, 4.0, 6.0, 0.000005));
      });

      test('Division', () {
        Vector3 a = new Vector3(1.0, 2.0, 3.0);
        Vector3 v = a / 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector3(0.5, 1.0, 1.5, 0.000005));
      });
    });

    group('Calculated Values:', () {

      test('Angle Between', () {
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

      test('DistanceTo', () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        expect(a.distanceTo(b), closeTo(6.928203, 0.000005));
      });

      test('DistanceToSquared', () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        expect(a.distanceToSquared(b), closeTo(48.0, 0.000005));
      });

      test('Dot Product', () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        expect(dot3(a, b), closeTo(50.75, 0.000005));

        a.setComponents(1.0, 0.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        expect(dot3(a, b), closeTo(0.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0);
        expect(dot3(a, b), closeTo(0.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        expect(dot3(a, b), closeTo(1.0, 0.000005));
      });
    });

    group('Cross Products:', () {

      test('Cross Product 3', () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        Vector3 v = cross3(a, b);
        expect(v, closeToVector3(-4.0, 8.0, -4.0, 0.000005));

      });

      test('Cross Product 3 Unit Vectors', () {
        Vector3 a = new Vector3.zero();
        Vector3 b = new Vector3.zero();
        Vector3 v; 

        a.setComponents(1.0, 0.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        v = cross3(a, b);
        expect(v, closeToVector3(0.0, 0.0, 1.0, 0.000005));
        v = cross3(b, a);
        expect(v, closeToVector3(0.0, 0.0, -1.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 0.0, 1.0);
        v = cross3(a, b);
        expect(v, closeToVector3(1.0, 0.0, 0.0, 0.000005));
        v = cross3(b, a);
        expect(v, closeToVector3(-1.0, 0.0, 0.0, 0.000005));

        a.setComponents(0.0, 0.0, 1.0);
        b.setComponents(1.0, 0.0, 0.0);
        v = cross3(a, b);
        expect(v, closeToVector3(0.0, 1.0, 0.0, 0.000005));
        v = cross3(b, a);
        expect(v, closeToVector3(0.0, -1.0, 0.0, 0.000005));

        a.setComponents(0.0, 1.0, 0.0);
        b.setComponents(0.0, 1.0, 0.0);
        v = cross3(a, b);
        expect(v, closeToVector3(0.0, 0.0, 0.0, 0.000005));
      });

      test('Cross Product 3 Output Instance', () {
        Vector3 a = new Vector3(1.5, 2.5, 3.5);
        Vector3 b = new Vector3(5.5, 6.5, 7.5);
        Vector3 v = cross3(a, b);
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        Vector3 w = cross3(a, b, v);
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(w, same(v));
      });

      test('Cross Product 2', () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        Vector3 v = cross2(a, b);
        expect(v, closeToVector3(0.0, 0.0, -4.0, 0.000005));
      });

      test('Cross Product 2 Output Instance', () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        Vector3 v = cross2(a, b);
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        Vector3 w = cross2(a, b, v);
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(w, same(v));
      });
    });
  });
}
