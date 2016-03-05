// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library common;

import 'dart:typed_data';
import 'package:test/test.dart' as tst;
import 'package:aa_vectors/vectors.dart';
import 'test_blaster.dart';


/// Matcher for matching vectors etc.
///
/// Examines underlying components, does not rely on equality opertov1c.
/// Applies [closeTo] matcher with [delta] to test object components.
class HyperMatcher extends tst.Matcher {

  final Type type;
  final List<num> values;
  final num delta;

  /// Match a [Vector2].
  HyperMatcher.vector2(num x, num y, [this.delta = 0]):
    type = Vector2,
    values = [x, y],
    super();

  /// Match a [Vector3].
  HyperMatcher.vector3(num x, num y, num z, [this.delta = 0]):
    type = Vector3,
    values = [x, y, z],
    super();

  /// Match a [Rotation2].
  HyperMatcher.rotation2(num r, [this.delta = 0]):
    type = Rotation2,
    values = [r],
    super();

  tst.Description describe(tst.Description description) =>
    description.add('$type:<$values> +/- $delta');

  bool matches(dynamic actual, Map matchState) {
    if(actual.runtimeType != type) {
      return false;
    } else {
      int i = 0;
      List components = actual.asList();
      return values.fold(true, (prev, value) => prev && tst.closeTo(value, delta).matches(components[i++], matchState));
    }
  }
}



/// Canned test data mappings for Vectors etc.
///
/// - Input mappings:
///   -'v3' → Vector3(x, y, z)
///   -'v2' → Vector3(x, y)
///   -'s'  → num
///   -'l'  → List
/// - Expected mappings:
///   -'v3' → HyperMatcher.vector3(x, y, z, d)
///   -'v3' → HyperMatcher.vector2(x, y, d)
///   -'s'  → (Matcher) closeTo(s, d)
///   -'b'  → (Matcher) equals(b)
///   -'l'  → (Matcher) orderedEquals(l)
///
Map<String, Map<String, Function>> testDataMappings = {
  'inputs': {
    'v3': (map) => new Vector3(map['x'], map['y'], map['z']),
    'v2': (map) => new Vector2(map['x'], map['y']),
    'r2': (map) => new Rotation2(map['r']),
    'n':  (map) => map['n'],
    'l':  (map) => map['l']
  },
  'matchers': {
    'v3': (map) => new HyperMatcher.vector3(map['x'], map['y'], map['z'], ifNullZero(map['d'])),
    'v2': (map) => new HyperMatcher.vector2(map['x'], map['y'], ifNullZero(map['d'])),
    'r2': (map) => new HyperMatcher.rotation2(map['r'], ifNullZero(map['d'])),
    'n':  (map) => tst.closeTo(map['n'], ifNullZero(map['d'])),
    'b':  (map) => tst.equals(map['b']),
    'l':  (map) => tst.orderedEquals(map['l'].map((v)=>v.toDouble()))
  }
};

num ifNullZero(num n) => n != null ? n : 0;


