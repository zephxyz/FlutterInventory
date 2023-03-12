import 'package:inventory/misc/item.dart';

class Inventory {
  static final Inventory instance = Inventory._();
  Inventory._();

  final List<InvItem> _tools = List.empty(growable: true);
  final List<InvItem> _weapons = List.empty(growable: true);
  final List<InvItem> _food = List.empty(growable: true);

  

  get inventoryTools => _tools;
  get inventoryWeapons => _weapons;
  get inventoryFood => _food;

  int _temp = -1;

  void addItem(InvItem item) {
    switch (item.type) {
      case 0:
        _tools.add(item);
        break;
      case 1:
        _weapons.add(item);
        break;
      case 2:
        _food.add(item);
        break;
    }
  }

  void removeItem(InvItem item) {
    switch (item.type) {
      case 0:
        _tools.remove(item);
        break;
      case 1:
        _weapons.remove(item);
        break;
      case 2:
        _food.remove(item);
        break;
    }
  }

  void useItem(InvItem item) {
    switch (item.type) {
      case 0:
        _temp = _tools.indexOf(item);
        if (_temp == -1) break;
        _tools[_temp].useItem();
        rotFood();
        break;
      case 1:
        _temp = _weapons.indexOf(item);
        if (_temp == -1) break;
        _weapons[_temp].useItem();
        rotFood();
        break;
      case 2:
        _temp = _food.indexOf(item);
        if (_temp == -1) break;
        _food[_temp].useItem();
        rotFood();
        break;
    }
  }

  void rotFood() {
    for (InvItem item in _food) {
      item.useItem();
    }
  }
}
