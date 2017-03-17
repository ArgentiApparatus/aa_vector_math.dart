
import 'package:test/test.dart';


typedef dynamic TestFunc0();
typedef dynamic TestFunc1(var a);
typedef dynamic TestFunc2(var a, var b);
typedef dynamic GetCopy(var o);



class Tester {

  List<Map<String, dynamic>> data;

  GetCopy getCopy;

  Tester(this.data, this.getCopy);

  void test0(String name, var matcherKey, TestFunc0 func) {

    group(name, () {

      int i = 0;
      for(Map block in data) {

        if(block.containsKey(matcherKey)) {

          var result = func();
          Matcher matcher = block[matcherKey];
          test('test[$i]: correct operation result', () { expect(result, matcher); });


          i++;
        }
      }
    });
  }



  void test1(String name, var argKey, bool noMod, var matcherKey, TestFunc1 func) {

    group(name, () {

      int i = 0;
      for(Map block in data) {

        if(block.containsKey(matcherKey)) {

          if(!block.containsKey(argKey)) {
            throw 'Data block [$i] does not contain argument key \'$argKey\' required by test group \'name\'';
          }

          var arg = block[argKey];
          var copy = getCopy(arg);

          var result = func(copy);
          Matcher matcher = block[matcherKey];
          test('test[$i]: correct operation result', () { expect(result, matcher); });

          if(noMod) {
            test('test[$i]: arg not modified', () { expect(copy, equals(arg)); });
          }

          i++;
        }
      }
    });
  }


  void test2(String name, var argKey1, var argKey2, bool noMod1, bool noMod2, var matcherKey, TestFunc2 func) {

    group(name, () {

      int i = 0;
      for(Map block in data) {

        if(block.containsKey(matcherKey)) {

          if(!block.containsKey(argKey1)) {
            throw 'Data block [$i] does not contain argument key \'$argKey1\' required by test group \'name\'';
          }

          if(!block.containsKey(argKey2)) {
            throw 'Data block [$i] does not contain argument key \'$argKey2\' required by test group \'name\'';
          }

          var arg1 = block[argKey1];
          var copy1 = getCopy(arg1);

          var arg2 = block[argKey2];
          var copy2 = getCopy(arg2);

          var result = func(copy1, copy2);
          Matcher matcher = block[matcherKey];

          test('test[$i]: correct operation result', () { expect(result, matcher); });

          if(noMod1) {
            test('test[$i]: arg 1 not modified', () { expect(copy1, equals(arg1)); });
          }

          if(noMod2) {
            test('test[$i]: arg 2 not modified', () { expect(copy2, equals(arg2)); });
          }

          i++;
        }
      }
    });
  }
}

