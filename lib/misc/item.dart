import 'dart:math';

class InvItem {
  String? _name;

  get name => _name;

  void _setName(String value) {
    _name = value;
  }

  String useMessage() {
    return '';
  }

  bool isUnusable() {
    return false;
  }

  ItemMaterial stringToMaterial(String value) {
    switch (value.toLowerCase()) {
      case "wood":
        return ItemMaterial.wood;
      case "stone":
        return ItemMaterial.stone;
      case "copper":
        return ItemMaterial.copper;
      case "gold":
        return ItemMaterial.gold;
      case "iron":
        return ItemMaterial.iron;
      case "amethyst":
        return ItemMaterial.amethyst;
      case "jade":
        return ItemMaterial.jade;
      case "topaz":
        return ItemMaterial.topaz;
      case "ruby":
        return ItemMaterial.ruby;
      case "sapphire":
        return ItemMaterial.sapphire;
      case "titanium":
        return ItemMaterial.titanium;
      case "diamond":
        return ItemMaterial.diamond;
      case "voidborn":
        return ItemMaterial.voidborn;
      default:
        throw Exception("Invalid material name: $value");
    }
  }

  String itemMaterialToString(ItemMaterial material) {
    switch (material) {
      case ItemMaterial.wood:
        return "Wood";
      case ItemMaterial.stone:
        return "Stone";
      case ItemMaterial.copper:
        return "Copper";
      case ItemMaterial.gold:
        return "Gold";
      case ItemMaterial.iron:
        return "Iron";
      case ItemMaterial.amethyst:
        return "Amethyst";
      case ItemMaterial.jade:
        return "Jade";
      case ItemMaterial.topaz:
        return "Topaz";
      case ItemMaterial.ruby:
        return "Ruby";
      case ItemMaterial.sapphire:
        return "Sapphire";
      case ItemMaterial.titanium:
        return "Titanium";
      case ItemMaterial.diamond:
        return "Diamond";
      case ItemMaterial.voidborn:
        return "Voidborn";
      default:
        return "";
    }
  }

  dynamic use() {
    throw Exception();
  }
}

class AbstractItem extends InvItem {
  static final AbstractItem instance = AbstractItem._();

  AbstractItem._();
}

class Weapon extends InvItem {
  double _durability;
  double? _damage;
  double? _durabilityCostPerUse;
  double? _speed;

  Weapon(this._durability) : super();

  @override
  String useMessage() {
    return "You used your $_name and dealt ${(Random().nextDouble() + 0.5) * _damage!} damage";
  }

  @override
  String toString() {
    return '$_name\nDamage: ~$_damage\nSpeed: $_speed\nDurability: $_durability%\nUse: -$_durabilityCostPerUse% durability';
  }

  @override
  bool isUnusable() {
    return _durability <= 0;
  }

  void _setDamage(value) {
    _damage = value;
  }

  void _setDurabilityCostPerUse(double value) {
    _durabilityCostPerUse = value;
  }

  void _setSpeed(double value) {
    _speed = value;
  }

  double _getDamage(ItemMaterial material, double k) {
    switch (material) {
      case ItemMaterial.wood:
        return 2.5 * k;
      case ItemMaterial.stone:
        return 3.5 * k;
      case ItemMaterial.copper:
        return 4 * k;
      case ItemMaterial.gold:
        return 4.5 * k;
      case ItemMaterial.iron:
        return 5.5 * k;
      case ItemMaterial.amethyst:
      case ItemMaterial.jade:
      case ItemMaterial.topaz:
      case ItemMaterial.ruby:
      case ItemMaterial.sapphire:
        return 7 * k;
      case ItemMaterial.titanium:
        return 9 * k;
      case ItemMaterial.diamond:
        return 10 * k;
      case ItemMaterial.voidborn:
        return 20 * k;
    }
  }

