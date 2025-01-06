// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContractAdapter extends TypeAdapter<Contract> {
  @override
  final int typeId = 0;

  @override
  Contract read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contract(
      id: fields[0] as int,
      userIdCreate: fields[1] as int,
      userIdUpdate: fields[2] as int?,
      contractCustomerId: fields[3] as int,
      contractBuildingId: fields[4] as int,
      contractPaymentMethodId: fields[5] as int,
      urlAddress: fields[6] as String,
      contractAmount: fields[7] as double,
      contractDate: fields[8] as String,
      contractNote: fields[9] as String,
      stage: fields[10] as String,
      temporaryAt: fields[11] as String,
      acceptedAt: fields[12] as String?,
      authenticatedAt: fields[13] as String?,
      createdAt: fields[14] as String,
      updatedAt: fields[15] as String,
      synced: fields[16] as bool,
      building: fields[17] as Building,
      customer: fields[18] as Customer,
      contractInstallments: (fields[19] as List).cast<Installment>(),
      payments: (fields[20] as List).cast<Payment>(),
    );
  }

  @override
  void write(BinaryWriter writer, Contract obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userIdCreate)
      ..writeByte(2)
      ..write(obj.userIdUpdate)
      ..writeByte(3)
      ..write(obj.contractCustomerId)
      ..writeByte(4)
      ..write(obj.contractBuildingId)
      ..writeByte(5)
      ..write(obj.contractPaymentMethodId)
      ..writeByte(6)
      ..write(obj.urlAddress)
      ..writeByte(7)
      ..write(obj.contractAmount)
      ..writeByte(8)
      ..write(obj.contractDate)
      ..writeByte(9)
      ..write(obj.contractNote)
      ..writeByte(10)
      ..write(obj.stage)
      ..writeByte(11)
      ..write(obj.temporaryAt)
      ..writeByte(12)
      ..write(obj.acceptedAt)
      ..writeByte(13)
      ..write(obj.authenticatedAt)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt)
      ..writeByte(16)
      ..write(obj.synced)
      ..writeByte(17)
      ..write(obj.building)
      ..writeByte(18)
      ..write(obj.customer)
      ..writeByte(19)
      ..write(obj.contractInstallments)
      ..writeByte(20)
      ..write(obj.payments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BuildingAdapter extends TypeAdapter<Building> {
  @override
  final int typeId = 1;

  @override
  Building read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Building(
      id: fields[0] as int,
      userIdCreate: fields[1] as int?,
      userIdUpdate: fields[2] as int?,
      buildingCategoryId: fields[3] as int,
      buildingTypeId: fields[4] as int,
      classificationId: fields[5] as int,
      urlAddress: fields[6] as String,
      hidden: fields[7] as int,
      buildingNumber: fields[8] as String,
      houseNumber: fields[9] as String,
      blockNumber: fields[10] as String,
      buildingArea: fields[11] as String,
      buildingMapX: fields[12] as String,
      buildingMapY: fields[13] as String,
      createdAt: fields[14] as String?,
      updatedAt: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Building obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userIdCreate)
      ..writeByte(2)
      ..write(obj.userIdUpdate)
      ..writeByte(3)
      ..write(obj.buildingCategoryId)
      ..writeByte(4)
      ..write(obj.buildingTypeId)
      ..writeByte(5)
      ..write(obj.classificationId)
      ..writeByte(6)
      ..write(obj.urlAddress)
      ..writeByte(7)
      ..write(obj.hidden)
      ..writeByte(8)
      ..write(obj.buildingNumber)
      ..writeByte(9)
      ..write(obj.houseNumber)
      ..writeByte(10)
      ..write(obj.blockNumber)
      ..writeByte(11)
      ..write(obj.buildingArea)
      ..writeByte(12)
      ..write(obj.buildingMapX)
      ..writeByte(13)
      ..write(obj.buildingMapY)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 2;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      id: fields[0] as int,
      userIdCreate: fields[1] as int?,
      userIdUpdate: fields[2] as int?,
      urlAddress: fields[3] as String,
      customerFullName: fields[4] as String,
      customerPhone: fields[5] as String,
      customerEmail: fields[6] as String,
      customerCardNumber: fields[7] as String,
      customerCardIssudAuth: fields[8] as String,
      customerCardIssudDate: fields[9] as String,
      motherFullName: fields[10] as String,
      fullAddress: fields[11] as String,
      addressCardNumber: fields[12] as String,
      saleman: fields[13] as String,
      createdAt: fields[14] as String,
      updatedAt: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userIdCreate)
      ..writeByte(2)
      ..write(obj.userIdUpdate)
      ..writeByte(3)
      ..write(obj.urlAddress)
      ..writeByte(4)
      ..write(obj.customerFullName)
      ..writeByte(5)
      ..write(obj.customerPhone)
      ..writeByte(6)
      ..write(obj.customerEmail)
      ..writeByte(7)
      ..write(obj.customerCardNumber)
      ..writeByte(8)
      ..write(obj.customerCardIssudAuth)
      ..writeByte(9)
      ..write(obj.customerCardIssudDate)
      ..writeByte(10)
      ..write(obj.motherFullName)
      ..writeByte(11)
      ..write(obj.fullAddress)
      ..writeByte(12)
      ..write(obj.addressCardNumber)
      ..writeByte(13)
      ..write(obj.saleman)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InstallmentAdapter extends TypeAdapter<Installment> {
  @override
  final int typeId = 3;

  @override
  Installment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Installment(
      id: fields[0] as int,
      userIdCreate: fields[1] as int,
      userIdUpdate: fields[2] as int?,
      contractId: fields[3] as int,
      installmentId: fields[4] as int,
      urlAddress: fields[5] as String,
      installmentAmount: fields[6] as double,
      installmentDate: fields[7] as String,
      paid: fields[8] as int,
      createdAt: fields[9] as String,
      updatedAt: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Installment obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userIdCreate)
      ..writeByte(2)
      ..write(obj.userIdUpdate)
      ..writeByte(3)
      ..write(obj.contractId)
      ..writeByte(4)
      ..write(obj.installmentId)
      ..writeByte(5)
      ..write(obj.urlAddress)
      ..writeByte(6)
      ..write(obj.installmentAmount)
      ..writeByte(7)
      ..write(obj.installmentDate)
      ..writeByte(8)
      ..write(obj.paid)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstallmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentAdapter extends TypeAdapter<Payment> {
  @override
  final int typeId = 4;

  @override
  Payment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payment(
      id: fields[0] as int,
      userIdCreate: fields[1] as int,
      userIdUpdate: fields[2] as int?,
      paymentContractId: fields[3] as int,
      contractInstallmentId: fields[4] as int,
      cashAccountId: fields[5] as int,
      urlAddress: fields[6] as String,
      paymentAmount: fields[7] as double,
      paymentDate: fields[8] as String,
      paymentNote: fields[9] as String?,
      approved: fields[10] as int,
      createdAt: fields[11] as String,
      updatedAt: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Payment obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userIdCreate)
      ..writeByte(2)
      ..write(obj.userIdUpdate)
      ..writeByte(3)
      ..write(obj.paymentContractId)
      ..writeByte(4)
      ..write(obj.contractInstallmentId)
      ..writeByte(5)
      ..write(obj.cashAccountId)
      ..writeByte(6)
      ..write(obj.urlAddress)
      ..writeByte(7)
      ..write(obj.paymentAmount)
      ..writeByte(8)
      ..write(obj.paymentDate)
      ..writeByte(9)
      ..write(obj.paymentNote)
      ..writeByte(10)
      ..write(obj.approved)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
