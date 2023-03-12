import 'package:flutter/material.dart';

class MyPopupDialog extends StatefulWidget {
  @override
  _MyPopupDialogState createState() => _MyPopupDialogState();
}

class _MyPopupDialogState extends State<MyPopupDialog> {
  final myNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int myQuantity = 1;
  String myType = 'Tool';
  final List<String> typeOptions = ['Tool', 'Weapon', 'Food'];

  @override
  void dispose() {
    myNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add an item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: myType,
              onChanged: (String? newValue) {
                setState(() {
                  myType = newValue ?? '';
                });
              },
              items: typeOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextFormField(
              controller: myNameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a quantity';
                }
                final n = int.tryParse(value.toString());
                if (n == null) {
                  return '"$value" is not a valid number';
                }
                return null;
              },
              onSaved: (value) {
                myQuantity = int.parse(value.toString());
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Add'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Save the input values and close the dialog
              _formKey.currentState?.save();
              Navigator.of(context).pop({
                'type': myType,
                'name': myNameController.text,
                'quantity': myQuantity,
              });
            }
          },
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

