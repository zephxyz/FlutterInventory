import 'package:flutter/material.dart';


class PopupDialog extends StatefulWidget {
  const PopupDialog({super.key});

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String type = 'Tool';
  String subtype = 'Shovel';
  String material = 'wood';
  final List<String> typeOptions = ['Tool', 'Weapon', 'Food', 'Armour'];
  final List<String> subtypeOptionsForArmour = [
    'Helmet',
    'Chestplate',
    'Leggings',
    'Shoes'
  ];

  final List<String> subtypeOptionsForTools = [
    'Shovel',
    'Lumberaxe',
    'Shears',
    'Pickaxe',
    'Hammer',
  ];
  final List<String> subtypeOptionsForWeapons = [
    'Sword',
    'Axe',
    'Battleaxe',
    'Spear',
    'Dagger',
    'Katana',
    'Mace',
  ];

  final List<String> subtypeOptionsForFood = [
    'Apple',
    'Steak',
    'Pizza',
    'Banana',
    'Berry',
    'Pineapple',
    'Melon',
    'Potato'
  ];
  final List<String> materialOptions = [
    "wood",
    "stone",
    "copper",
    "iron",
    "ruby",
    "sapphire",
    "jade",
    "amethyst",
    "topaz",
    "gold",
    "diamond",
    "titanium",
    "voidborn"
  ];

  List<String> subtypeOptions() {
    switch (type) {
      case 'Tool':
        return subtypeOptionsForTools;
      case 'Weapon':
        return subtypeOptionsForWeapons;
      case 'Food':
        return subtypeOptionsForFood;
      case 'Armour':
        return subtypeOptionsForArmour;
    }
    return List.empty();
  }

  String defaultSubtype() {
    switch (type) {
      case 'Tool':
        return subtypeOptionsForTools[0];
      case 'Weapon':
        return subtypeOptionsForWeapons[0];
      case 'Food':
        return subtypeOptionsForFood[0];
      case 'Armour':
        return subtypeOptionsForArmour[0];
    }
    return '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add an item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: type,
              onChanged: (String? newValue) {
                setState(() {
                  type = newValue ?? '';
                  subtype = defaultSubtype();
                });
              },
              items: typeOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            DropdownButtonFormField<String>(
              value: subtype,
              onChanged: (String? newValue) {
                setState(() {
                  subtype = newValue ?? '';
                });
              },
              items: subtypeOptions()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Subtype'),
            ),
            if (type != 'Food')
              DropdownButtonFormField<String>(
                value: material,
                onChanged: (String? newValue) {
                  setState(() {
                    material = newValue ?? 'wood';
                  });
                },
                items: materialOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Material'),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Save the input values and close the dialog
              _formKey.currentState?.save();
              Navigator.of(context).pop({
                'type': type,
                'subtype': subtype,
                'material': material,
              });
            }
          },
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
