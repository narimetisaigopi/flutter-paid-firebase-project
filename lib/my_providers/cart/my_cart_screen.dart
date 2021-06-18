import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_cart_provider.dart';

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
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
          title: Text("My Cart"),
        ),
        body: Consumer<MyCartProvider>(
          builder: (contex, value, child) {
            if (value.myCartItems.length == 0) {
              return Center(child: Text("No items in the cart"));
            }
            return ListView.builder(
                itemCount: value.myCartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text("$index"),
                      title: Text(value.myCartItems[index]),
                      trailing: InkWell(
                        child: Icon(Icons.remove),
                        onTap: () {
                          _myCartProvider
                              .removeFromCart(value.myCartItems[index]);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "${value.myCartItems[index]} removed from the Cart"),
                          ));
                        },
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
