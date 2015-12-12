// Copyright (c) 2015, Gary Smith. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of vector_math;

abstract class Vector {

  List<double> get components;
  
  int get numComponents;

  bool get isZero;

  double get length;

  double get lengthSquared;

}
