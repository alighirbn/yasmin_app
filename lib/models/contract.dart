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
  final Payment payment;

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
    required this.payment,
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
      payment: Payment.fromJson(json['payment'] ?? {}),
    );
  }
}

@HiveType(typeId: 1)
class Building {
  @HiveField(0)
  final String number;

  @HiveField(1)
  final String address;

  Building({
    required this.number,
    required this.address,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      number: json['building_number'] ?? '',
      address: json['building_address'] ?? '',
    );
  }
}

@HiveType(typeId: 2)
class Customer {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String phone;

  Customer({
    required this.fullName,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      fullName: json['customer_full_name'] ?? '',
      phone: json['customer_phone'] ?? '',
    );
  }
}

@HiveType(typeId: 3)
class Installment {
  @HiveField(0)
  final String dueDate;

  @HiveField(1)
  final double amount;

  Installment({
    required this.dueDate,
    required this.amount,
  });

  factory Installment.fromJson(Map<String, dynamic> json) {
    return Installment(
      dueDate: json['installment_due_date'] ?? '',
      amount: (json['installment_amount'] is String)
          ? double.tryParse(json['installment_amount']) ?? 0.0
          : (json['installment_amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

@HiveType(typeId: 4)
class Payment {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String method;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final String transactionId;

  @HiveField(5)
  final String createdAt;

  @HiveField(6)
  final String? updatedAt;

  Payment({
    required this.id,
    required this.method,
    required this.amount,
    required this.status,
    required this.transactionId,
    required this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? 0,
      method: json['method'] ?? 'Unknown',
      amount: (json['amount'] is String)
          ? double.tryParse(json['amount']) ?? 0.0
          : (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'Unknown',
      transactionId: json['transaction_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'],
    );
  }
}
