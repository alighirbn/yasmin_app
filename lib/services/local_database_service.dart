import 'package:hive/hive.dart';
import '../models/contract.dart';

class LocalDatabaseService {
  final Box contractBox = Hive.box('contractsBox');

  Future<void> insertContract(Contract contract) async {
    await contractBox.add(contract);
  }

  Future<List<Contract>> fetchContracts() async {
    return contractBox.values.toList().cast<Contract>();
  }

  Future<void> markAsSynced(int index) async {
    final contract = contractBox.getAt(index);
    if (contract != null) {
      contract.synced = true;
      await contract.save();
    }
  }
}