// Copyright (s) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library vector3_test;

import 'package:resource/resource.dart' as res show Resource;
import 'package:yaml/yaml.dart';

import 'test_blaster.dart';
import 'common.dart';

main() async {

  // Set up Testbaster for Vector3 testing
  TestBlaster testBlaster = new TestBlaster(copyTestInputs, equalityMatcher, vector3TestFunctions);

  // Open and read Vector 3 test data resource file
  var resource = new res.Resource('test/vector3.yaml');
  var rawData = loadYaml(await resource.readAsString());

  Iterable<Map> data = new TestDataMapper(testDataMappings).mapData(rawData);

  // Unleash the test blaster
  testBlaster.blastTests(data, 'Vector3&');
}


