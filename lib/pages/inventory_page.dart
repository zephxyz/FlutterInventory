import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:inventory/misc/inventory.dart';
import 'package:inventory/misc/item.dart';

import 'package:inventory/pages/pop_up.dart' as x;

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<InvItem> _tools = Inventory.instance.inventoryTools;
  List<InvItem> _weapons = Inventory.instance.inventoryWeapons;
  List<InvItem> _food = Inventory.instance.inventoryFood;

  Random rng = Random();

  Future<void> _createItem() async {
    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return x.MyPopupDialog();
      },
    );

    if (result != null) {
      final String type = result['type'] ?? '';
      final String name = result['name'] ?? '';
      int tp = 0;
      switch(type){
        case "Tool": tp = 0; break;
        case "Weapon": tp = 1; break;
        case "Food": tp = 2; break;
      }
      final int quantity = result['quantity'] ?? 0;
      Inventory.instance.addItem(InvItem(tp, name, quantity));
      setState(() {
        if (type == 'Tool') {
          _tools = Inventory.instance.inventoryTools;
        } else if (type == 'Weapon') {
          _weapons = Inventory.instance.inventoryWeapons;
        } else if (type == 'Food') {
          _food = Inventory.instance.inventoryFood;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _createItem, child: Text('Create item')),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Tools'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _tools.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              '${_tools[index].name}\n${_tools[index].type}\n${_tools[index].use}\n${_tools[index].durability}',
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Weapons'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _weapons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(_weapons[index].name),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Food'),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _food.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(_food[index].name),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    ));
  }
}
