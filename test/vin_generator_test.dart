import 'package:vin_decoder/vin_decoder.dart';
import 'package:test/test.dart';

void main() {
  group('VIN Generator Test', () {
    VINGenerator generator;
    VIN vin;

    setUp(() {
      generator = VINGenerator();
      vin = VIN(number: generator.generate());
    });

    test('Validity Test', () {
      expect(vin.valid(), isTrue);
    });
  });
}