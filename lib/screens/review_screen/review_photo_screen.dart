import 'package:flutter/material.dart';
import 'package:simplefire/presenters/reviews_presenter.dart';
import 'package:simplefire/screens/layouts/dialog.dart';

class PhotoScreen extends StatefulWidget {
  ReviewsPresenter presenter;

  PhotoScreen(presenter) {
    this.presenter = presenter;
  }

  @override
  _PhotoScreenState createState() => new _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  ScrollController controller;
  double shortestSize;

  @override
  void initState() {
    if (!this.mounted) {
      super.initState();
      this.widget.presenter = new ReviewsPresenter(this);
      this.widget.presenter.prepareScreen();
      controller = new ScrollController()..addListener(_scrollListener);
    }
  }

  showDialogBox(name, title, context, image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return showReview(name, title, context, image);
      },
    );
  }

  @override
  void dispose() {
    this.widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    shortestSize = MediaQuery.of(context).size.shortestSide;
    if (widget.presenter.recentReviews.isEmpty) {
      return Container();
    } else {
      return buildMainCard();
    }
  }

  buildMainCard(){
    return  ListView.builder(
        itemExtent: 230,
        controller: controller,
      itemCount: widget.presenter.recentReviews.length,
      itemBuilder: (context, index) {
          if (shortestSize > 600) {

            return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildCard(),
              buildCard(),
            ],
          );
      }
          else
           return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            buildCard(),
            ],);
        },
    );
  }

  buildCard(){
    return
      Expanded(child:
      Card(
      elevation: 3.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: new ListTile(
        onTap: () {},
        title:
        Image.network(
          'http://www.daimontech.com/assets/img/sock3.jpeg',
          width: 200,
          height: 420,
          fit: BoxFit.fill,
        ),

      ),
    ),);
  }

/*  fillData() {
    setState(() {});
  }*/

  void _scrollListener() {
//    print(controller.position.extentAfter);
    if ((controller.position.extentAfter <= 0) &&
        (controller.position.pixels == controller.position.maxScrollExtent)) {
      this.widget.presenter.loadMoreRecents().then((_) {
        //  setState(() {});
      });
    }
  }
}