  double _getSpeed(ItemMaterial material, double k) {
    switch (material) {
      case ItemMaterial.wood:
        return 30 * k;
      case ItemMaterial.stone:
        return 25 * k;
      case ItemMaterial.copper:
        return 22.5 * k;
      case ItemMaterial.gold:
        return 20 * k;
      case ItemMaterial.iron:
        return 15 * k;
      case ItemMaterial.amethyst:
      case ItemMaterial.jade:
      case ItemMaterial.topaz:
      case ItemMaterial.ruby:
      case ItemMaterial.sapphire:
        return 12.5 * k;
      case ItemMaterial.titanium:
        return 7.5 * k;
      case ItemMaterial.diamond:
        return 5 * k;
      case ItemMaterial.voidborn:
        return 20 * k;
    }
  }

  double _getDurabilityCostPerUse(ItemMaterial material, double k) {
    switch (material) {
      case ItemMaterial.wood:
        return 10 * k;
      case ItemMaterial.stone:
        return 4 * k;
      case ItemMaterial.copper:
        return 3 * k;
      case ItemMaterial.gold:
        return 10 * k;
      case ItemMaterial.iron:
        return 2 * k;
      case ItemMaterial.amethyst:
      case ItemMaterial.jade:
      case ItemMaterial.topaz:
      case ItemMaterial.ruby:
      case ItemMaterial.sapphire:
        return 4 * k;
      case ItemMaterial.titanium:
        return 1 * k;
      case ItemMaterial.diamond:
        return 0.5 * k;
      case ItemMaterial.voidborn:
        return 0;
    }
  }

  @override
  void use() {
    _durability -= _durabilityCostPerUse!;
    if (_durability < 0) _durability = 0;
  }
}

class Sword extends Weapon {
  final ItemMaterial _material;

  Sword(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Sword");
    _setDamage(_getDamage(_material, 1));
    _setSpeed(_getSpeed(_material, 1));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 1));
  }
}

class Axe extends Weapon {
  final ItemMaterial _material;

  Axe(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Axe");
    _setDamage(_getDamage(_material, 1.3));
    _setSpeed(_getSpeed(_material, 0.7));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 0.9));
  }
}

class BattleAxe extends Weapon {
  final ItemMaterial _material;

  BattleAxe(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Battleaxe");
    _setDamage(_getDamage(_material, 1.5));
    _setSpeed(_getSpeed(_material, 0.5));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 0.8));
  }
}

class Mace extends Weapon {
  final ItemMaterial _material;

  Mace(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Mace");
    _setDamage(_getDamage(_material, 1.4));
    _setSpeed(_getSpeed(_material, 0.4));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 0.6));
  }
}

class Dagger extends Weapon {
  final ItemMaterial _material;

  Dagger(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Dagger");
    _setDamage(_getDamage(_material, 0.8));
    _setSpeed(_getSpeed(_material, 1.3));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 1.3));
  }
}

class Spear extends Weapon {
  final ItemMaterial _material;

  Spear(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Spear");
    _setDamage(_getDamage(_material, 1));
    _setSpeed(_getSpeed(_material, 1.2));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 1.3));
  }
}

class Katana extends Weapon {
  final ItemMaterial _material;

  Katana(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Katana");
    _setDamage(_getDamage(_material, 0.9));
    _setSpeed(_getSpeed(_material, 1.3));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 1.2));
  }
}

class Tool extends InvItem {
  double _durability;
  double? _efficiency;
  double? _durabilityCostPerUse;

  Tool(this._durability) : super();

  @override
  String useMessage() {
    return "You used your $_name and lost $_durabilityCostPerUse% durability";
  }

  @override
  bool isUnusable() {
    return _durability <= 0;
  }

  @override
  String toString() {
    return '$_name\nEfficiency: ${_efficiency! * 100}%\nDurability: $_durability%\nUse: -$_durabilityCostPerUse% durability';
  }

  void _setEfficiency(double value) {
    _efficiency = value;
  }

  void _setDurabilityCostPerUse(double value) {
    _durabilityCostPerUse = value;
  }

