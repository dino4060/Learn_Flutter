enum LoaiXe { xeMay, oto }

class BangGia {
  final LoaiXe loaiXe;
  final double giaTheoGio;
  final double giaToiDa;
  final double phuThuQuaDem;

  BangGia({
    required this.loaiXe,
    required this.giaTheoGio,
    required this.giaToiDa,
    required this.phuThuQuaDem,
  });

  static BangGia getGia(LoaiXe loaiXe) {
    switch (loaiXe) {
      case LoaiXe.xeMay:
        return BangGia(
          loaiXe: loaiXe,
          giaTheoGio: 3000,
          giaToiDa: 30000,
          phuThuQuaDem: 20000,
        );
      case LoaiXe.oto:
        return BangGia(
          loaiXe: loaiXe,
          giaTheoGio: 10000,
          giaToiDa: 200000,
          phuThuQuaDem: 80000,
        );
    }
  }
}

class Parking {
  final int id;
  final String bienSo;
  final LoaiXe loaiXe;
  final DateTime gioVao;
  DateTime? gioRa;
  double? tongThoiGian;
  double? thanhTien;

  Parking({
    required this.id,
    required this.bienSo,
    required this.loaiXe,
    required this.gioVao,
    this.gioRa,
    this.tongThoiGian,
    this.thanhTien,
  });

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
      id: json['id'],
      bienSo: json['bienSo'],
      loaiXe: LoaiXe.values[json['loaiXe']],
      gioVao: DateTime.parse(json['gioVao']),
      gioRa: json['gioRa'] != null ? DateTime.parse(json['gioRa']) : null,
      tongThoiGian: json['tongThoiGian']?.toDouble(),
      thanhTien: json['thanhTien']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bienSo': bienSo,
      'loaiXe': loaiXe.index,
      'gioVao': gioVao.toIso8601String(),
      'gioRa': gioRa?.toIso8601String(),
      'tongThoiGian': tongThoiGian,
      'thanhTien': thanhTien,
    };
  }

  String get loaiXeText {
    switch (loaiXe) {
      case LoaiXe.xeMay:
        return "Xe máy";
      case LoaiXe.oto:
        return "Ô tô";
    }
  }

  bool get isDaRa => gioRa != null;
}
