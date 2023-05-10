import 'package:flutter/material.dart';
import 'package:juicer/utils/database_helper.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool togetlist = true;
  var setjournal = [];
  var titles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: getFavList(),
    );
  }

  getlist() async {
    var journal = await DatabaseHelper.getItems();
    setState(() {
      setjournal = journal;
      togetlist = false;
    });
  }

  ListView getFavList() {
    if (togetlist) {
      getlist();
    }

    return ListView.builder(
      itemCount: setjournal.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent,
            ),
            title: Text(setjournal[index]['title']),
            subtitle: Text(setjournal[index]['description']),
            trailing: IconButton(
              onPressed: () {
                DatabaseHelper.deleteItem(setjournal[index]['id']);
                getlist();
                getlist();
              },
              icon: const Icon(Icons.delete),
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