  double _getDurabilityCostPerUse(ItemMaterial material, double k) {
    switch (material) {
      case ItemMaterial.wood:
        return 10 * k;
      case ItemMaterial.stone:
        return 4 * k;
      case ItemMaterial.copper:
        return 3 * k;
      case ItemMaterial.gold:
        return 10 * k;
      case ItemMaterial.iron:
        return 2 * k;
      case ItemMaterial.amethyst:
      case ItemMaterial.jade:
      case ItemMaterial.topaz:
      case ItemMaterial.ruby:
      case ItemMaterial.sapphire:
        return 4 * k;
      case ItemMaterial.titanium:
        return 1 * k;
      case ItemMaterial.diamond:
        return 0.5 * k;
      case ItemMaterial.voidborn:
        return 0;
    }
  }

  double _getEfficiency(ItemMaterial material, double k) {
    switch (material) {
      case ItemMaterial.wood:
        return 0.5 * k;
      case ItemMaterial.stone:
        return 0.7 * k;
      case ItemMaterial.copper:
        return 0.9 * k;
      case ItemMaterial.gold:
        return 5 * k;
      case ItemMaterial.iron:
        return 1.2 * k;
      case ItemMaterial.amethyst:
      case ItemMaterial.jade:
      case ItemMaterial.topaz:
      case ItemMaterial.ruby:
      case ItemMaterial.sapphire:
        return 1.6 * k;
      case ItemMaterial.titanium:
        return 1.8 * k;
      case ItemMaterial.diamond:
        return 2 * k;
      case ItemMaterial.voidborn:
        return 3 * k;
    }
  }

  @override
  void use() {
    _durability -= _durabilityCostPerUse!;
    if (_durability < 0) _durability = 0;
  }
}

class Shovel extends Tool {
  final ItemMaterial _material;

  Shovel(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Shovel");
    _setEfficiency(_getEfficiency(_material, 0.8));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 0.8));
  }
}

class LumberAxe extends Tool {
  final ItemMaterial _material;

  LumberAxe(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Lumberaxe");
    _setEfficiency(_getEfficiency(_material, 1.2));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 1.2));
  }
}

class Pickaxe extends Tool {
  final ItemMaterial _material;

  Pickaxe(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Pickaxe");
    _setEfficiency(_getEfficiency(_material, 1.1));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 1.1));
  }
}

class Hammer extends Tool {
  final ItemMaterial _material;

  Hammer(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Hammer");
    _setEfficiency(_getEfficiency(_material, 1.5));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 1.5));
  }
}

class Shears extends Tool {
  final ItemMaterial _material;

  Shears(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Shears");
    _setEfficiency(_getEfficiency(_material, 0.3));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material, 0.2));
  }
}

class Food extends InvItem {
  double? _rotRate;
  double _rotState = 0;
  double? _hungerRestored;

  Food() : super();

  @override
  String useMessage() {
    return "You ate $_name and restored $_hungerRestored hunger!";
  }

  @override
  bool isUnusable() {
    return _rotState >= 100;
  }

  @override
  String toString() {
    return '$_name\nRestores: $_hungerRestored hunger\nRot state: $_rotState%\nRot rate: $_rotRate%/use';
  }

  void _setRotRate(double value) {
    _rotRate = value;
  }

  void _setHungerRestored(double value) {
    _hungerRestored = value;
  }

  void rot() {
    if (_rotState >= 100) {
      _rotState = 100;
      return;
    }
    _rotState += _rotRate!;
  }

  @override
  void use() {
    return;
  }
}

class Apple extends Food {
  Apple() : super() {
    _setName('Apple');
    _setRotRate(5);
    _setHungerRestored(10);
  }
}

class Banana extends Food {
  Banana() : super() {
    _setName('Banana');
    _setRotRate(2.5);
    _setHungerRestored(10);
  }
}

class Berry extends Food {
  Berry() : super() {
    _setName('Berry');
    _setRotRate(2);
    _setHungerRestored(5);
  }
}

class Steak extends Food {
  Steak() : super() {
    _setName('Steak');
    _setRotRate(1);
    _setHungerRestored(25);
  }
}

class Pineapple extends Food {
  Pineapple() : super() {
    _setName('Pineapple');
    _setRotRate(2);
    _setHungerRestored(20);
  }
}

