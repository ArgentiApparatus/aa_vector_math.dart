# aa_vectors.dart - Argenti Apparatus's Vectors

A vector and matrix math library for 2D and 3D applications.

[Github Page](https://github.com/argentiapparatus/aa_vectors.dart)

## Features

* Vectors
* Vector lists
* Affine transformations
* Projection transformations
* OpenGL friendliness

### Currently Implemented
* 2D and 3D vectors
* 2D rotation

### Currently Unimplemented
* Everything else

## Using aa_vectors.dart

### Dependencies:

aa_vectors.dart is not (yet) available on Pub and must be had from Github.

To get the latest commited version (which may or may not be broken): 

In your `pubspec.yaml`:

```yaml
dependencies:
  vector_math:
    git: https://github.com/argentiapparatus/aa_vectors.dart.git
```
To get a specific release, tag or branch (which may or may not be broken): 

```yaml
dependencies:
  vector_math:
    git: https://github.com/argentiapparatus/aa_vectors.dart.git
    ref: some-identifer
```
See the [aa_vectors.dart Github page](https://github.com/argentiapparatus/aa_vectors.dart)
to find release, tags and branches.

See [Pub Dependencies - Github Packages](https://www.dartlang.org/tools/pub/dependencies.html#git-packages)
for more details.

### Imports:

```dart
import 'package:aa_vectors/vectors.dart';
import 'package:aa_vectors/vector_lists.dart';
import 'package:aa_vectors/opengl.dart';
```

## Documentation

*TODO*


## Credits

aa_vectors.dart was inspired by John McCutchan's / Google's
[vector_math.dart](https://github.com/google/vector_math.dart) library.

Vector and vector list classes were drawn directly from vector&#95;math.dart.
However, the class APIs have been heavily reworked in an effort to adhere more
closely to up-to-date Dart practices.
(see [Effective Dart](https://www.dartlang.org/effective-dart/)),
and also as an excercise in API design for the author. Method implementations
(i.e., the hard parts) are largely unchanged from those found in
vector&#95;math.dart.

aa_vectors.dart features rotation and perspective classes instead of general
matrices, quaternions etc. The required math implementations are again drawn
from vector&#95;math.dart.







