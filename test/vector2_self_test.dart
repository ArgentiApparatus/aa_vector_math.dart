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
    'eql vv': equals(true),
    'ang vv': equals(0),
    'cross2 vv': equals(0),
    'dist vv': equals(0),
    'distSq vv': equals(0),
    'dot vv': equals(5),
    'abs vv': new Vector2Matcher(1, 2),
    'add vv': new Vector2Matcher(-2, 4),
    'add vw': new Vector2Matcher(3, -3),
    'add wv': new Vector2Matcher(8, -10),  // Note: not correct addition result, but expected outcome
    'div vv': new Vector2Matcher(0.142857, -0.285714, 0.0000005),
    'mult vv': new Vector2Matcher(7, -14),
    'neg vv': new Vector2Matcher(1, -2),
    'norm vv': new Vector2Matcher(-0.447214, 0.894427, 0.0000005),
    'sub vv': new Vector2Matcher(0, 0),
    'sub vw': new Vector2Matcher(-5, 7),
    'sub wv': new Vector2Matcher(0, -0), // Note: not correct subtraction result, but expected outcome
  },
];

main() {

  Tester tester = new Tester(data, getCopy);

  // Vector operations where self can be supplied as an argument
  group('Vector2 self', () {

    tester.test1('v.setAbsoluteOf(v)', 'v', false, 'abs vv', (v) => v..setAbsoluteOf(v) );
    tester.test1('v.setFrom(v)', 'v', false, 'V', (v) => v..setFrom(v) );
    tester.test1('v.setNegativeOf(v)', 'v', false, 'neg vv', (v) => v..setNegativeOf(v) );
    tester.test1('v.setNormalOf(v)', 'v', false, 'norm vv', (v) => v..setNormalOf(v) );
    tester.test1('v.operator+(v)', 'v', false, 'add vv', (v) => v + v, );
    tester.test1('v.add(v)', 'v', false, 'add vv', (v) => v..add(v) );
    tester.test1('v.angleBetween(v)', 'v', false, 'ang vv', (v) => v.angleBetween(v) );
    tester.test1('v.crossed(v)', 'v', false, 'cross2 vv', (v) => v.crossed(v) );
    tester.test1('v.distanceTo(v)', 'v', false, 'dist vv', (v) => v.distanceTo(v) );
    tester.test1('v.distanceToSquared(v)', 'v', false, 'distSq vv', (v) => v.distanceToSquared(v) );
    tester.test1('v.dot(v)', 'v', false, 'dot vv', (v) => v.dot(v) );
    tester.test1('v.operator==(v)', 'v', false, 'eql vv', (v) => v == v );
    tester.test1('v.sub(v)', 'v', false, 'sub vv', (v) => v..subtract(v) );
    tester.test2('v.setDivisionOf(v, f)', 'v', 'f', false, false, 'div vf', (v, f) => v..setDivisionOf(v, f) );
    tester.test2('v.setScalingOf(v, f)', 'v', 'f', false, false, 'mult vf', (v, f) => v..setScalingOf(v, f) );
    tester.test2('v.setAdditionOf(v, w)', 'v', 'w', false, false, 'add vw', (v, w) => v..setAdditionOf(v, w) );
    tester.test2('v.setAdditionOf(w, v)', 'w', 'v', true, false, 'add wv', (w, v) => v..setAdditionOf(w, v) );
    tester.test1('v.setAdditionOf(v, v)', 'v', false, 'add vv', (v) => v..setAdditionOf(v, v) );
    tester.test2('v.setSubtractionOf(v, w)', 'v', 'w', false, false, 'sub vw', (v, w) => v..setSubtractionOf(v, w) );
    tester.test2('v.setSubtractionOf(w, v)', 'w', 'v', false, false, 'sub wv', (w, v) => v..setSubtractionOf(w, v) );
    tester.test1('v.setSubtractionOf(v, v)', 'v', false, 'sub vv', (v) => v..setSubtractionOf(v, v) );
  });
}





