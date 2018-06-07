import 'dart:async';

import 'package:my_school/models/TaiKhoanDTO.dart';
import 'package:my_school/services/daos/DataAccessHelper.dart';
import 'package:sqflite/sqflite.dart';

class TaiKhoanDAO {
  Future<List<TaiKhoanDTO>> select() async {
    List<TaiKhoanDTO> list = new List<TaiKhoanDTO>();

    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM TaiKhoan');
    print("Danh sach TK");
    print(listMap);
    
    for(int i  = 0 ; i < listMap.length ; i++)
    {
        list.add(new TaiKhoanDTO(listMap[i]['MaTaiKhoan'], listMap[i]['TenTaiKhoan'], listMap[i]['MatKhau'], listMap[i]['MaGV']));
    }
    
    DataAccessHelper.closeDatabase();
    
    print(list[1].TenTaiKhoan);
    return list;
  }

  Future<TaiKhoanDTO> selectByID(String ID) async {
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM TaiKhoan WHERE MaTaiKhoan = ?',
    [ID]);
    TaiKhoanDTO result = new TaiKhoanDTO(listMap[0]['MaTaiKhoan'], listMap[0]['TenTaiKhoan'], listMap[0]['MatKhau'], listMap[0]['MaGV']);

    print("Danh sach TK");
    print(result.toString());

    await DataAccessHelper.closeDatabase();
    return result;
  }

  Future insert(TaiKhoanDTO taikhoan) async {
    Database database = await DataAccessHelper.connectDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO TaiKhoan(MaTaiKhoan, TenTaiKhoan, MatKhau,MaGV) VALUES(?,?,?,?)',
          [
            taikhoan.MaTaiKhoan,
            taikhoan.TenTaiKhoan,
            taikhoan.MatKhau,
            taikhoan.MaGV
          ]);
    });
    await DataAccessHelper.closeDatabase();
  }

  Future update(TaiKhoanDTO taikhoan) async
  {
     Database database = await DataAccessHelper.connectDatabase();

     await database.rawUpdate(
         'UPDATE TaiKhoan SET  TenTaiKhoan = ?, MatKhau = ?, MaGV = ? WHERE MaTaiKhoan = ?',
         [taikhoan.TenTaiKhoan,taikhoan.MatKhau,taikhoan.MaGV,taikhoan.MaTaiKhoan]);

     await DataAccessHelper.closeDatabase();
  }

  Future delete(String ID) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database
        .rawDelete('DELETE FROM TaiKhoan WHERE MaTaiKhoan = ?', [ID]);

    await DataAccessHelper.closeDatabase();

  }
}