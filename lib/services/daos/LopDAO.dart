import 'dart:async';

import 'package:my_school/models/LopDTO.dart';
import 'package:my_school/services/daos/DataAccessHelper.dart';
import 'package:sqflite/sqflite.dart';

class LopDAO {
  Future<List<LopDTO>> select() async {
    List<LopDTO> list = new List<LopDTO>();

    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM Lop');
    print("Danh sach Lop");
    print(listMap);

    for(int i  = 0 ; i < listMap.length ; i++)
    {
      list.add(new LopDTO(listMap[i]['MaLop'], listMap[i]['MaGVCN'], listMap[i]['TenLop'],listMap[i]['PhongHoc']));
    }

    DataAccessHelper.closeDatabase();

    print(list[1].TenLop);
    return list;
  }

  Future<LopDTO> selectByID(String ID) async {
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM Lop WHERE MaLop = ?',
        [ID]);
    LopDTO result = new LopDTO(listMap[0]['MaLop'], listMap[0]['MaGVCN'], listMap[0]['TenLop'], listMap[0]['PhongHoc']);

    print("Danh sach Lop");
    print(result.toString());

    await DataAccessHelper.closeDatabase();
    return result;
  }

  Future insert(LopDTO lop) async {
    Database database = await DataAccessHelper.connectDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Lop(MaLop,MaGVCN, TenLop, PhongHoc) VALUES(?,?,?,?)',
          [
            lop.MaLop,
            lop.MaGVCN,
            lop.TenLop,
            lop.PhongHoc

          ]);
    });
    await DataAccessHelper.closeDatabase();
  }

  Future update(LopDTO lop) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database.rawUpdate(
        'UPDATE TenLop SET  MaGVCN= ?, PhongHoc= ? WHERE MaLop = ?',
        [lop.TenLop,lop.MaGVCN,lop.PhongHoc,lop.MaLop]);

    await DataAccessHelper.closeDatabase();
  }

  Future delete(String ID) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database
        .rawDelete('DELETE FROM Lop WHERE MaLop = ?', [ID]);

    await DataAccessHelper.closeDatabase();

  }
}
