import 'package:vin_decoder/vin_decoder.dart';
import 'package:test/test.dart';

void main() {
  group('EU VIN Test', () {
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

  group('AS VIN Test', () {
    VIN vin;

    setUp(() {
      vin = VIN(number: 'JS1VX51L7X2175460');
    });

    test('Validity Test', () {
      expect(vin.valid(), isTrue);
    });

    test('AS Region Test', () {
      expect(vin.getRegion(), 'AS');
    });
  });
}