/// Canned map of test functions for Vector3 and Vector2.
///
/// Expects `v1` to be Vector
/// Expects `v2` to be Vector
/// Expects `s` to be num
/// Expects `l` to be Iterable<num>
Map<String, Map<String, TestFunc>> commonTestFunctions = {

  // Getters

  'x': {
    'get x': (v1, v2, s, l, v1c) => v1.x
  },
  'y': {
    'get y': (v1, v2, s, l, v1c) => v1.y
  },
  'asList': {
    'asList()': (v1, v2, s, l, v1c) => v1.asList(),
    'asFloat64List()': (v1, v2, s, l, v1c) => v1.asFloat64List()
  },
  'lenSq': {
    'get lengthSq': (v1, v2, s, l, v1c) => v1.lengthSquared
  },
  'len': {
    'get length': (v1, v2, s, l, v1c) => v1.length
  },
  'numComp': {
    'get numComponents': (v1, v2, s, l, v1c) => v1.numComponents
  },
  'isZero': {
    'get isZero': (v1, v2, s, l, v1c) => v1.isZero
  },

  // Operations resulting in vectors

  'abs': {
    'absolutize()':    (v1, v2, s, l, v1c) => v1c..absolutize(),
    'absolute()':      (v1, v2, s, l, v1c) => v1.absolute(),
    'setAbsoluteOf()': (v1, v2, s, l, v1c) => v1c..setAbsoluteOf(v1)
  },
  'neg': {
    'negate()':        (v1, v2, s, l, v1c) => v1c..negate(),
    'operator-':       (v1, v2, s, l, v1c) => -v1,
    'setNegativeOf()': (v1, v2, s, l, v1c) => v1c..setNegativeOf(v1)
  },
  'norm': {
    'normalize()':   (v1, v2, s, l, v1c) => v1c..normalize(),
    'normal()':      (v1, v2, s, l, v1c) => v1.normal(),
    'setNormalOf()': (v1, v2, s, l, v1c) => v1c..setNormalOf(v1)
  },
  'add': {
    'add()':           (v1, v2, s, l, v1c) => v1c..add(v2),
    'operator+()':     (v1, v2, s, l, v1c) => v1 + v2,
    'setAdditionOf()': (v1, v2, s, l, v1c) => v1c..setAdditionOf(v1, v2)
  },
  'sub': {
    'sub()':              (v1, v2, s, l, v1c) => v1c..subtract(v2),
    'operator-()':        (v1, v2, s, l, v1c) => v1 - v2,
    'setSubtractionOf()': (v1, v2, s, l, v1c) => v1c..setSubtractionOf(v1, v2)
  },
  'mult': {
    'scale()':        (v1, v2, s, l, v1c) => v1c..scale(s),
    'operator*()':    (v1, v2, s, l, v1c) => v1 * s,
    'setScalingOf()': (v1, v2, s, l, v1c) => v1c..setScalingOf(v1, s)
  },
  'div': {
    'divide()':        (v1, v2, s, l, v1c) => v1c..divide(s),
    'operator/()':     (v1, v2, s, l, v1c) => v1 / s,
    'setDivisionOf()': (v1, v2, s, l, v1c) => v1c..setDivisionOf(v1, s)
  },
  'setLen': {
    'set length': (v1, v2, s, l, v1c) { v1c.length = s; return v1c; }
  },

  // Operations resulting in scalars

  'distSq': {
    'distanceToSquared()': (v1, v2, s, l, v1c) => v1.distanceToSquared(v2)
  },
  'dist': {
    'distanceTo()': (v1, v2, s, l, v1c) => v1.distanceTo(v2)
  },
  'dot': {
    'dot()': (v1, v2, s, l, v1c) => v1.dot(v2)
  },
  'ang': {
    'angleBetween()': (v1, v2, s, l, v1c) => v1.angleBetween(v2)
  },

  // Equality

  'eq': {
    'operator==': (v1, v2, s, l, v1c) => v1 == v2
  },
};



Map<String, Map<String, TestFunc>> vector2TestFunctions = {

  // Constructors and setters

  'zero': {
    'new Vector2.zero()': (v1, v2, s, l, v1c) => new Vector2.zero(),
    'setZero()': (v1, v2, s, l, v1c) => v1c..setZero()
  },
  'all': {
    'new Vector2.all()': (v1, v2, s, l, v1c) => new Vector2.all(s),
    'setAll()': (v1, v2, s, l, v1c) => v1c..setAll(s)
  },
  'components': {
    'new Vector2()': (v1, v2, s, l, v1c) => new Vector2(l[0], l[1]),
    'setTo()': (v1, v2, s, l, v1c) => v1c..setTo(l[0], l[1])
  },
  'from2': {
    'new Vector2.from2()': (v1, v2, s, l, v1c) => new Vector2.from2(v2),
    'setFrom2()': (v1, v2, s, l, v1c) => v1c..setFrom2(v2)
  },
  'from3': {
    'new Vector2.from3()': (v1, v2, s, l, v1c) => new Vector2.from3(new Vector3.fromIterable(l)),
    'setFrom3()': (v1, v2, s, l, v1c) => v1c..setFrom3(new Vector3.fromIterable(l))
  },
  'fromList': {
    'new Vector2.fromIterable()': (v1, v2, s, l, v1c) => new Vector2.fromIterable(l),
    'new Vector2.view()': (v1, v2, s, l, v1c) => new Vector2.view(new Float64List.fromList(new List.from(l.map((v) => v.toDouble()))).buffer),

  },
  'set': {

    'set x, y': (v1, v2, s, l, v1c) {
      v1c.x = l[0];
      v1c.y = l[1];
      return v1c;
    },

    'setFromIterable()': (v1, v2, s, l, v1c) => v1c..setFromIterable(l),

    'Modify view': (v1, v2, s, l, v1c) {
       Float64List data = new Float64List(2);
       Vector2 v = new Vector2.view(data.buffer);
       data[0] = l[0].toDouble();
       data[1] = l[1].toDouble();
       return v;
    },

    'Modify list from asList()': (v1, v2, s, l, v1c) {
      List data = v1c.asList();
       data[0] = l[0].toDouble();
       data[1] = l[1].toDouble();
       return v1c;
    },

    'Modify list from asFloat64List()': (v1, v2, s, l, v1c) {
      Float64List data = v1c.asFloat64List();
       data[0] = l[0].toDouble();
       data[1] = l[1].toDouble();
       return v1c;
    }
  },


  // Operations

  'cross2Len': {
    'cross2Length()': (v1, v2, s, l, v1c) => v1.cross2Length(v2)
  }

}..addAll(commonTestFunctions);



