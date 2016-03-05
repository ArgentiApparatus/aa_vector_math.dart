// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


library test_blaster;

import 'package:test/test.dart' as tst;


///
///
typedef dynamic TestFunc(dynamic a, dynamic b, dynamic c, dynamic d, dynamic r);



/// Utility for testing classes that represent a 'type' such as a
/// vector that have many relatively simple operation methods.
///
/// Supports:
/// - Unary operations: `a.op()`
/// - Binary operations on objects of same type: `a.op(b)`, `a + b`
/// - Binary operations on object and [num] `a.op(n)`, `a * n`
///
/// [prog] property:
///
/// Tests are 'programmed' with a nested map of functions like this:
///
///     {
///       'add': {
///         'add()':     (a, b, s, r) => r.add(b),
///         '+operator': (a, b, s, r) => a * b,
///         ...
///       },
///       'scale': {
///         'scale()':   (a, b, s, r) => r.scale(s),
///         '*operator': (a, b, s, r) => a * b,
///         ...
///       },
///       ...
///     }
///
/// Functions in each group must produce identical results.
///
/// Each function will be passed:
///
/// - `a`: instance of class under test
/// - `b`: another instance of class under test
/// - `s`: a [num]
/// - `r`: copy of a
///
/// The function should execute a method using `a` (or `r`), `b` or `s`.
///
/// If the method returns a new value: return it, e.g.:
///
///     (a, b, s, r) => a + b
///
/// If the method modifies an input: perform it on `r` and return `r`
/// e.g.:
///
///     (a, b, s, r) => r.add(b)
///
///
/// `a` and `b` *must not* be explicitly modified as these will be
/// checked to verify the method under test does not modify its inputs.
///
/// Test data is a list of 'blocks' comprised of inputs values `a`, `b`
/// and `s` an a map of [Matcher]s.
///
///     [
///       {
///         'inputs': {
///           'a': <Vector>,
///           'b': <Vector>,
///           's': <num>
///         },
///         'matchers': {
///           'add':   <Vector Matcher>,
///           'scale': <Vector Matcher>,
///           'dot':   <num Matcher>,
///           ...
///         }
///       },
///       ...
///     ]
///
/// The [testMap] is executed with supplied test data. Each group of
/// tests is executed inside of a unit test `group()`, each test
/// function isexecuted inside of a unit test `test()`.
///
/// Each group is executed at most once, using data from all test data
/// blocks. If there is no matcher data for a group in any test
/// data block the group is not executed. This means it is possible
/// to define tests for many methods then execute tests for fewer
/// methods separately.
///
/// If there is no test function group for a matcher in the test data,
/// that matcher is ignored.
///
/// In addition to the result of each test operation being tested
/// against the appropriate matcher, the `a` and `b` values are tested
/// to ensure they are not modified. If an method being tested
/// modifies its inputs the test fails.
///
/// TODO copyStuff, matcherStuff
class TestBlaster {

  Function copierFunction;
  Function matcherFunction;
  Map<String, Map<String, TestFunc>> prog;

  TestBlaster(this.copierFunction, this.matcherFunction, this.prog);

  void _expectEquality(dynamic v, dynamic e) {
    tst.expect(v, matcherFunction(e), reason:'An input was modified');
  }

  void blastTests(Iterable<Map<String, Map>> data, String group) {

    tst.group('$group:', () {

      for(String innerGroup in prog.keys) {

        Iterable<Map<String, Map>> filtered = data.where((Map<String, Map> block) {
          return block['matchers'].containsKey(innerGroup);
        });

        if(filtered.isNotEmpty) {

          tst.group('$innerGroup:', () {

            Map<String, TestFunc> tests = prog[innerGroup];

            for(String testName in tests.keys) {

              Function func = tests[testName];

              tst.test(testName, () {

                for(Map<String, Map<String, dynamic>> block in filtered) {

                  tst.Matcher matcher = block['matchers'][innerGroup];

                  if(matcher != null) {

                    Map<String, dynamic> inputs = block['inputs'];

                    var a = copierFunction(inputs['a']);
                    var b = copierFunction(inputs['b']);
                    var c = copierFunction(inputs['c']);
                    var d = copierFunction(inputs['d']);
                    var r = copierFunction(a);

                    var aa = copierFunction(a);
                    var bb = copierFunction(b);
                    var cc = copierFunction(c);
                    var dd = copierFunction(d);

                    var got = func(a, b, c, d, r);

                    tst.expect(got, matcher, reason:'Incorrect result');

                    _expectEquality(a, aa);
                    _expectEquality(b, bb);
                    _expectEquality(c, cc);
                    _expectEquality(d, dd);
                  }
                }
              });
            }
          });
        }
      }
    });
  }
}


/// Converts data obtained by loading JSON, YAML etc. to an map of
/// data suitable for consumption by a [TestBlaster].
///
/// Takes list of nested maps like this:
///
///    [
///      {
///        'inputs': {
///          'a': { 't':'v2', 'x':1, 'y':2 },
///          'b': { 't':'v2', 'x':3, 'y':4 },
///          's': { 't':'s',  's':5 }
///        },
///        'matchers': {
///          'add':   { 't':'v2', 'x':4, 'y':5  },
///          'scale': { 't':'v2', 'x':5, 'y':10 },
///          'dot':   { 't':'s',  's':11 },
///          ...
///        }
///      },
///      ...
///    ]
///
/// Creates an iterable of new maps replacing the maps of object
/// properties with objects, using a map of converter functions like
/// this:
///
///    {
///      'inputs': {
///        'v2': (m) => new Vector2(m['x'], m['y']),
///        's':  (m) => map['s']
///        ...
///      },
///      'matchers': {
///        'v2': (m) => new HyperMatcher.vector2(m['x'], m['y'], m['d']),
///        's':  (m) => closeTo(m['s'], m['d'])
///        ...
///      }
///    }
///
/// *Input* functions produce objects, *matchers* functions produce
/// Matchers. the *t* value of an object property map tells the mapper
/// which functions to invoke.
///
class TestDataMapper {

  final Map<String, Map<String, Function>> mappings;

  TestDataMapper(this.mappings);

  Iterable<Map> mapData(List<Map> data) {

    return data.map((block) {

      Map<String, dynamic> out = new Map<String, Map>();

      for(String mappingName in mappings.keys) {

        Map<String, Function> mapping = mappings[mappingName];
        Map<String, Map> chunk = block[mappingName];
        Map<String, dynamic> transformed = new Map<String, dynamic>();

        if(chunk != null) {
          for(String key in chunk.keys) {
            Function transformer = mapping[chunk[key]['t']];
            if(transformer != null) {
              transformed[key] = transformer(chunk[key]);
            }
          }
        }

        out[mappingName] = transformed;
      }

      return out;
    });
  }
}


