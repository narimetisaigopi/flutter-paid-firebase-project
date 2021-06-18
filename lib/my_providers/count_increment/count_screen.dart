import 'package:flutter/material.dart';
import 'package:my_first_app/my_providers/count_increment/count_provider.dart';
import 'package:provider/provider.dart';

class CountScreen extends StatefulWidget {
  @override
  _CountScreenState createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  CountProvider counterProvider;
  @override
  void initState() {
    // data calling / other operrations should be done here only
    super.initState();
    counterProvider = Provider.of<CountProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print("StateScreen build called");
    // dnt class
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.updateCount();
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Today share price : 340"),
            Consumer<CountProvider>(
              builder: (context, value, child) {
                return Text(
                  "${value.count}",
                  style: TextStyle(fontSize: 100),
                );
              },
            ),
            Text("Today share price : 40"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // need to remove all the resources
    super.dispose();
  }
}
