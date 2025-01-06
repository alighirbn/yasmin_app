import 'package:hive/hive.dart';

part 'contract.g.dart';

@HiveType(typeId: 0)
class Contract extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int userIdCreate;

  @HiveField(2)
  final int? userIdUpdate;

  @HiveField(3)
  final int contractCustomerId;

  @HiveField(4)
  final int contractBuildingId;

  @HiveField(5)
  final int contractPaymentMethodId;

  @HiveField(6)
  final String urlAddress;

  @HiveField(7)
  final double contractAmount;

  @HiveField(8)
  final String contractDate;

  @HiveField(9)
  final String contractNote;

  @HiveField(10)
  final String stage;

  @HiveField(11)
  final String temporaryAt;

  @HiveField(12)
  final String? acceptedAt;

  @HiveField(13)
  final String? authenticatedAt;

  @HiveField(14)
  final String createdAt;

  @HiveField(15)
  final String updatedAt;

  @HiveField(16)
  bool synced;

  @HiveField(17)
  final Building building;

  @HiveField(18)
  final Customer customer;

  @HiveField(19)
  final List<Installment> contractInstallments;

  @HiveField(20)
  final List<Payment> payments;

  Contract({
    required this.id,
    required this.userIdCreate,
    this.userIdUpdate,
    required this.contractCustomerId,
    required this.contractBuildingId,
    required this.contractPaymentMethodId,
    required this.urlAddress,
    required this.contractAmount,
    required this.contractDate,
    required this.contractNote,
    required this.stage,
    required this.temporaryAt,
    this.acceptedAt,
    this.authenticatedAt,
    required this.createdAt,
    required this.updatedAt,
    this.synced = false,
    required this.building,
    required this.customer,
    required this.contractInstallments,
    required this.payments,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      id: json['id'] ?? 0,
      userIdCreate: json['user_id_create'] ?? 0,
      userIdUpdate: json['user_id_update'],
      contractCustomerId: json['contract_customer_id'] ?? 0,
      contractBuildingId: json['contract_building_id'] ?? 0,
      contractPaymentMethodId: json['contract_payment_method_id'] ?? 0,
      urlAddress: json['url_address'] ?? '',
      contractAmount: (json['contract_amount'] is String)
          ? double.tryParse(json['contract_amount']) ?? 0.0
          : (json['contract_amount'] as num?)?.toDouble() ?? 0.0,
      contractDate: json['contract_date'] ?? '',
      contractNote: json['contract_note'] ?? '',
      stage: json['stage'] ?? '',
      temporaryAt: json['temporary_at'] ?? '',
      acceptedAt: json['accepted_at'],
      authenticatedAt: json['authenticated_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      synced: false,
      building: Building.fromJson(json['building'] ?? {}),
      customer: Customer.fromJson(json['customer'] ?? {}),
      contractInstallments: (json['contract_installments'] as List?)
          ?.map((installment) => Installment.fromJson(installment ?? {}))
          .toList() ??
          [],
      payments: (json['payments'] as List?)
          ?.map((payment) => Payment.fromJson(payment ?? {}))
          .toList() ??
          [],
    );
  }
}

@HiveType(typeId: 1)
class Building {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int? userIdCreate;

  @HiveField(2)
  final int? userIdUpdate;

  @HiveField(3)
  final int buildingCategoryId;

  @HiveField(4)
  final int buildingTypeId;

  @HiveField(5)
  final int classificationId;

  @HiveField(6)
  final String urlAddress;

  @HiveField(7)
  final int hidden;

  @HiveField(8)
  final String buildingNumber;

  @HiveField(9)
  final String houseNumber;

  @HiveField(10)
  final String blockNumber;

  @HiveField(11)
  final String buildingArea;

  @HiveField(12)
  final String buildingMapX;

  @HiveField(13)
  final String buildingMapY;

  @HiveField(14)
  final String? createdAt;

  @HiveField(15)
  final String? updatedAt;

