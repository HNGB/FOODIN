class Voucher {
  int voucherId;
  String voucherName;
  String logo;
  String description;
  int price;
  int quantity;
  int status;
  List<dynamic>? userVouchers;

  Voucher(
      {required this.voucherId,
      required this.voucherName,
      required this.logo,
      required this.description,
      required this.price,
      required this.quantity,
      required this.status,
      this.userVouchers});

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      voucherId: json['voucherId'],
      voucherName: json['voucherName'],
      logo: json['logo'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      status: json['status'],
      userVouchers: json['userVouchers'],
    );
  }
}
