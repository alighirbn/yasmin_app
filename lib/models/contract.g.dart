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
      payment: fields[20] as Payment,
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
      ..write(obj.payment);
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
      number: fields[0] as String,
      address: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Building obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.address);
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
      fullName: fields[0] as String,
      phone: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.phone);
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
      dueDate: fields[0] as String,
      amount: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Installment obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dueDate)
      ..writeByte(1)
      ..write(obj.amount);
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
      method: fields[1] as String,
      amount: fields[2] as double,
      status: fields[3] as String,
      transactionId: fields[4] as String,
      createdAt: fields[5] as String,
      updatedAt: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Payment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.method)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.transactionId)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
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
