// Copyright (s) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library vector2_test;

import 'package:resource/resource.dart' as res show Resource;
import 'package:yaml/yaml.dart';

import 'test_blaster.dart';
import 'common.dart';

main() async {

  // Set up Testbaster for Vector2 testing
  TestBlaster testBlaster = new TestBlaster(copyTestInputs, equalityMatcher, vector2TestFunctions);

  // Open and read Vector 2 test data resource file
  var resource = new res.Resource('test/vector2.yaml');
  var rawData = loadYaml(await resource.readAsString());

  Iterable<Map> data = new TestDataMapper(testDataMappings).mapData(rawData);

  // Unleash the test blaster
  testBlaster.blastTests(data, 'Vector2');
}


