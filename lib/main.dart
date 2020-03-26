import "package:flutter/material.dart";
import "package:flutter_statusbarcolor/flutter_statusbarcolor.dart" show FlutterStatusbarcolor;

import "./instant_form.dart" show InstantForm;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Discord Instants Player",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey.shade50,
      ),
      home: HomePage(
        title: Center(
          child: Text("Discord Instants Player"),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final Widget title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final double targetElevation = 4;
  double _appBarElevation = 0;
  ScrollController _scroll;

  @override
  void initState() {
    super.initState();

    _scroll = ScrollController();
    _scroll.addListener(_handleScrollListen);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();

    _scroll?.removeListener(_handleScrollListen);
    _scroll?.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _setSystemOverlayColors();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }

  void _handleScrollListen() {
    final double newElevation = _scroll.offset > 1 ? targetElevation : 0;
    if (_appBarElevation != newElevation) {
      setState(() {
        _appBarElevation = newElevation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        elevation: _appBarElevation,
      ),
      body: ListView(
        controller: _scroll,
        children: List.generate(
          100,
          (int i) => ListTile(
            title: Text("This is a title"),
            subtitle: Text("This is a subtitle"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InstantForm()));
        },
        tooltip: "Increment",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _setSystemOverlayColors() async {
    await Future.wait([
      FlutterStatusbarcolor.setStatusBarColor(Colors.grey.shade50),
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false),
      FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade50),
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false),
    ]);
  }
}
