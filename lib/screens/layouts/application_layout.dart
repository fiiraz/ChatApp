import 'package:flutter/material.dart';
import 'package:simplefire/models/current_staff.dart';

class ApplicationLayout {
  var screen;

  ApplicationLayout(screen) {
    this.screen = screen;
  }

  Widget applicationBar({topTabBar,refreshButton, backButton}) {
    var leading;
    if(refreshButton){
      leading = IconButton(
        tooltip: 'Refresh',
        icon: const Icon(Icons.refresh),
        onPressed: refreshButtonClicked,
      );
    } else if (backButton){
      leading = IconButton(
        tooltip: 'Back',
        icon: const Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(screen.context);
        },
      );
    }

    return new AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: const Text('COTTONHILL', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
      actions: <Widget>[
        Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            Container(
              height: 35,
              width: 60,
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.topRight,
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                child: Text(
                  "15",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ],
        ),
        PopupMenuButton(
          onSelected: popupMenuSelect,
          itemBuilder: (_) => <PopupMenuItem<String>>[
                PopupMenuItem(
                  value: "profile",
                  child: Text("Profil"),
                  enabled: true,
                ),
                PopupMenuItem(
                  value: "logout",
                  child: Text("Çıkış Yap"),
                  enabled: true,
                ),
              ],
        ),
      ],
      leading: leading,
      bottom: topTabBar,
      automaticallyImplyLeading: false,
    );
  }

  Widget footerBar() {
    int tabIndex = screen.presenter.footerBarIndex;

    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: tabIndex,
      onTap: footerBarButtonClicked,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(
            Icons.home,
          ),
          title: new Text(
            'Ana Sayfa',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.star_border),
          title: new Text(
            'Bana Özel',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text(
            'Favorilerim',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          title: Text(
            'Mesajlar',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget basicFooterBar() {
    return Row(
      children: <Widget>[
        RaisedButton(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(screen.context, false);
          },
        ),
      ],
    );
  }

  void popupMenuSelect(String value) async {
    if (value == "logout") {
//      await screen.presenter.api.logout();
      await CurrentStaff.logout();
      Navigator.pushNamedAndRemoveUntil(
          screen.context, "/login", (Route<dynamic> route) => false);
    }
//    else if (value == "settings") {
//      Navigator.pushNamed(screen.context, '/third_party_setup');
//    }
  }

  void footerBarButtonClicked(index) {
    int tabIndex = screen.presenter.footerBarIndex;
    if (index != tabIndex) {
      if (index == 0) {
        Navigator.pushNamed(screen.context, '/home');
      } else if (index == 1) {
        Navigator.pushNamed(screen.context, '/reviews');
      }
    }
  }

  void refreshButtonClicked() {
    try {
      Navigator.pushNamed(screen.context, '/reviews');
    } catch (e) {
      print("error: refreshButtonClicked");
    }
  }
}
