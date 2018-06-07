import 'dart:async';

import 'package:my_school/models/ChiTietGiangDayDTO.dart';
import 'package:my_school/models/schedule_item.dart';
import 'package:my_school/services/daos/DataAccessHelper.dart';
import 'package:sqflite/sqflite.dart';

class ChiTietGiangDayDAO {
  Future<List<ChiTietGiangDayDTO>> selectAllChiTietGiangDay() async {
    List<ChiTietGiangDayDTO> list = new List<ChiTietGiangDayDTO>();

    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM ChiTietGiangDay');
    print("Danh sach Chi Tiet Giang Day ");
    print(listMap);

    for(int i  = 0 ; i < listMap.length ; i++)
    {
      list.add(new ChiTietGiangDayDTO(listMap[i]['MaChiTietGiangDay'], listMap[i]['MaGV'], listMap[i]['MaLop'],listMap[i]['MaMon'],listMap[i]['MaKhoaHoc'],listMap[i]['Thu'],listMap[i]['Tiet']));
    }

    DataAccessHelper.closeDatabase();

    print(list[1].MaGV);
    return list;
  }

  Future<List<ScheduleItem>> selectAllScheduleByMaGV(String maGV) async{
    List<ScheduleItem> list = new List<ScheduleItem>();
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT MaChiTietGiangDay, Thu, Tiet, TenMon, TenLop FROM CHITIETGIANGDAY, MONHOC, LOP WHERE MAGV = ? and CHITIETGIANGDAY.MaMon = MONHOC.MaMon and CHITIETGIANGDAY.MaLop = LOP.MaLop',[maGV]);
    print("Danh sach Chi Tiet Giang Day ");
    print(listMap);

    for(int i  = 0 ; i < listMap.length ; i++)
    {
      list.add(new ScheduleItem(listMap[i]['MaChiTietGiangDay'], int.parse(listMap[i]['Thu']), int.parse(listMap[i]['Tiet']),listMap[i]['TenMon'],listMap[i]['TenLop']));
    }

    DataAccessHelper.closeDatabase();
    return list;
  }

  Future<List<ScheduleItem>> selectAllScheduleByMaLop (String maLop) async{
    List<ScheduleItem> list = new List<ScheduleItem>();
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT MaChiTietGiangDay, Thu, Tiet, TenMon, TenLop FROM CHITIETGIANGDAY, MONHOC, LOP WHERE CHITIETGIANGDAY.MALOP = ? and CHITIETGIANGDAY.MaMon = MONHOC.MaMon and CHITIETGIANGDAY.MaLop = LOP.MaLop',[maLop]);
    print("Danh sach Chi Tiet Giang Day ");
    print(listMap);

    for(int i  = 0 ; i < listMap.length ; i++)
    {
      list.add(new ScheduleItem(listMap[i]['MaChiTietGiangDay'], int.parse(listMap[i]['Thu']) , int.parse(listMap[i]['Tiet']),listMap[i]['TenMon'],listMap[i]['TenLop']));
    }

    DataAccessHelper.closeDatabase();
    return list;
  }

  Future<ChiTietGiangDayDTO> selectByID(String ID) async {
    Database database = await DataAccessHelper.connectDatabase();
    List<Map> listMap = await database.rawQuery('SELECT * FROM ChiTietGiangDay WHERE MaGV = ?',
        [ID]);
    ChiTietGiangDayDTO result = new ChiTietGiangDayDTO(listMap[0]['MaChiTietGiangDay'], listMap[0]['MaGV'], listMap[0]['MaLop'],listMap[0]['MaMon'],listMap[0]['MaKhoaHoc'],listMap[0]['Thu'],listMap[0]['Tiet']);

    print("Danh sach Chi Tiet Giang Day");
    print(result.toString());

    await DataAccessHelper.closeDatabase();
    return result;
  }

  Future insert(ChiTietGiangDayDTO chitiet) async {
    Database database = await DataAccessHelper.connectDatabase();
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Lop(MaChiTietGiangDay,MaGV, MaLop, MaMon,MaKhoaHoc,Thu,Tiet) VALUES(?,?,?,?,?,?,?)',
          [
            chitiet.MaChiTietGiangDay,
            chitiet.MaGV,
            chitiet.MaLop,
            chitiet.MaMon,
            chitiet.MaKhoaHoc,
            chitiet.Thu,
            chitiet.Tiet

          ]);
    });
    await DataAccessHelper.closeDatabase();
  }

  Future update(ChiTietGiangDayDTO chitiet) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database.rawUpdate(
        'UPDATE GiaoVien SET  MaGV= ?, MaLop= ?,MaMon= ?,MaKhoaHoc= ? ,Thu= ?, Tiet= ?  WHERE MaLop = ?',
        [chitiet.MaGV,chitiet.MaLop,chitiet.MaMon,chitiet.MaKhoaHoc,chitiet.Thu,chitiet.Tiet,chitiet.MaChiTietGiangDay]);

    await DataAccessHelper.closeDatabase();
  }

  Future delete(String ID) async
  {
    Database database = await DataAccessHelper.connectDatabase();

    await database
        .rawDelete('DELETE FROM ChiTietGiangDay WHERE MaChiTietGiangDay= ?', [ID]);

    await DataAccessHelper.closeDatabase();

  }
}
