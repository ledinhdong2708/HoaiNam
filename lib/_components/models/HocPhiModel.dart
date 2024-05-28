// class DataHocPhiModel {
//   final dynamic data;
//   final String error;
//   final String errorCode;
//   final HocPhiModel hocPhis;
//   final bool success;
//
//   DataHocPhiModel(
//       {required this.data,
//       required this.error,
//       required this.errorCode,
//       required this.hocPhis,
//       required this.success});
//   factory DataHocPhiModel.fromMap(Map<String, dynamic> json) {
//     return DataHocPhiModel(
//         data: json['data'],
//         error: json['error'],
//         errorCode: json['errorCode'],
//         hocPhis: json['hocPhis'],
//         success: json['success']);
//   }
// }

class HocPhiModel {
  final String content;
  final String createDate;
  final int id;
  final int studentId;
  final double totalMax;
  final double totalMin;
  final String updateDate;
  final int userId;
  final ChiTietHocPhi chiTietHocPhis;

  HocPhiModel(
      {required this.content,
      required this.createDate,
      required this.id,
      required this.studentId,
      required this.totalMax,
      required this.totalMin,
      required this.updateDate,
      required this.userId,
      required this.chiTietHocPhis});
  factory HocPhiModel.fromMap(Map<String, dynamic> json) {
    final chiTietHocPhis = ChiTietHocPhi.fromMap(json['chiTietHocPhis']);
    return HocPhiModel(
        content: json['content'],
        createDate: json['createDate'],
        id: json['id'],
        studentId: json['studentId'],
        totalMax: json['totalMax'],
        totalMin: json['totalMin'],
        updateDate: json['updateDate'],
        userId: json['userId'],
        chiTietHocPhis: chiTietHocPhis);
  }
}

class ChiTietHocPhi {
  final String content;
  final String createDate;
  final String expDate;
  final int hocPhiId;
  final int id;
  final String months;
  final int studentId;
  final double total;
  final String updateDate;
  final int userId;
  final String years;
  final ChiTietHocPhiTheoMonth chiTietHocPhiTheoMonths;

  ChiTietHocPhi(
      {required this.content,
      required this.createDate,
      required this.expDate,
      required this.hocPhiId,
      required this.id,
      required this.months,
      required this.studentId,
      required this.total,
      required this.updateDate,
      required this.userId,
      required this.years,
      required this.chiTietHocPhiTheoMonths});
  factory ChiTietHocPhi.fromMap(Map<String, dynamic> json) {

    final chiTietHocPhiTheoMonths = ChiTietHocPhiTheoMonth.fromMap(json['chiTietHocPhiTheoMonths']);
    return ChiTietHocPhi(
        content: json['content'],
        createDate: json['createDate'],
        expDate: json['expDate'],
        hocPhiId: json['hocPhiId'],
        id: json['id'],
        months: json['months'],
        studentId: json['studentId'],
        total: json['total'],
        updateDate: json['updateDate'],
        userId: json['userId'],
        years: json['years'],
        chiTietHocPhiTheoMonths: chiTietHocPhiTheoMonths);
  }
}

class ChiTietHocPhiTheoMonth {
  final String content;
  final String createDate;
  final int hocPhiChiTietId;
  final int id;
  final String months;
  final int studentId;
  final double total;
  final String updateDate;
  final int userId;
  final String years;
  ChiTietHocPhiTheoMonth({
    required this.content,
    required this.createDate,
    required this.hocPhiChiTietId,
    required this.id,
    required this.months,
    required this.studentId,
    required this.total,
    required this.updateDate,
    required this.userId,
    required this.years,
  });
  factory ChiTietHocPhiTheoMonth.fromMap(Map<String, dynamic> json) {
    return ChiTietHocPhiTheoMonth(
        content: json['content'],
        createDate: json['createDate'],
        hocPhiChiTietId: json['hocPhiChiTietId'],
        id: json['id'],
        months: json['months'],
        studentId: json['studentId'],
        total: json['total'],
        updateDate: json['updateDate'],
        userId: json['userId'],
        years: json['years']);
  }
}
