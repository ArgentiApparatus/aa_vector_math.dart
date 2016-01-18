// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_vector2;

import 'dart:math';
import 'dart:typed_data';
import 'package:test/test.dart';
import 'package:aa_vectors/vectors.dart';
import 'utilities.dart';

void main() {

  group('Vector2:', () {

    group('Constructors:', () {

      test('Default', () {
        Vector2 v = new Vector2(1.0, 2.0);
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('Zero', () {
        Vector2 v = new Vector2.zero();
        expect(v.components, orderedEquals([0.0, 0.0]));
      });

      test('All', () {
        Vector2 v = new Vector2.all(9.0);
        expect(v.components, orderedEquals([9.0, 9.0]));
      });

      test('From Vector2', () {
        Vector2 v = new Vector2.from2(new Vector2(1.0, 2.0));
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('From Vector3', () {
        Vector2 v = new Vector2.from3(new Vector3(1.0, 2.0, 3.0));
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('From Iterable', () {
        Vector2 v = new Vector2.fromIterable([1.0, 2.0]);
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('Float32List View', () {
        Float64List list = new Float64List.fromList([1.0, 2.0, 3.0, 4.0]);
        Vector2 v = new Vector2.view(list.buffer);
        expect([v.x, v.y], orderedEquals([1.0, 2.0]));

        v = new Vector2.view(list.buffer, 2);
        expect([v.x, v.y], orderedEquals([3.0, 4.0]));

        v.x = 9.0;
        expect(list, orderedEquals([1.0, 2.0, 9.0, 4.0]));
      });
    });

    group('Set Methods:', () {

      test('Set Components', () {
        Vector2 v = new Vector2.zero();
        v.setComponents(1.0, 2.0);
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('Set Zero', () {
        Vector2 v = new Vector2(1.0, 2.0);
        v.setZero();
        expect(v.components, orderedEquals([0.0, 0.0]));
      });

      test('Set All', () {
        Vector2 v = new Vector2.zero();
        v.setAll(9.0);
        expect(v.components, orderedEquals([9.0, 9.0]));
      });

      test('From 2', () {
        Vector2 v = new Vector2(1.0, 2.0);
        v.setFrom2(new Vector2(10.0, 20.0));
        expect(v.components, orderedEquals([10.0, 20.0]));
      });

      test('From 3', () {
        Vector2 v = new Vector2(1.0, 2.0);
        v.setFrom3(new Vector3(10.0, 20.0, 30.0));
        expect(v.components, orderedEquals([10.0, 20.0]));
      });
    });

    group('Simple Properties:', () {

      test('Get x, y', () {
        Vector2 v = new Vector2(1.0, 2.0);
        expect(v.x, 1.0);
        expect(v.y, 2.0);
      });

      test('Set x, y', () {
        Vector2 v = new Vector2(1.0, 2.0);
        v.x = 10.0;
        v.y = 20.0;
        expect(v.x, 10.0);
        expect(v.y, 20.0);
      });
    });

    group('Calculated Properties:', () {

      test('isZero', () {
        Vector2 v = new Vector2(1.0, 2.0);
        expect(false, v.isZero);
        v.x = 0.0;
        expect(false, v.isZero);
        v.y = 0.0;
        expect(true, v.isZero);
      });

      test('Get Length', () {
        double l = new Vector2(1.0, 2.0).length;
        expect(l, closeTo(2.236068, 0.000005));
      });

      test('Set Length', () {
        Vector2 v = new Vector2.zero();
        v.length = 1.0;
        expect(v.components, orderedEquals([0.0, 0.0]));
        v = new Vector2(1.0, 2.0)..length = 3.0;
        expect(v, closeToVector2(1.341641, 2.683282, 0.000005));
      });

      test('Get Length Squared', () {
        double l = new Vector2(1.0, 2.0).lengthSquared;
        expect(l, closeTo(5.0, 0.000005));
      });
      
    });

    group('Vector Operations:', () {

      test('Absolutize', () {
        Vector v;
        v = new Vector2(1.0, -2.0)..absolutize();
        expect(v.components, orderedEquals([1.0, 2.0]));
        v = new Vector2(-1.0, 2.0)..absolutize();
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('Negate', () {
        Vector v;
        v = new Vector2(1.0, -2.0)..negate();
        expect(v.components, orderedEquals([-1.0, 2.0]));
        v = new Vector2(-1.0, 2.0)..negate();
        expect(v.components, orderedEquals([1.0, -2.0]));
      });

      test('Normalize', () {
        Vector2 v = new Vector2(1.0, 2.0)..normalize();
        expect(v, closeToVector2(0.447214, 0.894427, 0.000005));
      });

      test('Add', () {
        Vector2 v = new Vector2(1.0, 2.0)..add(new Vector2(2.5, 3.5));
        expect(v, closeToVector2(3.5, 5.5, 0.000005));
      });

      test('Subtract', () {
        Vector2 v = new Vector2(1.0, 2.0)..subtract(new Vector2(2.5, 4.5));
        expect(v, closeToVector2(-1.5, -2.5, 0.000005));
      });

      test('Scale', () {
        Vector2 v = new Vector2(1.0, 2.0)..scale(2.5);
        expect(v, closeToVector2(2.5, 5.0, 0.000005));
      });
    });

    group('Set Result Of:', () {

      test('Absolute Of', () {
        Vector2 a, v;
        a = new Vector2(1.0, -2.0);
        v = new Vector2.zero()..setAbsoluteOf(a);
        expect(v.components, orderedEquals([1.0, 2.0]));
        a = new Vector2(-1.0, 2.0);
        v = new Vector2.zero()..setAbsoluteOf(a);
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('Negative Of', () {
        Vector2 a, v;
        a = new Vector2(1.0, -2.0);
        v = new Vector2.zero()..setNegativeOf(a);
        expect(v.components, orderedEquals([-1.0, 2.0]));
        a = new Vector2(-1.0, 2.0);
        v = new Vector2.zero()..setNegativeOf(a);
        expect(v.components, orderedEquals([1.0, -2.0]));
      });

      test('Normal Of', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 v = new Vector2.zero()..setNormalOf(a);
        expect(v, closeToVector2(0.447214, 0.894427, 0.000005));
       });

      test('Addition Of', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 b = new Vector2(2.5, 3.5);
        Vector2 v = new Vector2.zero()..setAdditionOf(a, b);
        expect(v, closeToVector2(3.5, 5.5, 0.000005));
      });

      test('Subtraction Of', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 b = new Vector2(2.5, 4.5);
        Vector2 v = new Vector2.zero()..setSubtractionOf(a, b);
        expect(v, closeToVector2(-1.5, -2.5, 0.000005));
     });

      test('Scaled Of', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 v = new Vector2.zero()..setScaledOf(a, 2.0);
        expect(v, closeToVector2(2.0, 4.0, 0.000005));
      });
    });

    group('Vector Operation Properties:', () {

      test('Absolute', () {
        Vector2 a, v;
        a = new Vector2(1.0, -2.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0]));
        a = new Vector2(-1.0, 2.0);
        v = a.absolute;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, 2.0]));
      });

      test('Negative', () {
        Vector2 a, v;
        a = new Vector2(1.0, -2.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, 2.0]));
        a = new Vector2(-1.0, 2.0);
        v = a.negative;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, -2.0]));
      });

      test('Normal', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 v = a.normal;
        expect(v, isNot(same(a)));
        expect(v, closeToVector2(0.447214, 0.894427, 0.000005));
      });
    });

    group('Operators:', () {

      test('Addition', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 b = new Vector2(2.5, 3.5);
        Vector2 v = a + b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector2(3.5, 5.5, 0.000005));
      });

      test('Subtraction', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 b = new Vector2(2.5, 4.5);
        Vector2 v = a - b;
        expect(v, isNot(same(a)));
        expect(v, isNot(same(b)));
        expect(v, closeToVector2(-1.5, -2.5, 0.000005));
      });

      test('Negatation', () {
        Vector2 a, v;
        a = new Vector2(-1.0, 2.0);
        v = -a;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([1.0, -2.0]));
        a = new Vector2(1.0, -2.0);
        v = -a;
        expect(v, isNot(same(a)));
        expect(v.components, orderedEquals([-1.0, 2.0]));
      });

      test('Multipication', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 v = a * 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector2(2.0, 4.0, 0.000005));
      });

      test('Division', () {
        Vector2 a = new Vector2(1.0, 2.0);
        Vector2 v = a / 2.0;
        expect(v, isNot(same(a)));
        expect(v, closeToVector2(0.5, 1.0, 0.000005));
      });
    });

    group('Calculated Values:', () {

      test('Angle Between', () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        expect(a.angleBetween(b), closeTo(0.161837, 0.000005));
        expect(b.angleBetween(a), closeTo(0.161837, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(0.0, 1.0);
        expect(a.angleBetween(b), closeTo(PI/2, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(1.0, 0.0);
        expect(a.angleBetween(b), closeTo(0.0, 0.000005));
      });

      test('DistanceTo', () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        expect(a.distanceTo(b), closeTo(5.656854, 0.000005));
      });

      test('DistanceToSquared', () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        expect(a.distanceToSquared(b), closeTo(32.0, 0.000005));
      });

      test('Dot Product', () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        expect(dot2(a, b), closeTo(24.5, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(0.0, 1.0);
        expect(dot2(a, b), closeTo(0.0, 0.000005));

        a.setComponents(1.0, 0.0);
        b.setComponents(1.0, 0.0);
        expect(dot2(a, b), closeTo(1.0, 0.000005));
      });

      test('Cross Product Length', () {
        Vector2 a = new Vector2(1.5, 2.5);
        Vector2 b = new Vector2(5.5, 6.5);
        expect(cross2Length(a, b), closeTo(-4.0, 0.000005));
      });
    });
  });
}