Map<String, Map<String, TestFunc>> vector3TestFunctions = {

  // Getters

  'z': {
    'get z': (v1, v2, s, l, v1c) => v1.z
  },

  // Constructors and setters

  'zero': {
    'new Vector3.zero()': (v1, v2, s, l, v1c) => new Vector3.zero(),
    'setZero()': (v1, v2, s, l, v1c) => v1c..setZero()
  },
  'all': {
    'new Vector3.all()': (v1, v2, s, l, v1c) => new Vector3.all(s),
    'setAll()': (v1, v2, s, l, v1c) => v1c..setAll(s)
  },
  'components': {
    'new Vector3()': (v1, v2, s, l, v1c) => new Vector3(l[0], l[1], l[2]),
    'setTo()': (v1, v2, s, l, v1c) => v1c..setTo(l[0], l[1], l[2])
  },
    'from2': {
    'new Vector3.from2()': (v1, v2, s, l, v1c) => new Vector3.from2(new Vector2.fromIterable(l), l[2]),
    'setFrom2()': (v1, v2, s, l, v1c) => v1c..setFrom2(new Vector2.fromIterable(l), l[2])
  },
  'from3': {
    'new Vector3.from3()': (v1, v2, s, l, v1c) => new Vector3.from3(v2),
    'setFrom3()': (v1, v2, s, l, v1c) => v1c..setFrom3(v2)
  },
  'fromList': {
    'new Vector3.fromIterable()': (v1, v2, s, l, v1c) => new Vector3.fromIterable(l),
    'new Vector2.view()': (v1, v2, s, l, v1c) => new Vector3.view(new Float64List.fromList(new List.from(l.map((v) => v.toDouble()))).buffer),
  },
  'set': {

    'set x, y, z': (v1, v2, s, l, v1c) {
      v1c.x = l[0];
      v1c.y = l[1];
      v1c.z = l[2];
      return v1c;
    },

    'setFromIterable()': (v1, v2, s, l, v1c) => v1c..setFromIterable(l),

    'Modify view': (v1, v2, s, l, v1c) {
       Float64List data = new Float64List(3);
       Vector3 v = new Vector3.view(data.buffer);
       data[0] = l[0].toDouble();
       data[1] = l[1].toDouble();
       data[2] = l[2].toDouble();
       return v;
    },

    'Modify list from asList()': (v1, v2, s, l, v1c) {
      List data = v1c.asList();
       data[0] = l[0].toDouble();
       data[1] = l[1].toDouble();
       data[2] = l[2].toDouble();
       return v1c;
    },

    'Modify list from asFloat64List()': (v1, v2, s, l, v1c) {
      Float64List data = v1c.asFloat64List();
       data[0] = l[0].toDouble();
       data[1] = l[1].toDouble();
       data[2] = l[2].toDouble();
       return v1c;
    }
  },

  // Operations

  'cross2': {
    'cross2()': (v1, v2, s, l, v1c) => v1.cross2(v2),
    'setCross2Of()': (v1, v2, s, l, v1c) => v1c..setCross2of(v1, v2)
  },
  'cross3': {
    'cross3()': (v1, v2, s, l, v1c) => v1.cross(v2),
    'setCross3Of()': (v1, v2, s, l, v1c) => v1c..setCross3of(v1, v2)
  }

}..addAll(commonTestFunctions);



/// Copies input values used in tests
dynamic copyTestInputs(dynamic value) {

  if(value is Iterable) {
    return new List.from(value);
  }
  else if(value is Vector2) {
    return new  Vector2.from2(value);
  }
  else if(value is Vector3) {
    return new  Vector3.from3(value);
  }
  else {
    return value;
  }
}



/// Provides equality [Matcher]s for tests`
tst.Matcher equalityMatcher(dynamic expected) {

  if(expected is Iterable) {
    return tst.orderedEquals(expected);
  }
  else if(expected is Vector2) {
    return new  HyperMatcher.vector2(expected.x, expected.y);
  }
  else if(expected is Vector3) {
    return new  HyperMatcher.vector3(expected.x, expected.y, expected.z);
  }
  else {
    return tst.equals(expected);
  }
}