  Building({
    required this.id,
    this.userIdCreate,
    this.userIdUpdate,
    required this.buildingCategoryId,
    required this.buildingTypeId,
    required this.classificationId,
    required this.urlAddress,
    required this.hidden,
    required this.buildingNumber,
    required this.houseNumber,
    required this.blockNumber,
    required this.buildingArea,
    required this.buildingMapX,
    required this.buildingMapY,
    this.createdAt,
    this.updatedAt,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      id: json['id'] ?? 0,
      userIdCreate: json['user_id_create'],
      userIdUpdate: json['user_id_update'],
      buildingCategoryId: json['building_category_id'] ?? 0,
      buildingTypeId: json['building_type_id'] ?? 0,
      classificationId: json['classification_id'] ?? 0,
      urlAddress: json['url_address'] ?? '',
      hidden: json['hidden'] ?? 0,
      buildingNumber: json['building_number'] ?? '',
      houseNumber: json['house_number'] ?? '',
      blockNumber: json['block_number'] ?? '',
      buildingArea: json['building_area'] ?? '',
      buildingMapX: json['building_map_x'] ?? '',
      buildingMapY: json['building_map_y'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

@HiveType(typeId: 2)
class Customer {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int? userIdCreate;

  @HiveField(2)
  final int? userIdUpdate;

  @HiveField(3)
  final String urlAddress;

  @HiveField(4)
  final String customerFullName;

  @HiveField(5)
  final String customerPhone;

  @HiveField(6)
  final String customerEmail;

  @HiveField(7)
  final String customerCardNumber;

  @HiveField(8)
  final String customerCardIssudAuth;

  @HiveField(9)
  final String customerCardIssudDate;

  @HiveField(10)
  final String motherFullName;

  @HiveField(11)
  final String fullAddress;

  @HiveField(12)
  final String addressCardNumber;

  @HiveField(13)
  final String saleman;

  @HiveField(14)
  final String createdAt;

  @HiveField(15)
  final String updatedAt;

  Customer({
    required this.id,
    this.userIdCreate,
    this.userIdUpdate,
    required this.urlAddress,
    required this.customerFullName,
    required this.customerPhone,
    required this.customerEmail,
    required this.customerCardNumber,
    required this.customerCardIssudAuth,
    required this.customerCardIssudDate,
    required this.motherFullName,
    required this.fullAddress,
    required this.addressCardNumber,
    required this.saleman,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? 0,
      userIdCreate: json['user_id_create'],
      userIdUpdate: json['user_id_update'],
      urlAddress: json['url_address'] ?? '',
      customerFullName: json['customer_full_name'] ?? '',
      customerPhone: json['customer_phone'] ?? '',
      customerEmail: json['customer_email'] ?? '',
      customerCardNumber: json['customer_card_number'] ?? '',
      customerCardIssudAuth: json['customer_card_issud_auth'] ?? '',
      customerCardIssudDate: json['customer_card_issud_date'] ?? '',
      motherFullName: json['mother_full_name'] ?? '',
      fullAddress: json['full_address'] ?? '',
      addressCardNumber: json['address_card_number'] ?? '',
      saleman: json['saleman'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

@HiveType(typeId: 3)
class Installment {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int userIdCreate;

  @HiveField(2)
  final int? userIdUpdate;

  @HiveField(3)
  final int contractId;

  @HiveField(4)
  final int installmentId;

  @HiveField(5)
  final String urlAddress;

  @HiveField(6)
  final double installmentAmount;

  @HiveField(7)
  final String installmentDate;

  @HiveField(8)
  final int paid;

  @HiveField(9)
  final String createdAt;

  @HiveField(10)
  final String updatedAt;

  Installment({
    required this.id,
    required this.userIdCreate,
    this.userIdUpdate,
    required this.contractId,
    required this.installmentId,
    required this.urlAddress,
    required this.installmentAmount,
    required this.installmentDate,
    required this.paid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Installment.fromJson(Map<String, dynamic> json) {
    return Installment(
      id: json['id'] ?? 0,
      userIdCreate: json['user_id_create'] ?? 0,
      userIdUpdate: json['user_id_update'],
      contractId: json['contract_id'] ?? 0,
      installmentId: json['installment_id'] ?? 0,
      urlAddress: json['url_address'] ?? '',
      installmentAmount: (json['installment_amount'] is String)
          ? double.tryParse(json['installment_amount']) ?? 0.0
          : (json['installment_amount'] as num?)?.toDouble() ?? 0.0,
      installmentDate: json['installment_date'] ?? '',
      paid: json['paid'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

@HiveType(typeId: 4)
class Payment {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int userIdCreate;

  @HiveField(2)
  final int? userIdUpdate;

  @HiveField(3)
  final int paymentContractId;

  @HiveField(4)
  final int contractInstallmentId;

  @HiveField(5)
  final int cashAccountId;

  @HiveField(6)
  final String urlAddress;

  @HiveField(7)
  final double paymentAmount;

  @HiveField(8)
  final String paymentDate;

  @HiveField(9)
  final String? paymentNote;

  @HiveField(10)
  final int approved;

  @HiveField(11)
  final String createdAt;

  @HiveField(12)
  final String updatedAt;

  Payment({
    required this.id,
    required this.userIdCreate,
    this.userIdUpdate,
    required this.paymentContractId,
    required this.contractInstallmentId,
    required this.cashAccountId,
    required this.urlAddress,
    required this.paymentAmount,
    required this.paymentDate,
    this.paymentNote,
    required this.approved,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? 0,
      userIdCreate: json['user_id_create'] ?? 0,
      userIdUpdate: json['user_id_update'],
      paymentContractId: json['payment_contract_id'] ?? 0,
      contractInstallmentId: json['contract_installment_id'] ?? 0,
      cashAccountId: json['cash_account_id'] ?? 0,
      urlAddress: json['url_address'] ?? '',
      paymentAmount: (json['payment_amount'] is String)
          ? double.tryParse(json['payment_amount']) ?? 0.0
          : (json['payment_amount'] as num?)?.toDouble() ?? 0.0,
      paymentDate: json['payment_date'] ?? '',
      paymentNote: json['payment_note'],
      approved: json['approved'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}