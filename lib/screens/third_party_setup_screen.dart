import 'package:flutter/material.dart';
import 'package:simplefire/models/third_party_source.dart';
import 'package:simplefire/presenters/third_party_setup_presenter.dart';
import 'package:simplefire/screens/layouts/application_layout.dart';

class ThirdPartySetupScreen extends StatefulWidget {
  @override
  _ThirdPartySetupScreenState createState() =>
      new _ThirdPartySetupScreenState();
}

class _ThirdPartySetupScreenState extends State<ThirdPartySetupScreen> {
  ThirdPartySetupPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new ThirdPartySetupPresenter(this);
    presenter.prepareScreen();
  }

//  @override
//  didUpdateWidget(oldWidget) {
//    super.didUpdateWidget(oldWidget);
////    presenter.prepareScreen();
//  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationLayout applicationLayout = ApplicationLayout(this);
    return presenter.applicationScreen.widgetWithHud(
      _buildListView(),
      footBar: Row(
        children: <Widget>[
          RaisedButton(
            padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 2) - 28, right: (MediaQuery.of(context).size.width / 2) - 28, bottom: 26, top: 12),
            color: Colors.lightBlueAccent,
            child: Text("Finish", style: TextStyle(fontSize: 20.0, color: Colors.white),),
            onPressed: () => presenter.finishButtonClicked(),
          ),
        ],
      ),
    );
  }

  fillData() {
    setState(() {});
  }

  Widget _buildListView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 14.0, left: 4.0, right: 4.0),
      child: ListView.builder(
        itemBuilder: _providerItem,
        itemCount: presenter.thirdPartySources.length,
      ),
    );
  }

  Widget _providerItem(BuildContext context, int index) {
    ThirdPartySource source = presenter.thirdPartySources[index];
    var buttonText = "Connect";
    var subText = "Not Connected";
    var icon = Icon(Icons.close, color: Colors.red);
    var companyThirdParty = presenter.companyThirdParties.firstWhere(
        ((t) => t.thirdPartySourceId == source.id),
        orElse: () => null);
    if (companyThirdParty != null) {
      buttonText = "Update";
      subText = "Connected";
      icon = Icon(Icons.check, color: Colors.green);
    }
    ListBody(
      children: <Widget>[],
    );
    return Card(
      elevation: 3.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: new ListTile(
          onTap: () {},
          onLongPress: () =>
              presenter.longpressButtonClicked(companyThirdParty),
          leading: new Hero(
            tag: index,
//            child: new CircleAvatar(
//              backgroundImage: new NetworkImage(source.logoUrl),
//              backgroundColor: Colors.transparent,
//            ),
          ),
          title: new Text(source.title),
          subtitle: new Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Text(subText),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: icon,
                  ),
                ],
              ),
            ],
          ),
          trailing: new RaisedButton(
            child: Text(buttonText),
            onPressed: () => presenter.connectButtonClicked(source),
            color: Colors.blueAccent,
            elevation: 4.0,
            splashColor: Colors.blueGrey,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