class Melon extends Food {
  Melon() : super() {
    _setName('Melon');
    _setRotRate(5);
    _setHungerRestored(25);
  }
}

class Pizza extends Food {
  Pizza() : super() {
    _setName('Pizza');
    _setRotRate(3);
    _setHungerRestored(30);
  }
}

class Potato extends Food {
  Potato() : super() {
    _setName('Potato');
    _setRotRate(3);
    _setHungerRestored(1);
  }
}

class Armour extends InvItem {
  double? _damageReduction;
  double _durability;
  double? _durabilityCostPerUse;

  Armour(this._durability) : super();

  @override
  String useMessage() {
    return "You hit yourself, your $_name blocked ${_damageReduction! * 100}% damage and lost $_durabilityCostPerUse% durability";
  }

  @override
  bool isUnusable() {
    return _durability <= 0;
  }

  @override
  String toString() {
    return '$_name\nDamage reduction: ${_damageReduction! * 100}%\nDurability: $_durability%\nUse: -$_durabilityCostPerUse% durability';
  }

  void _setDamageReduction(double value) {
    _damageReduction = value;
  }

  void _setDurabilityCostPerUse(double value) {
    _durabilityCostPerUse = value;
  }

  double _getDamageReduction(ItemMaterial material, double k) {
    switch (material) {
      case ItemMaterial.wood:
        return 0.05 * k;
      case ItemMaterial.stone:
        return 0.075 * k;
      case ItemMaterial.copper:
        return 0.1 * k;
      case ItemMaterial.gold:
        return 0.1 * k;
      case ItemMaterial.iron:
        return 0.125 * k;
      case ItemMaterial.amethyst:
      case ItemMaterial.jade:
      case ItemMaterial.topaz:
      case ItemMaterial.ruby:
      case ItemMaterial.sapphire:
        return 0.15 * k;
      case ItemMaterial.titanium:
        return 0.175 * k;
      case ItemMaterial.diamond:
        return 0.2 * k;
      case ItemMaterial.voidborn:
        return 0.25 * k;
    }
  }

  double _getDurabilityCostPerUse(ItemMaterial material) {
    switch (material) {
      case ItemMaterial.wood:
        return 5;
      case ItemMaterial.stone:
        return 2.5;
      case ItemMaterial.copper:
        return 2;
      case ItemMaterial.gold:
        return 5;
      case ItemMaterial.iron:
        return 0.75;
      case ItemMaterial.amethyst:
      case ItemMaterial.jade:
      case ItemMaterial.topaz:
      case ItemMaterial.ruby:
      case ItemMaterial.sapphire:
        return 0.5;
      case ItemMaterial.titanium:
        return 0.25;
      case ItemMaterial.diamond:
        return 0.125;
      case ItemMaterial.voidborn:
        return 0;
    }
  }

  @override
  void use() {
    _durability -= _durabilityCostPerUse!;
    if (_durability < 0) _durability = 0;
  }
}

class Helmet extends Armour {
  final ItemMaterial _material;

  Helmet(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Helmet");
    _setDamageReduction(_getDamageReduction(_material, 0.6));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material));
  }
}

class Chestplate extends Armour {
  final ItemMaterial _material;

  Chestplate(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Chestplate");
    _setDamageReduction(_getDamageReduction(_material, 1));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material));
  }
}

class Leggings extends Armour {
  final ItemMaterial _material;

  Leggings(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Leggings");
    _setDamageReduction(_getDamageReduction(_material, 1));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material));
  }
}

class Shoes extends Armour {
  final ItemMaterial _material;

  Shoes(double durability, this._material) : super(durability) {
    _setName("${itemMaterialToString(_material)} Shoes");
    _setDamageReduction(_getDamageReduction(_material, 0.4));
    _setDurabilityCostPerUse(_getDurabilityCostPerUse(_material));
  }
}

enum ItemMaterial {
  wood,
  stone,
  copper,
  iron,
  ruby,
  sapphire,
  jade,
  amethyst,
  topaz,
  gold,
  diamond,
  titanium,
  voidborn
}
