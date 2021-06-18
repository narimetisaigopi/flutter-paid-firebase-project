import 'package:flutter/material.dart';
import 'package:my_first_app/my_providers/my_cart_provider.dart';
import 'package:provider/provider.dart';

import 'my_cart_screen.dart';

class MyItems extends StatefulWidget {
  @override
  _MyItemsState createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> {
  List items = ["Milk", "Bread", "Biscuits", "Chachos", "Rasks"];
  List selectedItems = [];
  MyCartProvider _myCartProvider;

  @override
  void initState() {
    super.initState();
    _myCartProvider = Provider.of<MyCartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Items"),
        actions: [
          InkWell(
            child: Icon(Icons.badge),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => MyCartScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text("$index"),
                title: Text(items[index]),
                trailing: InkWell(
                  child: Icon(Icons.add),
                  onTap: () {
                    _myCartProvider.addToCart(items[index]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${items[index]} added to Cart"),
                    ));
                  },
                ),
              ),
            );
          }),
    );
  }
}
