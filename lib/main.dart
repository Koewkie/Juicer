import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Juicer';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
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

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
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
                  nic = volume * 0.167;
                  PG = VG - nic - flavour;
                  print(volume);
                  print(VG);
                  print(flavour);
                  print(nic);
                  print(PG);
                  getVG();
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
              child: ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.validate();
                  // if (_formKey.currentState!.validate()) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text('Processing Data')),
                  //   );
                  // }
                },
                child: const Text('Submit'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
              child: TextFormField(
                readOnly: true,
                controller: _controllerVG,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
              child: TextFormField(
                readOnly: true,
                controller: _controllerPG,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
              child: TextFormField(
                readOnly: true,
                controller: _controllerFlav,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
              child: TextFormField(
                readOnly: true,
                controller: _controllerNic,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
          ],
        )));
  }
}
