import 'package:inventory/misc/item.dart';

class Inventory {
  static final Inventory instance = Inventory._();
  Inventory._();

  final List<InvItem> _inventory = List.empty(growable: true);

  get inventory => _inventory;

  void addItem(InvItem item) {
    _inventory.add(item);
  }

  void remove(InvItem item) {
    _inventory.remove(item);
  }

  String removeAtIndex(int index) {
    final String message = 'You threw away your ${_inventory[index].name}.';
    _inventory.removeAt(index);
    return message;
  }

  String useItem(int index) {
    if (_inventory[index].isUnusable()) return 'It\'s no use.';
    _inventory[index].use();
    rotFood();
    if (_inventory[index] is Food) {
      final String message = _inventory[index].useMessage();
      removeAtIndex(index);
      return message;
    }
    return _inventory[index].useMessage() +
        (_inventory[index].isUnusable() ? ' and broke it.' : '.');
  }

  void rotFood() {
    for (dynamic item in inventory) {
      if (item is Food) {
        item.rot();
      }
    }
  }
}
