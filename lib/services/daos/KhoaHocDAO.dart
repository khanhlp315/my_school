import 'dart:async';

import 'package:my_school/models/KhoaHocDTO.dart';
import 'package:my_school/services/daos/DataAccessHelper.dart';
import 'package:sqflite/sqflite.dart';

class KhoaHocDAO {
  Future<List<KhoaHocDTO>> select() async {
    List<KhoaHocDTO> list = new List<KhoaHocDTO>();

    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM KhaoHoc');
    print("Danh sach Khoa Hoc");
    print(listMap);

    for(int i  = 0 ; i < listMap.length ; i++)
    {
      list.add(new KhoaHocDTO(listMap[i]['MaKhoaHoc'], listMap[i]['NamHoc'], listMap[i]['HocKi']));
    }

    DataAccessHelper.closeDatabase();

    print(list[1].NamHoc);
    return list;
  }

  Future<KhoaHocDTO> selectByID(String ID) async {
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM KhoaHoc WHERE MaKhoaHoc = ?',
        [ID]);
    KhoaHocDTO result = new KhoaHocDTO(listMap[0]['MaKhoaHoc'], listMap[0]['NamHoc'], listMap[0]['HocKi']);

    print("Danh sach Khoa Hoc");
    print(result.toString());

    await DataAccessHelper.closeDatabase();
    return result;
  }

  Future insert(KhoaHocDTO khoahoc) async {
    Database database = await DataAccessHelper.connectDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Lop(MaKhoaHoc,NamHoc,HocKi) VALUES(?,?,?)',
          [
            khoahoc.MaKhoaHoc,
            khoahoc.NamHoc,
            khoahoc.HocKi

          ]);
    });
    await DataAccessHelper.closeDatabase();
  }

  Future update(KhoaHocDTO khoahoc) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database.rawUpdate(
        'UPDATE KhoaHoc SET  NamHoc= ?, HocKi= ? WHERE MaKhoaHoc = ?',
        [khoahoc.NamHoc,khoahoc.HocKi,khoahoc.MaKhoaHoc]);

    await DataAccessHelper.closeDatabase();
  }

  Future delete(String ID) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database
        .rawDelete('DELETE FROM Khoa WHERE MaKhoaHoc= ?', [ID]);

    await DataAccessHelper.closeDatabase();

  }
}
