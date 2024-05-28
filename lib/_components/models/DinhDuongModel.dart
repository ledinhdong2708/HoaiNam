class DinhDuongModel {
  final String beo;
  final String beoDinhMuc;
  final String buoiChinhChieu;
  final String buoiPhuChieu;
  final String buoiSang;
  final String buoiTrua;
  final String createDate;
  final String dam;
  final String damDinhMuc;
  final String docDate;
  final String duong;
  final String duongDinhMuc;
  final int id;
  final bool isCompleted;
  final String nangLuong;
  final String nangLuongDinhMuc;
  final int role;
  final String updateDate;
  final int userId;
  DinhDuongModel({
    required this.beo,
    required this.beoDinhMuc,
    required this.buoiChinhChieu,
    required this.buoiPhuChieu,
    required this.buoiSang,
    required this.buoiTrua,
    required this.createDate,
    required this.dam,
    required this.damDinhMuc,
    required this.docDate,
    required this.duong,
    required this.duongDinhMuc,
    required this.id,
    required this.isCompleted,
    required this.nangLuong,
    required this.nangLuongDinhMuc,
    required this.role,
    required this.updateDate,
    required this.userId,
  });
  factory DinhDuongModel.fromMap(Map<String, dynamic> json) {
    return DinhDuongModel(
        beo: json['beo'],
        beoDinhMuc: json['beoDinhMuc'],
        buoiChinhChieu: json['buoiChinhChieu'],
        buoiPhuChieu: json['buoiPhuChieu'],
        buoiSang: json['buoiSang'],
        buoiTrua: json['buoiTrua'],
        createDate: json['createDate'],
        dam: json['dam'],
        damDinhMuc: json['damDinhMuc'],
        docDate: json['docDate'],
        duong: json['duong'],
        duongDinhMuc: json['duongDinhMuc'],
        id: json['id'],
        isCompleted: json['isCompleted'],
        nangLuong: json['nangLuong'],
        nangLuongDinhMuc: json['nangLuongDinhMuc'],
        role: json['role'],
        updateDate: json['updateDate'],
        userId: json['userId']);
  }
}
