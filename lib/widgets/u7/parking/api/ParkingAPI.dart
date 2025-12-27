import 'package:flutter_application_1/widgets/u7/parking/models/Parking.dart';

class ParkingAPI {
  static final List<Parking> parkings = [];

  static Future<List<Parking>> getParkings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(parkings);
  }

  static void addVehicleEntry(String bienSo, LoaiXe loaiXe, DateTime gioVao) {
    final parking = Parking(
      id: DateTime.now().millisecondsSinceEpoch,
      bienSo: bienSo,
      loaiXe: loaiXe,
      gioVao: gioVao,
    );
    parkings.add(parking);
  }

  static void recordExit(int id, DateTime gioRa) {
    final index = parkings.indexWhere((p) => p.id == id);
    if (index != -1) {
      parkings[index].gioRa = gioRa;
    }
  }

  static Map<String, dynamic> calculateFee(Parking parking) {
    if (parking.gioRa == null) {
      return {
        'tongThoiGian': 0.0,
        'soGio': 0.0,
        'phuThuQuaDem': 0.0,
        'thanhTien': 0.0,
      };
    }

    final duration = parking.gioRa!.difference(parking.gioVao);
    final tongThoiGian = duration.inMinutes / 60.0;
    final soGio = tongThoiGian.ceil();

    final bangGia = BangGia.getGia(parking.loaiXe);

    bool isQuaDem = false;
    if (parking.gioVao.day != parking.gioRa!.day) {
      final gioVaoHour = parking.gioVao.hour;
      final gioRaHour = parking.gioRa!.hour;
      // if (gioVaoHour >= 18 || gioRaHour <= 6) {
      if (gioVaoHour >= 22 || gioRaHour <= 23) {
        isQuaDem = true;
      }
      if (gioVaoHour >= 0 || gioRaHour <= 7) {
        isQuaDem = true;
      }
    }

    double tienGio = soGio * bangGia.giaTheoGio;
    if (tienGio > bangGia.giaToiDa) {
      tienGio = bangGia.giaToiDa;
    }

    double phuThuQuaDem = isQuaDem ? bangGia.phuThuQuaDem : 0;
    double thanhTien = tienGio + phuThuQuaDem;

    parking.tongThoiGian = tongThoiGian;
    parking.thanhTien = thanhTien;

    return {
      'tongThoiGian': tongThoiGian,
      'soGio': soGio,
      'tienGio': tienGio,
      'phuThuQuaDem': phuThuQuaDem,
      'thanhTien': thanhTien,
      'isQuaDem': isQuaDem,
    };
  }

  static Map<String, dynamic> getStatistics(DateTime date, bool isMonthly) {
    List<Parking> filtered;

    if (isMonthly) {
      filtered = parkings.where((p) {
        return p.gioVao.year == date.year && p.gioVao.month == date.month;
      }).toList();
    } else {
      filtered = parkings.where((p) {
        return p.gioVao.year == date.year &&
            p.gioVao.month == date.month &&
            p.gioVao.day == date.day;
      }).toList();
    }

    int tongXe = filtered.length;
    int xeMay = filtered.where((p) => p.loaiXe == LoaiXe.xeMay).length;
    int oto = filtered.where((p) => p.loaiXe == LoaiXe.oto).length;
    double tongDoanhThu = filtered
        .where((p) => p.thanhTien != null)
        .fold(0, (sum, p) => sum + p.thanhTien!);

    return {
      'tongXe': tongXe,
      'xeMay': xeMay,
      'oto': oto,
      'tongDoanhThu': tongDoanhThu,
      'filtered': filtered,
    };
  }
}
