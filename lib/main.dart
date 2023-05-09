import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'favorites.dart';
import 'package:juicer/utils/database_helper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Juicer';
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController _controllerVG = TextEditingController();
  final TextEditingController _controllerPG = TextEditingController();
  final TextEditingController _controllerFlav = TextEditingController();
  final TextEditingController _controllerNic = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerVG.text = 'VG (ml)';
    _controllerPG.text = 'PG (ml)';
    _controllerFlav.text = 'Flavour (ml)';
    _controllerNic.text = 'Nicotine (ml)';
  }

  void getVG() {
    _controllerVG.text = 'VG: ' + VG.toString() + ' ml';
    _controllerPG.text = 'PG: ' + PG.toStringAsFixed(2) + ' ml';
    _controllerFlav.text = 'Flavour: ' + flavour.toStringAsFixed(2) + ' ml';
    _controllerNic.text = 'Nicotine: ' + nic.toStringAsFixed(2) + ' ml';
  }

  final _formKey = GlobalKey<FormState>();
  double volume = 0;
  double VG = 0;
  double flavour = 0;
  double nic = 0;
  double PG = 0;
  double NicShot = 0;
  double NicStrength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Juicer'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Favorites();
                }));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Favorites'),
            )
          ],
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Juice volume (ml)',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Don't leave empty";
                      }
                      volume = double.parse(value);
                      VG = volume / 2;
                      flavour = volume * 0.1;
                      return null;
                    },
                  ),
                ),
                _buildStrength(),
                _buildNic(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                    },
                    child: const Text('Calculate'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerVG,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerPG,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerFlav,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                  child: TextFormField(
                    readOnly: true,
                    controller: _controllerNic,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      final dat = DatabaseHelper.db();
                      final x = DatabaseHelper.createItem(
                          'Testing title', 'Testing description');
                    },
                    child: const Text('Save'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () async {
                      List<Map<String, dynamic>> _journals = [];
                      _journals = await DatabaseHelper.getItems();
                      print(_journals[0]);
                    },
                    child: const Text('Debug REMOVE AFTER'),
                  ),
                ),
              ],
            ))));
  }

  Widget _buildNic() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
      child: TextFormField(
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), labelText: "Nicotine Shot (mg/ml)"),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Don't leave empty";
          }
          NicShot = double.parse(value);
          nic = (volume * NicStrength) / NicShot;
          PG = VG - nic - flavour;
          getVG();
          return null;
        },
      ),
    );
  }

  Widget _buildStrength() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
      child: TextFormField(
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Strength of final juice (mg)"),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Don't leave empty";
          }
          NicStrength = double.parse(value);
          return null;
        },
      ),
    );
  }
}
