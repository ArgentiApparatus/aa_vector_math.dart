import 'package:test/test.dart';

import 'package:aa_vectors/vector2.dart';

import 'matchers.dart';
import 'tester.dart';


dynamic getCopy(var o) {
  if(o is Vector2) {
    return new Vector2.from(o);
  } else if(o is List) {
    return new List.from(o);
  } else if(o is num) {
    return o;
  } else {
    return null;
  }
}


List<Map<String, dynamic>> data = [
  {
    'v': new Vector2(-1, 2),
    'w': new Vector2(4, -5),
    'f': -7,
    'l': [8, -9],
    'get x': equals(-1),
    'get y': equals(2),
    'dim': equals(2),
    'string': equals('[-1, 2]'),
    'eql': equals(false),
    'isZero': equals(false),
    'list': orderedEquals([-1, 2]),
    'ang': closeTo(2.930499, 0.0000005),
    'cross2': closeTo(-3, 0.0000005),
    'dist': closeTo(8.602325, 0.0000005),
    'distSq': closeTo(74.000000, 0.0000005),
    'dot': closeTo(-14.000000, 0.0000005),
    'len': closeTo(2.236068, 0.0000005),
    'lenSq': closeTo(5.000000, 0.0000005),
    'V': new Vector2Matcher(-1, 2),
    'W': new Vector2Matcher(4, -5),
    'L': new Vector2Matcher(8, -9),
    'set x': new Vector2Matcher(8, 2),
    'set y': new Vector2Matcher(-1, -9),
    'zero': new Vector2Matcher(0, 0),
    'abs': new Vector2Matcher(1.000000, 2.000000, 0.0000005),
    'add': new Vector2Matcher(3.000000, -3.000000, 0.0000005),
    'div': new Vector2Matcher(0.142857, -0.285714, 0.0000005),
    'mult': new Vector2Matcher(7.000000, -14.000000, 0.0000005),
    'neg': new Vector2Matcher(1.000000, -2.000000, 0.0000005),
    'norm': new Vector2Matcher(-0.447214, 0.894427, 0.0000005),
    'set len': new Vector2Matcher(3.130495, -6.260990, 0.0000005),
    'sub': new Vector2Matcher(-5.000000, 7.000000, 0.0000005),
  },
  // Corner cases
  {
    // equal vectors
    'v': new Vector2(-1, 2),
    'w': new Vector2(-1, 2),
    'eql': equals(true),
  },
  {
    // zero vector
    'v': new Vector2.zero(),
    'isZero': equals(true),
  },
  {
    // set length on zero vector (has no effect)
    'v': new Vector2.zero(),
    'f': 7,
    'set len': new Vector2Matcher(0, 0),
  },
  {
    // set length on vector to zero (for code coverage)
    'v': new Vector2(-1, 2),
    'f': 0,
    'set len': new Vector2Matcher(0, 0),
  }
];

