import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_school/models/LopDTO.dart';
import 'package:my_school/models/schedule_item.dart';

class ScheduleStudentPanel extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ScheduleStudentState();
  }

}

class ScheduleStudentState extends State<ScheduleStudentPanel> {

  LopDTO _selectTeacher;

  List<ScheduleItem> _scheduleItems;

  Map<int, List<ScheduleItem>> _map;

  ScheduleStudentState(){
    _scheduleItems = new List<ScheduleItem>();
    _scheduleItems.add(new ScheduleItem("CTGD001", 2, 1, "12A1", "Toán"));
    _scheduleItems.add(new ScheduleItem("CTGD002", 3, 2, "12A2", "Văn"));
    _scheduleItems.add(new ScheduleItem("CTGD003", 4, 3, "12A3", "Anh"));
    _scheduleItems.add(new ScheduleItem("CTGD004", 5, 4, "12A4", "Lý"));
    _map = new Map<int, List<ScheduleItem>>();
    _map.clear();
    _scheduleItems.forEach((schedule){
      if(_map.containsKey(schedule.Thu)){
        _map[schedule.Thu].add(schedule);
      }
      else {
        _map[schedule.Thu] = new List<ScheduleItem>();
        _map[schedule.Thu].add(schedule);
      }
    });
  }

  Widget _buildItem(int thu){
    print("1");
    List<Widget> tiet = new List<Widget>();

    if(!_map.containsKey(thu) || _map[thu].length == 0){
      return new Text("Thứ $thu");
    }

    List<ScheduleItem> scheduleItems = _map[thu];

    tiet.add(new Text("Thứ $thu"));
    scheduleItems.forEach((schedule) {
      tiet.add(new Row(
        children: <Widget>[
          new Text("Tiết ${schedule.Thu}"),
          new Column(
            children: <Widget>[
              new Text(schedule.TenMon),
              new Text(schedule.TenLop),
            ],

          )
        ],
      ));
    });

    return new Column(children: tiet);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      color: Colors.grey[200],
      padding: new EdgeInsets.only(top: 10.0,bottom: 10.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Padding(
                    child: new Text(
                      _selectTeacher == null?"Chưa chọn lớp":_selectTeacher.MaLop ,
                      style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0

                      ),),
                    padding: new EdgeInsets.only(left: 10.0),),
                  new Padding(
                    child: new Text(
                      _selectTeacher == null?"Bấm để chọn lớp":_selectTeacher.TenLop,
                      style: new TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0
                      ),),
                    padding: new EdgeInsets.only(left: 10.0),),
                ],
              ),
              new FlatButton(
                onPressed: null,
                child: new Icon(Icons.arrow_forward_ios) ,)
            ],
          ),
          new ListView.builder(
            itemBuilder: (context, index){
              return _buildItem(index + 2);
            },
            shrinkWrap: true,
            itemCount: 6,

          )
        ]
      )
    );
  }
}