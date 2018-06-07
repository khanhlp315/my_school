import 'dart:async';

import 'package:my_school/DAO/DataAccessHelper.dart';
import 'package:my_school/DTO/GiaoVienDTO.dart';
import 'package:sqflite/sqflite.dart';

class GiaoVienDAO {
  Future<List<GiaoVienDTO>> select() async {
    List<GiaoVienDTO> list = new List<GiaoVienDTO>();

    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM GiaoVien');
    print("Danh sach Giao Vien");
    print(listMap);

    for(int i  = 0 ; i < listMap.length ; i++)
    {
      list.add(new GiaoVienDTO(listMap[0]['MaGV'], listMap[0]['TenGV'], listMap[0]['MucLuong'],listMap[0]['ChucVu']));
    }

    DataAccessHelper.closeDatabase();

    print(list[1].TenGV);
    return list;
  }

  Future<GiaoVienDTO> selectByID(String ID) async {
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM GiaoVien WHERE MaGV = ?',
        [ID]);
    GiaoVienDTO result = new GiaoVienDTO(listMap[0]['MaGV'], listMap[0]['TenGV'], listMap[0]['MucLuong'], listMap[0]['ChucVu']);

    print("Danh sach Giao Vien");
    print(result.toString());

    await DataAccessHelper.closeDatabase();
    return result;
  }

  Future insert(GiaoVienDTO giaovien) async {
    Database database = await DataAccessHelper.connectDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Lop(MaGV,TenGV, MucLuong, ChucVu) VALUES(?,?,?,?)',
          [
            giaovien.MaGV,
            giaovien.TenGV,
            giaovien.MucLuong,
            giaovien.ChucVu

          ]);
    });
    await DataAccessHelper.closeDatabase();
  }

  Future update(GiaoVienDTO giaovien) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database.rawUpdate(
        'UPDATE GiaoVien SET  TenGV= ?, MucLuong= ?,ChucVu= ? WHERE MaLop = ?',
        [giaovien.TenGV,giaovien.MucLuong,giaovien.ChucVu,giaovien.MaGV]);

    await DataAccessHelper.closeDatabase();
  }

  Future delete(String ID) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database
        .rawDelete('DELETE FROM GiaoVien WHERE MaGV= ?', [ID]);

    await DataAccessHelper.closeDatabase();

  }
}
