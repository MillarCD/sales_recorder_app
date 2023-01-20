import 'package:gsheets/gsheets.dart';

import 'package:register_sale_app/config.dart';

class SpreadsheetService {
  GSheets? _gsheets;
  Spreadsheet? _spreadsheet;
  static final String _spreadsheetId = config['sheetId']!;

  SpreadsheetService._private();
  static final ssService = SpreadsheetService._private();

  factory SpreadsheetService() {
    return ssService;
  }

  Future<void> connect() async {
    _gsheets = GSheets(config['credentials']);
    _spreadsheet = await _gsheets!.spreadsheet(_spreadsheetId);

    print('connected...');
  }

  Future<List<List<String>>?> getRows(String sheetName) async {
    if (_spreadsheet == null) await connect();

    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return null;

    return await sheet.values.allRows();
  }

  Future<bool> appendRows(String sheetName, List<List<dynamic>> values) async {
    if (_spreadsheet == null) await connect();
    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return false;

    final bool res = await sheet.values.appendRows(values);

    return res;
  }

  Future<bool> updateCellValue(
      String sheetName, dynamic value, int row, int column) async {
    if (_spreadsheet == null) await connect();
    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return false;

    final bool res =
        await sheet.values.insertValue(value, column: column, row: row);
    return res;
  }

  Future<List<String>> getLastRow(String sheetName, {int? length}) async {
    if (_spreadsheet == null) await connect();
    final Worksheet? sheet = _spreadsheet!.worksheetByTitle(sheetName);

    if (sheet == null) return [];

    final List<String>? res = await sheet.values.lastRow(length: length ?? -1);
    return res ?? [];
  }
}
