import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_school/models/ChiTietGiangDayDTO.dart';
import 'package:my_school/models/schedule_item.dart';
import 'package:my_school/presentation/Schedule/ScheduleTeacherPanel.dart';
import 'package:my_school/presentation/Schedule/ScheduleStudentPanel.dart';


class SchedulePanel extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ScheduleState();
  }

}

class ScheduleState extends State<SchedulePanel>  with SingleTickerProviderStateMixin {
  TabController tabController;


  ScheduleState(){

  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          titleSpacing: 5.0,
          title: new Text('Thời khóa biểu',style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          bottom: new PreferredSize(
            preferredSize: new Size(null, 50.0),
            child: new Container(
                color: Colors.blue,
                child: new TabBar(
                  labelColor: Colors.black,
                  tabs: <Tab>[
                    new Tab(text: "Giáo viên",),
                    new Tab(text: "Học sinh")
                  ],
                  controller: tabController,
                )),)),
      body: new TabBarView(
          controller: tabController,
          children: <Widget>[
            new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
            return new ScheduleTeacherPanel();
          },
          itemCount: 1,
           ),
          new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
              return new ScheduleStudentPanel();
          },
            itemCount: 1,
          ),
    ]),
    );
  }
}
