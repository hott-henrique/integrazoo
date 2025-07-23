import 'package:get_it/get_it.dart';

import 'package:isar/isar.dart';

import 'package:integrazoo/domain/bovine/bovine.dart';

import 'package:integrazoo/view/components/pagination/base/data_loader.dart';


class BovinesDataLoader extends DataLoader {

  bool _isLoading = true;

  @override
  bool get isLoading => _isLoading;

  final List<Bovine> _data = [];

  int? _rowCount;

  int _rowsPerPage = 50;
  int _page = 0;

  int get selectedRowCount => 0;

  @override
  void initialize() {
    _loadData();
  }

  @override
  int get page => _page;

  @override
  int get rowsPerPage => _rowsPerPage;

  @override
  int get availableRows => _data.length;
  int get rowCount => _isLoading ? 0 : _rowCount!;

  @override
  int get maxPages => ((_rowCount ?? 0) / _rowsPerPage).ceil();

  @override
  void previousPage() {
    if (_page > 0) {
      _page = _page - 1;
      _loadData();
    }
  }

  @override
  void nextPage() {
    if (_page < maxPages - 1) {
      _page = _page + 1;
      _loadData();
    }
  }

  @override
  set rowsPerPage (value) {
    _rowsPerPage = value;
    _loadData();
  }

  Future<void> _loadData() async {
    final isar = GetIt.instance<Isar>();
    _isLoading = true;

    notifyListeners();

    _data.clear();

    _rowCount = isar.bovines.countSync();

    final bovines = isar.bovines.where().offset(_rowsPerPage * _page).limit(_rowsPerPage).findAllSync();

    _data.addAll(bovines);

    _isLoading = false;

    notifyListeners();
  }

  void reload() {
    _loadData();
  }

  Bovine getElement(int index) {
    return _data[index % _rowsPerPage];
  }
}
