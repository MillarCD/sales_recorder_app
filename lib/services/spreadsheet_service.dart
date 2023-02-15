import 'package:gsheets/gsheets.dart';

import 'package:register_sale_app/config.dart';

class SpreadsheetService {
  GSheets? _gsheets;
  Spreadsheet? _spreadsheet;
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  static const int timeout = 5;

  static final String _spreadsheetId = config['sheetId']!;

  SpreadsheetService._private();
  static final ssService = SpreadsheetService._private();

  factory SpreadsheetService() {
    return ssService;
  }

  Future<bool> connect() async {
    _isLoading = true;
    try {
      _gsheets = GSheets(config['credentials']);
      _spreadsheet = await _gsheets!.spreadsheet(_spreadsheetId);
    } catch (e) {
      _isLoading = false;
      return false;
    }

    _isLoading = false;
    _isConnected = true;
    return true;
  }



  Future<List<List<String>>?> getRows(String sheetName) async {
    if (_spreadsheet == null && !await connect()) return null;

    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return null;

    final List<List<String>>? rows;

    try {
      rows =  await sheet.values.allRows().timeout(
        const Duration(seconds: timeout),
      );
    } catch (e) {
      return null;
    }

    return rows;
  }

  Future<bool> appendRows(String sheetName, List<List<dynamic>> values) async {
    if (_spreadsheet == null && !await connect()) return false;
    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return false;

    bool res = false;

    try {
      res = await sheet.values.appendRows(values).timeout(
        const Duration(seconds: timeout),
      );
    } catch (e) {
      return false;
    }

    return res;
  }

  Future<bool> updateCellValue(
      String sheetName, dynamic value, int row, int column) async {
    if (_spreadsheet == null && await connect()) return false;
    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return false;

    bool res = false;
    
    try {
      res = await sheet.values.insertValue(value, column: column, row: row).timeout(
        const Duration(seconds: timeout),
      );
    } catch (e) {
      return false;
    }
    return res;
  }

  Future<List<String>?> getLastRow(String sheetName, {int? length}) async {
    if (_spreadsheet == null && await connect()) return [];
    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return [];

    List<String>? res;

    try {
      res = await sheet.values.lastRow(length: length ?? -1).timeout(
        const Duration(seconds: timeout),
      );
    } catch (e) {
      return null;
    }
    return res;
  }
}
