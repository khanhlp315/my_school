import 'dart:async';

import 'package:my_school/DAO/DataAccessHelper.dart';
import 'package:my_school/DTO/MonHocDTO.dart';
import 'package:sqflite/sqflite.dart';

class MonHocDAO {
  Future<List<MonHocDTO>> select() async {
    List<MonHocDTO> list = new List<MonHocDTO>();

    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM MonHoc');
    print("Danh sach MonHoc");
    print(listMap);

    for(int i  = 0 ; i < listMap.length ; i++)
    {
      list.add(new MonHocDTO(listMap[0]['MaMon'], listMap[0]['TenMon'], listMap[0]['HeSo']));
    }

    DataAccessHelper.closeDatabase();

    print(list[1].TenMon);
    return list;
  }

  Future<MonHocDTO> selectByID(String ID) async {
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM MonHoc WHERE MaMon = ?',
        [ID]);
    MonHocDTO result = new MonHocDTO(listMap[0]['MaMon'], listMap[0]['TenMon'], listMap[0]['HeSo']);

    print("Danh sach Mon Hoc");
    print(result.toString());

    await DataAccessHelper.closeDatabase();
    return result;
  }

  Future insert(MonHocDTO monhoc) async {
    Database database = await DataAccessHelper.connectDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO TaiKhoan(MaMon, TenMon, HeSo) VALUES(?,?,?)',
          [
            monhoc.MaMon,
            monhoc.TenMon,
            monhoc.HeSo

          ]);
    });
    await DataAccessHelper.closeDatabase();
  }

  Future update(MonHocDTO monhoc) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database.rawUpdate(
        'UPDATE MonHoc SET  TenMon = ?, HeSo = ? WHERE MaMon = ?',
        [monhoc.TenMon,monhoc.HeSo,monhoc.MaMon]);

    await DataAccessHelper.closeDatabase();
  }

  Future delete(String ID) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database
        .rawDelete('DELETE FROM MonHoc WHERE MaMon = ?', [ID]);

    await DataAccessHelper.closeDatabase();

  }
}