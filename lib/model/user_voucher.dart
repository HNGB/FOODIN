class UserVoucher {
  int voucherId;
  String voucherName;
  String logo;
  String description;
  String expiredDate;

  UserVoucher({
    required this.voucherId,
    required this.voucherName,
    required this.logo,
    required this.description,
    required this.expiredDate,
  });

  factory UserVoucher.fromJson(Map<String, dynamic> json) {
    return UserVoucher(
      voucherId: json['voucherId'],
      voucherName: json['voucherName'],
      logo: json['logo'],
      description: json['description'],
      expiredDate: json['expiredDate'],
    );
  }
}
