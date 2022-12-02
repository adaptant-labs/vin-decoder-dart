import 'package:custom_vin_decoder/vin_decoder.dart';
import 'package:test/test.dart';

void main() {
  group('EU VIN Test', () {
    final vin = VIN(number: 'WP0ZZZ99ZTS392124');

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
    final vin = VIN(number: 'JS1VX51L7X2175460');

    test('Validity Test', () {
      expect(vin.valid(), isTrue);
    });

    test('AS Region Test', () {
      expect(vin.getRegion(), 'AS');
    });
  });

  group('2-character WMI Manufacturer Test', () {

    late VIN vin;

    setUp(() {
      // Here the first 2 characters refer to the manufacturer, with the 3rd
      // representing the class of vehicle specific to that manufacturer.
      vin = VIN(number: '5TENL42N94Z436445');
    });

    test('Validity Test', () {
      expect(vin.valid(), isTrue);
    });

    test('Region Test', () {
      expect(vin.getRegion(), 'NA');
    });

    test('Manufacturer Test', () {
      expect(vin.getManufacturer(), 'Toyota - trucks');
    });
  });
}
