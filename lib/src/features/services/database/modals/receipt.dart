final class ReceiptModal {
  final int id;
  final String? createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final int deleted;
  final String uuid;
  final int active;
  final String receiptNumber;
  final double amount;
  final double vat;
  final double tozo;
  final int businessProfile;
  final int clientProfile;

  ReceiptModal(
      {required this.id,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      required this.deleted,
      required this.uuid,
      required this.active,
      required this.receiptNumber,
      required this.amount,
      required this.vat,
      required this.tozo,
      required this.businessProfile,
      required this.clientProfile});
}

final class BusinessProfile {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String uuid;
  final int active;
  final int deleted;
  final String businessName;
  final String region;
  final String district;
  final String tinNumber;
  final String businessRegNumber;
  final String? businessType;

  BusinessProfile(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      required this.deleted,
      required this.uuid,
      required this.active,
      required this.businessName,
      required this.region,
      required this.tinNumber,
      required this.businessRegNumber,
      required this.district,
      this.businessType});
}

final class ClientProfile {
  final int id;
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String uuid;
  final int deleted;
  final String fullName;
  final String username;
  final String tinNumber;
  final String phone;
  final String userType;

  ClientProfile(
      {required this.id,
      required this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      required this.deleted,
      required this.uuid,
      required this.fullName,
      required this.username,
      required this.tinNumber,
      required this.phone,
      required this.userType});
}

final class ReceiptItem {
  final int? id;
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String uuid;
  final int active;
  final int deleted;
  final double amount;
  final String productName;
  final String businessRegNumber;

  ReceiptItem(
      {this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.createdBy,
      required this.updatedBy,
      required this.uuid,
      required this.active,
      required this.deleted,
      required this.amount,
      required this.businessRegNumber,
      required this.productName});
}

final class ReceiptProducts {
  final int productId;
  final String receiptNumber;

  ReceiptProducts({required this.productId, required this.receiptNumber});
}