main() {

  Tester tester = new Tester(data, getCopy);

  group('Vector2', () {

    tester.test0('new zero()', 'zero', () => new Vector2.zero() );
    tester.test1('absolute()', 'v', true, 'abs', (v) => v.absolute() );
    tester.test1('absolutize()', 'v', false, 'abs', (v) => v..absolutize() );
    tester.test1('setAbsoluteOf()', 'v', true, 'abs', (v) => new Vector2.zero()..setAbsoluteOf(v) );
    tester.test1('get dim', 'v', true, 'dim', (v) => v.dim );
    tester.test1('new ()', 'l', true, 'L', (l) => new Vector2(l[0], l[1]) );
    tester.test1('new fromIterable()', 'l', true, 'L', (l) => new Vector2.fromIterable(l) );
    tester.test1('new from()', 'w', true, 'W', (w) => new Vector2.from(w) );
    tester.test1('get x', 'v', true, 'get x', (v) => v.x );
    tester.test1('get y', 'v', true, 'get y', (v) => v.y );
    tester.test1('get hashCode', 'v', true, 'hash', (v) => v.hashCode );
    tester.test1('get isZero', 'v', true, 'isZero', (v) => v.isZero );
    tester.test1('setFromIterable()', 'l', true, 'L', (l) => new Vector2.zero()..setFromIterable(l) );
    tester.test1('setTo()', 'l', true, 'L', (l) => new Vector2.zero()..setTo(l[0], l[1]) );
    tester.test1('setFrom()', 'w', true, 'W', (w) => new Vector2.zero()..setFrom(w) );
    tester.test1('get length', 'v', true, 'len', (v) => v.length );
    tester.test1('get lengthSq', 'v', true, 'lenSq', (v) => v.lengthSquared );
    tester.test1('toList()', 'v', true, 'list', (v) => v.toList() );
    tester.test1('copyToList()', 'v', true, 'list', (v) => v.copyToList([0, 0]) );
    tester.test1('operator-', 'v', true, 'neg', (v) => -v );
    tester.test1('negate()', 'v', false, 'neg', (v) => v..negate() );
    tester.test1('setNegativeOf()', 'v', true, 'neg', (v) => new Vector2.zero()..setNegativeOf(v) );
    tester.test1('normal()', 'v', true, 'norm', (v) => v.normal() );
    tester.test1('normalize()', 'v', false, 'norm', (v) => v..normalize() );
    tester.test1('setNormalOf()', 'v', true, 'norm', (v) => new Vector2.zero()..setNormalOf(v) );
    tester.test1('setZero()', 'v', false, 'zero', (v) => v..setZero() );
    tester.test2('operator+()', 'v', 'w', true, true, 'add', (v, w) => v + w, );
    tester.test2('add()', 'v', 'w', false, true, 'add', (v, w) => v..add(w) );
    tester.test2('setAdditionOf()', 'v', 'w', true, true, 'add', (v, w) => new Vector2.zero()..setAdditionOf(v, w) );
    tester.test2('angleBetween()', 'v', 'w', true, true, 'ang', (v, w) => v.angleBetween(w) );
    tester.test2('crossed()', 'v', 'w', true, true, 'cross2', (v, w) => v.crossed(w) );
    tester.test2('distanceTo()', 'v', 'w', true, true, 'dist', (v, w) => v.distanceTo(w) );
    tester.test2('distanceToSquared()', 'v', 'w', true, true, 'distSq', (v, w) => v.distanceToSquared(w) );
    tester.test2('operator/()', 'v', 'f', true, false, 'div', (v, f) => v / f, );
    tester.test2('divide()', 'v', 'f', false, false, 'div', (v, f) => v..divide(f) );
    tester.test2('setDivisionOf()', 'v', 'f', true, false, 'div', (v, f) => new Vector2.zero()..setDivisionOf(v, f) );
    tester.test2('dot()', 'v', 'w', true, true, 'dot', (v, w) => v.dot(w) );
    tester.test2('operator==()', 'v', 'w', true, true, 'eql', (v, w) => v == w );
    tester.test2('set length', 'v', 'f', false, false, 'set len', (v, f) => v..length = f );
    tester.test2('operator*()', 'v', 'f', true, false, 'mult', (v, f) => v * f );
    tester.test2('scale()', 'v', 'f', false, false, 'mult', (v, f) => v..scale(f) );
    tester.test2('setScalingOf()', 'v', 'f', true, false, 'mult', (v, f) => new Vector2.zero()..setScalingOf(v, f) );
    tester.test2('rotated(s)', 'v', 'w', true, true, 'rot', (v, w) => v.rotated(w) );
    tester.test2('rotate(s)', 'v', 'w', false, true, 'rot', (v, w) => v..rotate(w) );
    //tester.test2('setRotationOf(v, s)', 'v', 'w', true, true, 'rot', (v, w) => new Vector2.zero()..setRotationOf(v, w) );
    tester.test2('set x', 'v', 'l', false, true, 'set x', (v, l) => v..x = l[0] );
    tester.test2('set y', 'v', 'l', false, true, 'set y', (v, l) => v..y = l[1] );
    tester.test2('set z', 'v', 'l', false, true, 'set z', (v, l) => v..z = l[2] );
    tester.test2('operator-()', 'v', 'w', true, true, 'sub', (v, w) => v - w );
    tester.test2('sub()', 'v', 'w', false, true, 'sub', (v, w) => v..subtract(w) );
    tester.test2('setSubtractionOf()', 'v', 'w', true, true, 'sub', (v, w) => new Vector2.zero()..setSubtractionOf(v, w) );

  });
}





