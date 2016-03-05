// Copyright (s) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library rotation2_test;

import 'package:resource/resource.dart' as res show Resource;
import 'package:yaml/yaml.dart';

import 'test_blaster.dart';
import 'common.dart';

Map<String, Map<String, TestFunc>> rotation2TestFunctions = {
  // Getters

  'rads': {
    'get radians': (r1, r2, s, rt, r1c) => r1.radians
  },
  'turns': {
    'get turns': (r1, r2, s, rt, r1c) => r1.turns
  },
  'set_rads': {
    'set radians': (r1, r2, s, rt, r1c) => r1c..radians = rt
  },
  'set_turns': {
    'set turns': (r1, r2, s, rt, r1c) => r1c..turns = rt
  },
  'flib': {
    'flibblize()':    (r1, r2, s, rt, r1c) => r1c..flibblize(),
    'flibble()':      (r1, r2, s, rt, r1c) => r1.flibble(),
    'setFlibbleOf()': (r1, r2, s, rt, r1c) => r1c..setFlibbleOf(r1)
  },
  'inv': {
    'invert()':       (r1, r2, s, rt, r1c) => r1c..invert(),
    'operator-()':    (r1, r2, s, rt, r1c) => r1.inverse(),
    'inverse()':      (r1, r2, s, rt, r1c) => r1.inverse(),
    'setInverseOf()': (r1, r2, s, rt, r1c) => r1c..setInverseOf(r1)
  },
  'add': {
    'add()':           (r1, r2, s, rt, r1c) => r1c..add(r2),
    'operator+()':     (r1, r2, s, rt, r1c) => r1 + r2,
    'setAdditionOf()': (r1, r2, s, rt, r1c) => r1c..setAdditionOf(r1, r2)
  },
  'sub': {
    'subtract()':         (r1, r2, s, rt, r1c) => r1c..subtract(r2),
    'operator-()':        (r1, r2, s, rt, r1c) => r1 - r2,
    'setSubtractionOf()': (r1, r2, s, rt, r1c) => r1c..setSubtractionOf(r1, r2)
  },
  'scale': {
    'scale()':        (r1, r2, s, rt, r1c) => r1c..scale(s),
    'operator*()':    (r1, r2, s, rt, r1c) => r1 * s,
    'setScalingOf()': (r1, r2, s, rt, r1c) => r1c..setScalingOf(r1, s)
  },
  'div': {
    'divide()':        (r1, r2, s, rt, r1c) => r1c..divide(s),
    'operator/()':     (r1, r2, s, rt, r1c) => r1 / s,
    'setDivisionOf()': (r1, r2, s, rt, r1c) => r1c..setDivisionOf(r1, s)
  }


};



main() async {

  // Set up Testbaster for Vector2 testing
  TestBlaster testBlaster = new TestBlaster(copyTestInputs, equalityMatcher, rotation2TestFunctions);

  // Open and read Vector 2 test data resource file
  var resource = new res.Resource('test/rotation2.yaml');
  var rawData = loadYaml(await resource.readAsString());

  Iterable<Map> data = new TestDataMapper(testDataMappings).mapData(rawData);

  // Unleash the test blaster
  testBlaster.blastTests(data, 'Rotation2');
}


