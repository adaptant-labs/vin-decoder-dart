import 'package:vin_decoder/vin_decoder.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    VIN vin;

    setUp(() {
      vin = VIN(number: 'WP0ZZZ99ZTS392124');
    });

    test('Validity Test', () {
      expect(vin.valid(), isTrue);
    });

    test('Region Test', () {
      expect(vin.getRegion(), 'EU');
    });

    test('Manufacturer Test', () {
      expect(vin.getManufacturer(), 'Porsche');
    });
  });
}
