import 'package:custom_vin_decoder/vin_decoder.dart';
import 'package:test/test.dart';

void main() {
  group('VIN Generator Test', () {
    VINGenerator generator;
    late VIN vin;

    setUp(() {
      generator = VINGenerator();
      vin = VIN(vin: generator.generate());
    });

    test('Validity Test', () {
      expect(vin.valid(), isTrue);
    });
  });
}
