import 'package:flutter/material.dart';
import 'package:simplefire/presenters/reviews_presenter.dart';
import 'package:simplefire/screens/layouts/comment_builder.dart';
import 'package:simplefire/screens/widgets/star_rating.dart';

class ReviewsHomeScreen extends StatefulWidget {
  ReviewsPresenter presenter;

  ReviewsHomeScreen(presenter) {
    this.presenter = presenter;
  }

  @override
  _ReviewsHomeScreenState createState() => new _ReviewsHomeScreenState();
}

class _ReviewsHomeScreenState extends State<ReviewsHomeScreen> {
  @override
  void initState() {
    if(!this.mounted) {
      super.initState();
      this.widget.presenter = new ReviewsPresenter(this);
      this.widget.presenter.prepareScreen();
    }
  }

  @override
  void dispose() {
    this.widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.presenter.companyThirdParties.isEmpty) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Expanded(
            child: _buildList(context),
          ),
        ],
      );
    }
  }

  Widget _buildList(context) {
    return ListView.builder(
      itemCount: widget.presenter.companyThirdParties.length,
      itemBuilder: (context, index) {
        return ThirdParties(context, index);
      },
    );
  }

/*
  String commentText(int index) {
    var text = widget.presenter.companyThirdParties[index].reviews[0].comment;
    if (text.length > 10) {
      return text.substring(0, 34) + "...";
    } else
      return text;
  }
*/

  Widget ThirdParties(context, index) {
    double leadRate =
        double.parse(widget.presenter.companyThirdParties[index].overallRate);
    double reviewRate = double.parse(
        widget.presenter.companyThirdParties[index].reviews[0].rate);
    var text = widget.presenter.companyThirdParties[index].reviews[0].comment;
    return Card(
      elevation: 2.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: new ListTile(
          onTap: () {},
          title: Container(
            width: 50,
            height: 130,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: new Row(
                        children: <Widget>[
                          FittedBox(
                              child: new CircleAvatar(
                                  backgroundImage: new NetworkImage(widget
                                      .presenter
                                      .companyThirdParties[index]
                                      .reviews[0]
                                      .reviewer
                                      .lastPhotoUrl))),
                          FittedBox(
                            child: Text("  "+widget
                                .presenter
                                .companyThirdParties[index]
                                .reviews[0]
                                .reviewer
                                .title),
                          )
                        ],
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(CommentBuilder.commentText(
                                text, "reviews_home", index),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color(0xFF7C7C78))),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: StarRate(reviewRate),
                            )
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          leading: new Hero(
            tag: index,
            child: Column(
              children: <Widget>[
                Container(
                    child: new CircleAvatar(
                        backgroundImage: new NetworkImage(widget
                            .presenter
                            .companyThirdParties[index]
                            .thirdPartySource
                            .logoUrl),
                        backgroundColor: Colors.transparent)),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(leadRate.toString()),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: StarRate(leadRate),
                ),
              ],
            ),
          ),
          subtitle: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Text(widget
                            .presenter.companyThirdParties[index].reviews.length
                            .toString() +
                        " reviews"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*fillData() {
    setState(() {});
  }*/
}
