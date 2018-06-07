import 'package:flutter/material.dart';
import 'package:my_school/presentation/home/home_presenter.dart';
import 'package:my_school/presentation/home/home_view_contract.dart';
import 'package:my_school/utils/route_names.dart';

class HomeView extends StatefulWidget{
  static const String routeName = RouteNames.HOME_PAGE;

  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomeView> with SingleTickerProviderStateMixin implements HomeViewContract{
  HomePresenter _presenter;
  TabController _tabController;

  HomeState(){
    _tabController = new TabController(length: 5, vsync: this);
    _presenter = new HomePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("My School"),),
        body: new TabBarView(
          children: <Widget>[
            new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new Container();
              },
              itemCount: 1,
            ),
            new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new Container();
              },
              itemCount: 1,
            ),
            new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new Container();
              },
              itemCount: 1,
            ),
            new Container(),
          ],
          controller: _tabController,
        ),
        bottomNavigationBar:  new Material(
          color: Colors.blue,

          child: new TabBar(
              controller: _tabController,
              tabs:  <Widget>[
                new Tab(
                  icon: new Icon(Icons.home),
                  text: "Trang chủ",
                ),
                new Tab(
                  icon: new Icon(Icons.mail),
                  text: "Hộp thư",
                ),
                new Tab(
                  icon: new Icon(Icons.people),
                  text: "Lớp học",
                ),
                new Tab(
                  icon: new Icon(Icons.calendar_today),
                  text: "TKB",
                ),
                new Tab(
                  icon: new Icon(Icons.menu),
                  text: "Khác",
                )

              ]),
        )

    );
  }

}