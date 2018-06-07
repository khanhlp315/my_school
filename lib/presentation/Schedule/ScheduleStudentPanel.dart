import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_school/models/LopDTO.dart';
import 'package:my_school/models/schedule_item.dart';
import 'package:my_school/services/daos/LopDAO.dart';

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
  List<LopDTO> _listClass;
  LopDTO _selectedClass;

  Map<int, List<ScheduleItem>> _map;

  initData()
  async {
    print("hello");
    LopDAO lopDAO = new LopDAO();
    _listClass = await lopDAO.select();
    print(_listClass);
  }

  ScheduleStudentState(){
    initData();

    _scheduleItems = new List<ScheduleItem>();
    _scheduleItems.add(new ScheduleItem("CTGD001", 2, 1, "12A1", "Toán"));
    _scheduleItems.add(new ScheduleItem("CTGD001", 2, 2, "12A1", "Toán"));
    _scheduleItems.add(new ScheduleItem("CTGD001", 2, 3, "12A1", "Toán"));
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
      return new Text(
          "Thứ $thu",
          textAlign: TextAlign.left,
          style: new TextStyle(
            color: Colors.blue[500],
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ));
    }

    List<ScheduleItem> scheduleItems = _map[thu];

    tiet.add(
      new Container(
        color: Colors.blueAccent,
        child:
        new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text("Thứ $thu",
                textAlign: TextAlign.left,
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),)]),

      ),
    );
    scheduleItems.forEach((schedule) {
      tiet.add( new Column(
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.fromLTRB(20.0, 2.0, 40.0, 3.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Tiết ${schedule.Tiet}",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 35.0,
                      )
                  ),
                  new Column(
                    children: <Widget>[
                      new Text(schedule.TenMon,
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                            fontSize: 35.0,
                          )
                      ),
                      new Text(schedule.TenLop,
                          textAlign: TextAlign.start,
                          style: new TextStyle(
                            fontSize: 35.0,
                          )
                      ),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )),
          new Divider(height: 3.0, indent: 1.0,)
        ],
      )
      );});

    return new Column(children: tiet);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Container(
        color: Colors.grey[200],
        child: new ListView.builder(
          itemBuilder: (context, index){
            if(index == 0){
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _listClass != null?new DropdownButton(
                    items: _listClass.map((LopDTO lop){
                      return new DropdownMenuItem<LopDTO>(child: new Text(lop.TenLop), value: lop,);
                    }).toList(),
                    value: _selectedClass,
                    onChanged:(value)
                    {
                      print(value);
                      setState(() {
                        _selectedClass = value;
                      });
                    },
                  ): new Container()
                ],
              );
            }
            return _buildItem(index + 2 - 1);
          },
          itemCount: 7,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        )
    );
  }

}