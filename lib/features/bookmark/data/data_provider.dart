import 'package:bloge/features/bookmark/model/save_bookmark_model.dart';
import 'package:bloge/features/bookmark/data/db_helper.dart';
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

// import 'package:bloge/features/bookmark/model/save_bookmark_model.dart';
// import 'package:bloge/features/bookmark/data/db_helper.dart';
// import 'package:flutter/material.dart';

// class BookmarkP with ChangeNotifier {
//   final Dbhelper _dbhelper = Dbhelper();

//   /// TEST DATA (used before DB load)
//   final List<DataModel> _bookmark = [
//     DataModel(
//       id: 1,
//       image: 'https://picsum.photos/400/300?1',
//       title: 'Flutter State Management',
//       dics: 'Understanding Provider, Riverpod, and Bloc in Flutter.',
//     ),
//     DataModel(
//       id: 2,
//       image: 'https://picsum.photos/400/300?2',
//       title: 'Dart Best Practices',
//       dics: 'Clean code techniques and performance tips for Dart.',
//     ),
//     DataModel(
//       id: 3,
//       image: 'https://picsum.photos/400/300?3',
//       title: 'REST API in Flutter',
//       dics: 'How to fetch and display API data efficiently.',
//     ),
//     DataModel(
//       id: 4,
//       image: '',
//       title: 'Offline Storage',
//       dics: 'Using SQLite for offline data persistence.',
//     ),
//   ];

//   List<DataModel> get bookmark => _bookmark;

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   /// LOAD DATA
//   // Future<void> loadData() async {
//   //   _isLoading = true;
//   //   notifyListeners();

//   //   /// COMMENT THIS LINE IF YOU WANT ONLY TEST DATA
//   //   _bookmark = await _dbhelper.readData();

//   //   _isLoading = false;
//   //   notifyListeners();
//   // }
//   Future<void> loadData() async {
//     _isLoading = true;
//     notifyListeners();
 

//     _isLoading = false;
//     notifyListeners();
//   }

//   /// ADD BOOKMARK
//   Future<void> addBookmark(DataModel data) async {
//     await _dbhelper.insertData(data);
//     await loadData();
//   }

//   /// DELETE BOOKMARK
//   Future<void> deletebookmark(int id) async {
//     await _dbhelper.deleteData(id);
//     await loadData();
//   }

//   /// CHECK BOOKMARK
//   bool isBookmarked(int id) {
//     return _bookmark.any((bookmark) => bookmark.id == id);
//   }

//   /// TOGGLE BOOKMARK
//   Future<void> togglebookmark(DataModel data) async {
//     if (isBookmarked(data.id)) {
//       await deletebookmark(data.id);
//     } else {
//       await addBookmark(data);
//     }
//   }
// }
