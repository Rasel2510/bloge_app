import 'package:bloge/models/data_model.dart';
import 'package:bloge/services/database/db_helper.dart';
import 'package:flutter/material.dart';

class BookmarkP with ChangeNotifier {
  final Dbhelper _dbhelper = Dbhelper();

  List<DataModel> _bookmark = [];
  List<DataModel> get bookmark => _bookmark;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // load data
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    _bookmark = await _dbhelper.readData();
    _isLoading = false;
    notifyListeners();
  }

  // insert data
  Future<void> addBookmark(DataModel data) async {
    await _dbhelper.insertData(data);
    await loadData();
    notifyListeners();
  }

  // remove data
  Future<void> deletebookmark(int id) async {
    await _dbhelper.deleteData(id);
    await loadData();
    notifyListeners();
  }

  bool isBookmarked(int id) {
    return _bookmark.any((bookmark) => bookmark.id == id);
  }

  Future<void> togglebookmark(DataModel data) async {
    if (isBookmarked(data.id)) {
      await deletebookmark(data.id);
    } else {
      await addBookmark(data);
    }
  }
}
