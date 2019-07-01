import 'package:flutter/material.dart';
import 'package:simplefire/presenters/details_presenter.dart';
import 'package:simplefire/screens/widgets/star_rating.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => new _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = new DetailsPresenter(this);
    presenter.prepareScreen();
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return presenter.applicationScreen.widgetWithHud(
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopDetails(),
          ],
        ),
      ),
      footBar: false,
      refreshButton: false,
    );
  }

  fillData() {
    setState(() {});
  }
}

class TopDetails extends StatefulWidget {
  @override
  _TopDetailsState createState() => _TopDetailsState();
}

class _TopDetailsState extends State<TopDetails> {
  bool isExpanded = false;
  double baseHeight = 640.0;
  String desc =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque in sodales augue. Quisque in sodales augue. Quisque in sodales augue Quisque in sodales augue. Quisque in sodales Quisque  Quisque in sodales augue Quisque in sodales Quisque in sodales augue. augue Quisque in sodales augue..  ";
  double titleSize = 18.0;
  double contentSize = 12.0;
  double imageHeight = 265.0;

  double screenAwareSize(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width * .90;
    var _height = MediaQuery.of(context).size.width / 40.22;
    var _longHeight = MediaQuery.of(context).size.width / 34.22;
    double shortestSize = MediaQuery.of(context).size.shortestSide;
    if (shortestSize > 600) {
      titleSize = 24.0;
      contentSize = 16.0;
      imageHeight = 320.0;
    }
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: screenAwareSize(imageHeight, context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(
                'http://www.daimontech.com/assets/img/sock3.jpeg',
              ).image,
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Ürün başlığı burada olacak",
                style: TextStyle(
                    color: Color(0xFF0E3746),
                    fontSize: titleSize,
                    fontFamily: "Montserrat-SemiBold"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _height,
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          StarRate(4.0),
                          SizedBox(
                            width: screenAwareSize(8.0, context),
                          ),
                          Text("4.0",
                              style: TextStyle(color: Color(0xFF0E3746))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height,
                    ),
                    Container(
                      child: Row(
                          children: <Widget>[
                        Text(
                          "Cins: Erkek/Kadın",
                          style: TextStyle(
                              color: Color(0xFF0E3746),
                              fontSize: contentSize,
                              fontFamily: "Montserrat-SemiBold"),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 6, 0, 0, 0),
                          child: Text(
                            "Renk: Sarı/Yeşil/Mavi/Kırmızı",
                            style: TextStyle(
                                color: Color(0xFF0E3746),
                                fontSize: contentSize,
                                fontFamily: "Montserrat-SemiBold"),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: _height,
                    ),
                    Container(
                      child: Row(
                          children: <Widget>[
                        Text(
                          "Sezon: Yaz",
                          style: TextStyle(
                              color: Color(0xFF0E3746),
                              fontSize: contentSize,
                              fontFamily: "Montserrat-SemiBold"),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 3.8, 0, 0, 0),
                          child: Text(
                            "Ölçü: 39-41,41-55",
                            style: TextStyle(
                                color: Color(0xFF0E3746),
                                fontSize: contentSize,
                                fontFamily: "Montserrat-SemiBold"),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: _height,
                    ),
                    Container(
                      child: Row(
                          children: <Widget>[
                        Text(
                          "Fiyat: 1000",
                          style: TextStyle(
                              color: Color(0xFF0E3746),
                              fontSize: contentSize,
                              fontFamily: "Montserrat-SemiBold"),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: _height,
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: _width,
                      child: new RaisedButton(
                        onPressed: () {},
                        color: Colors.blueAccent,
                        child: new Text(
                          "Değerlendir",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                      child: new RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        child: new Text(
                          "Satın al",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                      child: new RaisedButton(
                        onPressed: () {},
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                              ),
                              new Text("Sepete ekle"),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height,
              ),
              Text(
                "Açıklamalar:",
                style: TextStyle(
                    color: Color(0xFF0E3746),
                    fontSize: 16,
                    fontFamily: "Montserrat-SemiBold"),
              ),
              SizedBox(
                height: _height,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenAwareSize(26.0, context),
                    right: screenAwareSize(18.0, context)),
                child: AnimatedCrossFade(
                  firstChild: Text(
                    desc,
                    maxLines: 4,
                    style: TextStyle(
                        color: Color(0xFF0E3746),
                        fontSize: contentSize,
                        fontFamily: "Montserrat-Medium"),
                  ),
                  secondChild: Text(
                    desc,
                    style: TextStyle(
                        color: Color(0xFF0E3746),
                        fontSize: contentSize,
                        fontFamily: "Montserrat-Medium"),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: kThemeAnimationDuration,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenAwareSize(26.0, context),
                    right: screenAwareSize(18.0, context)),
                child: GestureDetector(
                    onTap: _expand,
                    child: Text(
                      isExpanded ? "daha az göster" : "daha fazlası..",
                      style: TextStyle(
                          color: Color(0xFFFB382F),
                          fontWeight: FontWeight.w700),
                    )),
              ),
              SizedBox(
                height: _longHeight,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
