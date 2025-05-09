import 'package:flutter_test/flutter_test.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  test('String test', () {
    var value = 'string';
    var expected = '';
    void logFunction(
      String prefix,
      dynamic value,
      String info, {
      bool isError = false,
    }) {
      expected = '$prefix $value $info'.trim();
    }

    value.printError(logFunction: logFunction);
    expect(expected, 'Error: String string');
  });
  test('Int test', () {
    var value = 1;
    var expected = '';
    void logFunction(
      String prefix,
      dynamic value,
      String info, {
      bool isError = false,
    }) {
      expected = '$prefix $value $info'.trim();
    }

    value.printError(logFunction: logFunction);
    expect(expected, 'Error: int 1');
  });
  test('Double test', () {
    var value = 1.0;
    var expected = '';
    void logFunction(
      String prefix,
      dynamic value,
      String info, {
      bool isError = false,
    }) {
      expected = '$prefix $value $info'.trim();
    }

    value.printError(logFunction: logFunction);
    expect(expected, 'Error: double 1.0');
  });
}
