import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SharedPrefereceExample(),
    );
  }
}

class SharedPrefereceExample extends StatefulWidget {
  // const SharedPrefereceExample({Key? key}) : super(key: key);

  @override
  _SharedPrefereceExampleState createState() => _SharedPrefereceExampleState();
}

class _SharedPrefereceExampleState extends State<SharedPrefereceExample> {
  late SharedPreferences _prefs;

  static const String KNumberPrefKey = 'number_pref';
  static const String KBoolPrefKey = 'bool_pref';

  int _numberPref = 0;
  bool _boolPref = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance()
      .then((prefs) {
        setState(() => this._prefs = prefs);
        _loadNumberPref();
        _loadBoolPref();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
      ),
      body: Column(
        children: <Widget>[
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(children: <Widget>[
                Text('Number Preference'),
                Text('${this._numberPref}'),
                ElevatedButton(
                  child: Text('Increment'),
                  onPressed: () => this._setNumberPref(this._numberPref + 1),
                ),
              ]),
              TableRow(children: <Widget>[
                Text('Boolean Preference'),
                Text('${this._boolPref}'),
                ElevatedButton(
                  child: Text('Toogle'),
                  onPressed: () => this._setBoolPref(!this._boolPref),
                ),
              ]),
            ],
          ),
          ElevatedButton(
            child: Text('Reset Data'),
            onPressed: () => this._resetDataPref(),
          ),
        ],
      ),
    );
  }

  Future<Null> _setNumberPref(int value) async {
    await this._prefs.setInt(KNumberPrefKey, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async {
    await this._prefs.setBool(KBoolPrefKey, value);
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      this._numberPref = this._prefs.getInt(KNumberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      this._boolPref = this._prefs.getBool(KBoolPrefKey) ?? false;
    });
  }

  Future<Null> _resetDataPref() async {
    await this._prefs.remove(KNumberPrefKey);
    await this._prefs.remove(KBoolPrefKey);
    _loadNumberPref();
    _loadBoolPref();
  }
}
class myapp extends StatefulWidget {
  const myapp({Name? number}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
