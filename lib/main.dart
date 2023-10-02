import 'package:flutter/material.dart';
import 'package:basic/components/ShoppingList.dart';
import 'package:basic/components/ShoppingListDialog.dart';
import 'package:basic/components/db.helper.dart';
import 'package:provider/provider.dart';
import 'package:basic/components/ItemScreen.dart';
import 'package:basic/components/MyProvider.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int id = 0;
  DBHelper _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    var tmp = Provider.of<ListProductProvider>(context, listen: true);
    _dbHelper.getmyShoppingList().then((value) => tmp.setShoppingList = value);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete All',
            onPressed: () {
              _dbHelper.deleteDB();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tmp.getShoppingList != null ? tmp.getShoppingList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(tmp.getShoppingList[index].id.toString()),
            onDismissed: (direction) {
              String tmpName = tmp.getShoppingList[index].name;
              int tmpId = tmp.getShoppingList[index].id;
              setState(() {
                tmp.deletedById(tmp.getShoppingList[index]);
              });
              _dbHelper.deletedShoppingList(tmpId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$tmpName deleted'),
              ));
            },
            child: ListTile(
              title: Text(tmp.getShoppingList[index].name),
              leading: Column(
                children: [
                  CircleAvatar(
                    child: Text("${tmp.getShoppingList[index].sum}"),
                  ),
                  CircleAvatar(
                    child: Text("${tmp.getShoppingList[index].price}"),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ItemsScreen(tmp.getShoppingList[index]);
                }));
              },
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ShoppingListDialog(_dbHelper).buildDialog(
                        context, tmp.getShoppingList[index], false);
                    },
                  );
                  _dbHelper.getmyShoppingList().then((value) => tmp.setShoppingList = value);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              // Tambahkan input field untuk price
              return ShoppingListDialog(_dbHelper).buildDialog(
                context, ShoppingList(++id, "", 0, 0), true);
            },
          );
          _dbHelper.getmyShoppingList().then((value) => tmp.setShoppingList = value);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
