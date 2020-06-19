import 'dart:math';
import 'package:random_string/random_string.dart';
import 'manufacturers.dart';
import 'year_map.dart';

// VINs do not use the letters O, I, or Q to avoid confusion with numbers
const _vinChars = "ABCDEFGHJKLMNPRSTUVWXYZ0123456789";

class VINGenerator {
  var _random = Random();

  /// Generate a random (valid) WMI
  String generateWmi() {
    var wmi =
        manufacturers.keys.elementAt(_random.nextInt(manufacturers.length));

    // If the manufacturer produces less than 500 vehicles/year, the 3rd digit
    // of the WMI must be 9.
    if (wmi.length == 2) {
      wmi += '9';
    }

    return wmi;
  }

  /// Generate a random (valid) VIS using a valid model year followed by a
  /// default assembly plant definition (A) and a random production sequence
  /// number.
  String generateVis() {
    return yearMap.keys.elementAt(_random.nextInt(yearMap.length)) +
        'A' +
        randomNumeric(6).toString();
  }

  String generateVds() {
    var randomVds = String.fromCharCodes(Iterable.generate(
        5, (_) => _vinChars.codeUnitAt(_random.nextInt(_vinChars.length))));

    // Random check digit
    randomVds += _random.nextInt(10).toString();

    return randomVds;
  }

  /// Generate a random VIN
  String generate() {
    return generateWmi() + generateVds() + generateVis();
  }
}
