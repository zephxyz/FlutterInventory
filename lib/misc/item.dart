import 'package:inventory/misc/inventory.dart';
import 'package:inventory/misc/inventory.dart';

class InvItem {
  final int _type;
  final String _name;
  final int _use;
  int _durability = 100;

  get type => _type;

  get name => _name;

  get use => _use;

  get durability => _durability;

  InvItem(this._type, this._name, this._use);

  

  void useItem() {
    _durability -= _use;
    if (_durability <= 0) {
      Inventory.instance.removeItem(this);
    }
  }
}



