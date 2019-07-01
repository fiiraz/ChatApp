import 'package:flutter/material.dart';
import 'package:simplefire/presenters/home_presenter.dart';
import 'package:simplefire/models/home_model.dart';
import 'package:simplefire/screens/widgets/basket.dart';
import 'package:simplefire/screens/widgets/star_rating.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller;

  HomePresenter presenter;
  HomeModel _viewModel;

  double screenWidth;
  double screenHeight;
  double shortestSize;
  var widthRate = .75;
  var textRight = 0.0;

  @override
  void initState() {
    super.initState();
    presenter = HomePresenter(this);
    presenter.prepareScreen();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return presenter.applicationScreen.widgetWithHud(
      buildPhoneList(),
      floatingActionButton: BasketActionButton(),
      refreshButton: false,
      backButton: false,
    );
  }

  ListView buildPhoneList() {
    return ListView.builder(
        //  itemExtent: 200,
        controller: controller,
        itemCount: 10,
        itemBuilder: (context, index) {
          var image;
          if (index % 2 == 0) {
            image = Image.network(
              'http://www.daimontech.com/assets/img/sock1.jpeg',
            );
          } else {
            image = Image.network(
              'http://www.daimontech.com/assets/img/sock2.jpeg',
            );
          }

          if (index % 3 == 0) {
            image = Image.network(
              'http://www.daimontech.com/assets/img/sock3.jpeg',
            );
          }

          screenWidth = MediaQuery.of(context).size.width;
          screenHeight = MediaQuery.of(context).size.height;
          shortestSize = MediaQuery.of(context).size.shortestSide;
          var currentOrientation = MediaQuery.of(context).orientation;
          if (shortestSize > 600 &&
              Orientation.portrait == currentOrientation) {
            widthRate = .50;
            textRight = 0;
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildCard(image),
                buildCard(image),
              ],
            );
          } else if (shortestSize > 600) {
            textRight = MediaQuery.of(context).size.width*0.02;
            widthRate = .50;
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildCard(image),
                buildCard(image),
              ],
            );
          }


          return buildCard(image);
        });
  }

  buildCard(image) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details');
      },
      child: Container(
        width: screenWidth * widthRate,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Card(
          elevation: 1,
          child: Column(
            children: <Widget>[
              Container(
                height: 230,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image.image,
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ürün başlığı burada olacak.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque in sodales augue. falan filan ondan işte Quisque in sodales augue. Quisque in sodales augue Quisque in sodales augue. Quisque in sodales augue..  ",
                      overflow: TextOverflow.ellipsis,
                      maxLines:
                          (20 / Theme.of(context).textTheme.body1.fontSize)
                              .floor(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Lato'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 50,
                          child: new FlatButton(
                              onPressed: () {},
                              color: Colors.white,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              child: Icon(
                                Icons.favorite_border,
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "4.0",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Lato'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              StarRate(4.0),
                              Container(
                                  child: Container(
                                      margin: EdgeInsets.only(right: textRight),
                                      child: Text(
                                        '500+',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Lato'),
                                      ))),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    if ((controller.position.extentAfter <= 0) &&
        (controller.position.pixels == controller.position.maxScrollExtent)) {
      //
    }
  }
}
