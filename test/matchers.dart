import 'package:test/test.dart';

import 'package:aa_vectors/vector2.dart';


class Vector2Matcher extends Matcher {

  num x, y, delta;

  Vector2Matcher(this.x, this.y, [num delta]): this.delta = delta!=null ? delta : 0;

  Description describe(Description desc) => desc.add('Vector2:<[$x+/-$delta, $y+/-$delta]>');

  bool matches(dynamic actual, Map matchState) {
    if(actual is Vector2) {
      if(closeTo(x, delta).matches(actual.x, matchState) && closeTo(y, delta).matches(actual.y, matchState)) {
        return true;
      }
    }
    return false;
  }
}

