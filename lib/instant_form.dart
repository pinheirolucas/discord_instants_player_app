import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart" show canLaunch, launch;

class InstantForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Incluir"),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          tooltip: "Fechar",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.link),
            tooltip: "Ir para myinstants.com",
            onPressed: _launchMyInstants,
          ),
        ],
      ),
      body: Theme(
        data: ThemeData(primaryColor: Colors.indigo),
        child: Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome",
                  ),
                  maxLines: 1,
                ),
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Link",
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Salvar",
        child: Icon(Icons.save),
        // label: Text("Buscar instants"),
        // icon: Icon(Icons.link),
      ),
    );
  }

  Future<void> _launchMyInstants() async {
    const instantsUrl = "https://www.myinstants.com/";
    if (await canLaunch(instantsUrl)) {
      await launch(instantsUrl);
    }
  }
}
