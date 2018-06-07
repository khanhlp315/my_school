import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_school/models/GiaoVienDTO.dart';

class ScheduleTeacherPanel extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ScheduleTeacherState();
  }

}

class ScheduleTeacherState extends State<ScheduleTeacherPanel> {

  GiaoVienDTO _selectTeacher;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      color: Colors.grey[200],
      padding: new EdgeInsets.only(top: 10.0,bottom: 10.0),
      child: new Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Padding(
                  child: new Text(
                      _selectTeacher == null?"Chưa chọn giáo viên":_selectTeacher.TenGV ,
                      style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0

                  ),),
                  padding: new EdgeInsets.only(left: 10.0),),
              new Padding(
                  child: new Text(
                      _selectTeacher == null?"Bấm để chọn giáo viên":_selectTeacher.TenGV,
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
    );
  }
}