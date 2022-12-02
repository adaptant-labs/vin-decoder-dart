import 'package:basic_utils/basic_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// NHTSA Results not relevant for a specific vehicle can be either null or N/A
const String _RESULT_NOT_APPLICABLE = 'Not Applicable';

// ignore: avoid_classes_with_only_static_members
/// A wrapper for the NHTSA REST API
class NHTSA {
  static const String _uriBase = 'https://vpic.nhtsa.dot.gov/api/vehicles';

  /// Obtain information about a given [vin] from the NHTSA DB.
  static Future<NHTSAVehicleInfo?> decodeVin(String vin) async {
    var path = _uriBase + '/DecodeVin/' + vin + '?format=json';
    final response = await http.get(Uri.parse(path));

    if (response.statusCode == 200) {
      return NHTSAVehicleInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }

    return null;
  }

  /// Obtain a map of key/value pairs containing known values for a given [vin]
  static Future<Map<String, dynamic>?> decodeVinValues(String vin) async {
    var path = _uriBase + '/DecodeVinValues/' + vin + '?format=json';
    final response = await http.get(Uri.parse(path));

    // The DecodeVinValues endpoint returns a single Results object with all
    // variables and values as an array of encapsulated key/value pairs.
    // Manually unpack this in order to provide the caller a populated Dart map.
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      final Map<String, dynamic> map = data['Results'][0] as Map<String, dynamic>;
      // Discard empty and not applicable entries from map
      map.removeWhere((key, value) =>
          value == null || value == _RESULT_NOT_APPLICABLE || value == '');
      return map;
    }

    return null;
  }
}

/// The result of a single data point from the NHTSA DB for a specific variable.
class NHTSAResult {
  /// The value associated with a given [variable] or [variableId]
  String? value;

  /// The ID number associated with a given [value]
  String? valueId;

  /// The variable name
  String? variable;

  /// The ID number of a given [variable]
  int? variableId;

  NHTSAResult({required this.value, required this.valueId, required this.variable, required this.variableId});

  /// Create a new [NHTSAResult] instance from a fixed JSON payload
  factory NHTSAResult.fromJson(Map<String, dynamic> json) {
    return NHTSAResult(
      value: json['Value'] as String?, 
      valueId: json['ValueId'] as String?, 
      variable: json['Variable'] as String?, 
      variableId: json['VariableId'] as int?
    );
  }

  @override
  String toString() {
    return 'NHTSAResult[value=$value, valueId=$valueId, variable=$variable, variableId=$variableId]';
  }
}

/// Extended vehicle information for a specific VIN obtained from the NHTSA DB.
class NHTSAVehicleInfo {
  int count;
  String message;
  String searchCriteria;
  List<NHTSAResult> results = [];

  NHTSAVehicleInfo(
      {required this.count, required this.message, required this.searchCriteria, required this.results});

  /// Create a new [NHTSAVehicleInfo] instance from a fixed JSON payload
  factory NHTSAVehicleInfo.fromJson(Map<String, dynamic> json) {
    List<NHTSAResult> results = [];
    if (json['Results'] != null) {
      json['Results'].forEach((v) {
        if (v['Value'] != null &&
            v['Value'] != _RESULT_NOT_APPLICABLE &&
            v['Value'] != '') {
          results.add(NHTSAResult.fromJson(v));
        }
      });
    }
    return NHTSAVehicleInfo(
      count: (json['Count'] as int?) ?? 0,
      message: json['Message'] as String? ?? "",
      searchCriteria: json['SearchCriteria'],
      results: results
    );
  }

  static String? _normalizeStringValue(String? s) {
    if (s == null){
      return null;
    }
    return s.splitMapJoin(' ',
        onNonMatch: (m) => StringUtils.capitalize(m.toLowerCase()));
  }

  /// Lookup the value of a variable by its [variableId] in the NHTSA DB results
  String? valueFromId(int? variableId) {
    var result = results.singleWhere((e) => e.variableId == variableId,
        orElse: () => NHTSAResult(value: null, valueId: null, variable: null, variableId: null));
    return _normalizeStringValue(result.value);
  }

  /// Lookup the value of a named [variable] in the NHTSA DB results
  String? value(String variable) {
    var result =
        results.singleWhere((e) => e.variable == variable, orElse: () => NHTSAResult(value: null, valueId: null, variable: null, variableId: null));
    return _normalizeStringValue(result.value);
  }

  @override
  String toString() {
    return 'NHTSAVehicleInfo[count=$count, message=$message, searchCriteria=$searchCriteria, results=$results]';
  }
}
