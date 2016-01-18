// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// OpenGL add-ons

library opengl;

import 'dart:math';
import 'dart:typed_data';
import 'package:aa_vector_math/vector_math.dart';


class Projection2 {} 

/// 3x3 Matrix data suitable for OpenGl
Float64List modelMatrix(Transformation2 model) {
  return null;
}

/// 3x3 Matrix data suitable for OpenGl
Float64List viewModelMatrix(Transformation2 model, Transformation2 view) {
  return null;
}

/// 3x3 Matrix data suitable for OpenGl
Float64List viewModelProjectionMatrix(Transformation2 model, Transformation2 view, Projection2 projection) {
  return null;
}

