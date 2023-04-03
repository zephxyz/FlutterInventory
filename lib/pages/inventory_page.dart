import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventory/misc/inventory.dart';
import 'package:inventory/misc/item.dart';

import 'package:inventory/pages/pop_up.dart' as x;

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<InvItem> inventory = Inventory.instance.inventory;
  String message = "";

  Random rng = Random();

  void remove(int index) {
    setState(() {
      message = Inventory.instance.removeAtIndex(index);
    });
  }

  void use(int index) {
    setState(() {
      message = Inventory.instance.useItem(index);
    });
  }

  Future<void> _createItem() async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return x.PopupDialog();
      },
    );

    if (result != null) {
      final String type = result['type'] ?? '';
      final String subtype = result['subtype'] ?? '';
      final String material = result['material'] ?? '';

      createItemBySubType(
          type, subtype, AbstractItem.instance.stringToMaterial(material));

      setState(() {
        inventory = Inventory.instance.inventory;
      });
    }
  }

  void createItemBySubType(String type, String subtype, ItemMaterial material) {
    switch (type) {
      case 'Tool':
        switch (subtype) {
          case 'Shovel':
            Inventory.instance.addItem(Shovel(100, material));
            break;
          case 'Lumberaxe':
            Inventory.instance.addItem(LumberAxe(100, material));
            break;
          case 'Shears':
            Inventory.instance.addItem(Shears(100, material));
            break;
          case 'Hammer':
            Inventory.instance.addItem(Hammer(100, material));
            break;
          case 'Pickaxe':
            Inventory.instance.addItem(Shovel(100, material));
            break;
          default:
            break;
        }
        break;
      case 'Weapon':
        switch (subtype) {
          case 'Sword':
            Inventory.instance.addItem(Sword(100, material));
            break;
          case 'Axe':
            Inventory.instance.addItem(Axe(100, material));
            break;
          case 'Battleaxe':
            Inventory.instance.addItem(BattleAxe(100, material));
            break;
          case 'Mace':
            Inventory.instance.addItem(Mace(100, material));
            break;
          case 'Dagger':
            Inventory.instance.addItem(Dagger(100, material));
            break;
          case 'Spear':
            Inventory.instance.addItem(Spear(100, material));
            break;
          case 'Katana':
            Inventory.instance.addItem(Katana(100, material));
            break;
          default:
            break;
        }
        break;
      case 'Food':
        switch (subtype) {
          case 'Apple':
            Inventory.instance.addItem(Apple());
            break;
          case 'Banana':
            Inventory.instance.addItem(Banana());
            break;
          case 'Steak':
            Inventory.instance.addItem(Steak());
            break;
          case 'Berry':
            Inventory.instance.addItem(Berry());
            break;
          case 'Pizza':
            Inventory.instance.addItem(Pizza());
            break;
          case 'Pineapple':
            Inventory.instance.addItem(Pineapple());
            break;
          case 'Melon':
            Inventory.instance.addItem(Melon());
            break;
          case 'Potato':
            Inventory.instance.addItem(Melon());
            break;
          default:
            break;
        }
        break;
      case 'Armour':
        switch (subtype) {
          case 'Helmet':
            Inventory.instance.addItem(Helmet(100, material));
            break;
          case 'Chestplate':
            Inventory.instance.addItem(Chestplate(100, material));
            break;
          case 'Leggings':
            Inventory.instance.addItem(Leggings(100, material));
            break;
          case 'Shoes':
            Inventory.instance.addItem(Shoes(100, material));
            break;
          default:
            break;
        }
        break;
      default:
        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: _createItem, child: const Text('Create item')),
            const Text("Click on item to use"),
            const Text("Hold on item to remove"),
            Container(padding: const EdgeInsets.all(14), child: Text(message)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Items'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: inventory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        inventory[index].toString(),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => use(index),
                      onLongPress: () => remove(index),
                    );
                  },
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
