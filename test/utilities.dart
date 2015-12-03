// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library test_utilities;

import 'package:test/test.dart';

import 'package:aa_vector_math/vector_math.dart';



class CloseToVector2 extends Matcher {

  Vector2 expected;
  Matcher xm, ym;

  CloseToVector2(num x, num y, num delta): 
    expected = new Vector2.components(x.toDouble(), y.toDouble()),
    xm = closeTo(x, delta),
    ym = closeTo(y, delta),
    super();

  Description describe(Description description) =>
    description.add('$expected');

  bool matches(Vector2 actual, Map matchState) => 
    xm.matches(actual.x, matchState) && 
    ym.matches(actual.y, matchState); 
}

CloseToVector2 closeToVector2(num x, num y, num delta) => new CloseToVector2(x, y, delta);



class CloseToVector3 extends Matcher {

  Vector3 expected;
  Matcher xm, ym, zm;

  CloseToVector3(num x, num y, num z, num delta): 
    expected = new Vector3.components(x.toDouble(), y.toDouble(), z.toDouble()),
    xm = closeTo(x, delta),
    ym = closeTo(y, delta),
    zm = closeTo(z, delta),
    super();

  Description describe(Description description) =>
    description.add('Approximately $expected');

  bool matches(Vector3 actual, Map matchState) =>
    xm.matches(actual.x, matchState) &&
    ym.matches(actual.y, matchState) &&
    zm.matches(actual.z, matchState); 
}

CloseToVector3 closeToVector3(num x, num y, num z, num delta) => new CloseToVector3(x, y, z, delta);


class CloseToVector4 extends Matcher {

  Vector4 expected;
  Matcher xm, ym, zm, wm;

  CloseToVector4(num x, num y, num z, num w, num delta): 
    expected = new Vector4.components(x.toDouble(), y.toDouble(), z.toDouble(), w.toDouble()),
    xm = closeTo(x, delta),
    ym = closeTo(y, delta),
    zm = closeTo(z, delta),
    wm = closeTo(w, delta),
    super();

  Description describe(Description description) =>
    description.add('Approximately $expected');

  bool matches(Vector4 actual, Map matchState) =>
    xm.matches(actual.x, matchState) &&
    ym.matches(actual.y, matchState) &&
    zm.matches(actual.z, matchState) &&
    wm.matches(actual.w, matchState); 
}

CloseToVector4 closeToVector4(num x, num y, num z, num w, num delta) => new CloseToVector4(x, y, z, w, delta);
