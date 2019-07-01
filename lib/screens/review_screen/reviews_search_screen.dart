import 'package:flutter/material.dart';
import 'package:simplefire/presenters/reviews_presenter.dart';
import 'package:simplefire/screens/layouts/comment_builder.dart';
import 'package:simplefire/screens/widgets/star_rating.dart';

class ReviewsSearchScreen extends StatefulWidget {
  ReviewsPresenter presenter;

  ReviewsSearchScreen(presenter) {
    this.presenter = presenter;
  }

  @override
  _ReviewsSearchScreenState createState() => new _ReviewsSearchScreenState();
}

class _ReviewsSearchScreenState extends State<ReviewsSearchScreen> {
  ScrollController controller;
  TextEditingController textEditingController = TextEditingController();
  String text = "";

  final List<ReviewFilterEntry> _cast = <ReviewFilterEntry>[
    const ReviewFilterEntry('All', 0),
    const ReviewFilterEntry('UBER', 1),
    const ReviewFilterEntry('Yelp', 2),
    const ReviewFilterEntry('Google', 3),
  ];

  List<int> _filters = <int>[];

  Iterable<Widget> get actorWidgets sync* {
    for (ReviewFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          disabledColor: Colors.orange,
//          avatar: CircleAvatar(child: Text(actor.id)),
          label: Text(actor.name),
          selected: _filters.contains(actor.id),
          onSelected: (bool value) {
            setState(() {
              textEditingController.text = "";
              widget.presenter.resetSearchPages();
              if (value) {
                if (actor.id == 0) {
                  _filters.clear();
                  _filters.add(actor.id);
                } else if (_filters.contains(0)) {
                  _filters.clear();
                  _filters.add(actor.id);
                } else {
                  _filters.add(actor.id);
                }
              } else {
                _filters.removeWhere((int id) {
                  return id == actor.id;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    this.widget.presenter = new ReviewsPresenter(this);
    this.widget.presenter.prepareScreen();
    _filters.add(0);
    controller = new ScrollController()..addListener(_scrollListener);
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
      return Container(
        child: Column(
          children: <Widget>[
            Wrap(
              children: actorWidgets.toList(),
            ),
            //Text('Look for: ${_filters.join(',')}'),
            TextField(
              controller: textEditingController,
              onChanged: (text) {
                getSearched();
              },
            ),
            Expanded(
              child: _buildList(context),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildList(context) {
    return Scrollbar(
      child: ListView.builder(
        controller: controller,
        itemCount: widget.presenter.searchedReviews.length,
        itemBuilder: (context, index) {
          return ThirdParties(context, index);
        },
      ),
    );
  }

  Widget ThirdParties(context, index) {
    double rate = double.parse(widget.presenter.searchedReviews[index].rate);
    var text = widget.presenter.searchedReviews[index].comment;
    var name = widget
        .presenter
        .searchedReviews[index]
        .reviewer.title;
    var image = widget
        .presenter
        .searchedReviews[index]
        .reviewer.lastPhotoUrl;
    return Card(
      elevation: 3.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 74,
        child: new ListTile(
          onTap: () {},
          title:new Text(CommentBuilder.SurnameBuilder(name)),
    leading: new CircleAvatar(
    backgroundImage: new NetworkImage(image
    )),
          trailing: StarRate(rate),
          subtitle: new Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Expanded(
                          child: Text(CommentBuilder.commentText(
                              text, "reviews_search", index)),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
//    print(controller.position.extentAfter);
    String filter;
    if ((controller.position.extentAfter <= 0) &&
        (controller.position.pixels == controller.position.maxScrollExtent)) {
      if (_filters.isEmpty) {
        _filters.add(0);
        filter = _filters[0].toString();
      } else {
        filter = "${_filters.join(',')}";
      }
      print(filter + " " + textEditingController.text);
      this
          .widget
          .presenter
          .loadMoreSearch(filter, textEditingController.text)
          .then((_) {
        setState(() {});
      });
    }
  }

  getSearched() {
    setState(() {
      widget.presenter.resetSearchPages();
      String filter;
      if (_filters.isEmpty) {
        _filters.add(0);
        filter = _filters[0].toString();
      } else {
        filter = "${_filters.join(',')}";
      }
      this.widget.presenter.searchAndFilter(filter:filter, searchText:textEditingController.text);
    });
  }

  fillData() {
    setState(() {});
  }
}

class ReviewFilterEntry {
  const ReviewFilterEntry(this.name, this.id);

  final String name;
  final int id;
}
