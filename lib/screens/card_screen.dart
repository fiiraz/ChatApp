import 'package:flutter/material.dart';
import 'package:simplefire/presenters/reviews_presenter.dart';
import 'package:simplefire/screens/review_screen/review_photo_screen.dart';
import 'package:simplefire/screens/review_screen/reviews_recents_screen.dart';
import 'package:simplefire/screens/widgets/basket.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => new _CardScreenState();
}

class _CardScreenState extends State<CardScreen> with TickerProviderStateMixin {
  ReviewsPresenter presenter;
  TabController _applicationTabController;

  final GlobalKey _applicationBarKey = new GlobalKey();

  final List<Tab> reviewsBarTabs = <Tab>[
    Tab(icon: Icon(Icons.shopping_basket), text: 'Sepetim'),
    Tab(icon: Icon(Icons.shop), text: 'Satın Aldıklarım'),
    Tab(icon: Icon(Icons.rate_review), text: 'Değerlendirmelerim'),
    Tab(icon: Icon(Icons.photo_album), text: 'Fotoğraflarım'),
  ];
  Widget topTabBar() {
    return new TabBar(
      labelColor: Colors.pinkAccent,
      isScrollable: true,
      tabs: reviewsBarTabs,
      controller: _applicationTabController,
      indicatorColor: Colors.pinkAccent,
    );
  }

  @override
  void initState() {
    super.initState();
    presenter = new ReviewsPresenter(this);
    presenter.prepareScreen();
    _applicationTabController =
        TabController(vsync: this, length: reviewsBarTabs.length);
    print(reviewsBarTabs.length);
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return presenter.applicationScreen.widgetWithHud(
      TabBarView(
        controller: _applicationTabController,
        children: reviewsBarTabs.map((Tab tab) {
          return renderPage(tab);
        }).toList(),
      ),
      topTabBar: topTabBar(),
    );
  }

  Widget renderPage(Tab tab) {
    if (tab.text == "Değerlendirmelerim") {
      return ReviewsRecentsScreen(presenter);
    } else if (tab.text == "Fotoğraflarım") {
      return PhotoScreen(presenter);
    } else {
      return Center(child: Text("İçerik Yok"));
    }
  }

/* fillData() {
    setState(() {});
  }*/
}
