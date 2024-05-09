import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class dbaseProvider extends ChangeNotifier {
  Database? _database;
  Database? get database => _database;
  List<Map<String, dynamic>> trainer = [];
  List<Map<String, dynamic>> pokemon = [];
  List<Map<String, dynamic>> transactions = [];

  Future<void> doAsyncwork(VoidCallback? onAsyncComplete) async {
    await openDatabase();
    // If you remove the below statements, you will have to set trainer, pokemon, transaction variables whenever you would be using them
    print("Database opened, now calling setTrainer...");
    await setTrainer();
    print("setTrainer completed, now calling setPokemon...");
    await setPokemon();
    print("setPokemon completed");
    await setTransactions();
    print("setTransactions completed");
    if (onAsyncComplete != null) onAsyncComplete();
  }

  // dbaseProvider() {
  //   doAsyncwork;
  // }

  Future<void> openDatabase() async {
    // Initialize the SQFlite FFI library
    print("Opening database...");
    sqfliteFfiInit();
    // Open the database
    _database = await databaseFactoryFfi.openDatabase('pokeball.db');
    print("Database opened successfully!");
    // Notify listeners that the database has been opened
    notifyListeners();
  }

  Future<void> closeDatabase() async {
    // Close the database
    await _database?.close();
    // Notify listeners that the database has been closed
    notifyListeners();
  }

  Future<void> setTrainer() async {
    // Initialize trainer to an empty list
    trainer = [];
    var mydata = await _database?.query('Trainer');
    if (mydata != null) {
      trainer = mydata.map((e) => e as Map<String, dynamic>).toList();
      // Notify listeners that the database has been updated
      notifyListeners();
    } else {
      print("Error: Set Trainer func; Trainer data is not available");
    }
  }

  Future<void> setPokemon() async {
    pokemon = [];
    var mydata = await _database?.query('Pokemon');
    if (mydata != null) {
      pokemon = mydata.map((e) => e as Map<String, dynamic>).toList();

      // Notify listeners that the database has been updated
      notifyListeners();
    } else {
      print("Error: Set Pokemon func; Pokemon data is not available");
    }
  }

  Future<void> setTransactions() async {
    try {
      var mydata = await _database?.query('Transactions');
      print(
          "Trying to fetch transactions. Found: ${mydata?.length} entries"); // This will give you the count
      if (mydata != null && mydata.isNotEmpty) {
        transactions = mydata.map((e) => e as Map<String, dynamic>).toList();
        // print("Successfully set transactions: $transactions"); // This will output the transactions
        notifyListeners();
      } else {
        print(
            "Error: Set Transactions func; Transactions data is not available or empty");
      }
    } catch (e) {
      print("Error while setting transactions: $e");
    }
  }

  void updateTransactions(List<Map<String, dynamic>> newData) {
    transactions = newData;
    notifyListeners(); // This is important to trigger the Consumer to rebuild
  }

  Future<List<Map<String, dynamic>>> executeRawQueryWithParams(
      String sql, List<dynamic> params) async {
    try {
      final rawData = await _database?.rawQuery(sql, params);
      if (rawData != null) {
        return rawData.map((e) => e as Map<String, dynamic>).toList();
      } else {
        print("No data returned from the query");
        return [];
      }
    } catch (e) {
      print("There was an error executing the query with parameters: $e");
      return [];
    }
  }

  Future<void> executeRawQuery(String sql) async {
  try {
   await _database?.execute(sql);
    print('_____________');
   
    print('__________');
    
  } catch (e) {
    print("There was an error executing the query: $e");
    
  }
}

  List<Map<String, dynamic>>? getTrainerData() {
    return trainer;
  }

  List<Map<String, dynamic>>? getPokemonData() {
    return pokemon;
  }

  List<Map<String, dynamic>>? getTransactionsData() {
    return transactions;
  }
  
 Future<List<Map<String, dynamic>>> fetchData(String query) async {
  await openDatabase();
  print(_database);
  
  return await _database!.rawQuery(query);
}

 Future<int> execQuery(String query) async {
  await openDatabase();
  print(_database);
  await _database!.rawQuery(query);
  return 1;
}



 Future<void> addTransaction(Transaction transaction) async {
     await openDatabase();
    await _database!.insert(
      'Transactions', // Table name
      transaction.toMap(), 
    );
  }


}




class Transaction{
  Transaction(this.customerName,this.hsn,this.dateOfPurchase,this.amountPaid,this.natureOfPurchase);
  String customerName;
  int hsn;
  String dateOfPurchase;
  double amountPaid;
  String natureOfPurchase;
    Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'hsn': hsn,
      'dateOfPurchase': dateOfPurchase,
      'amountPaid': amountPaid,
      'natureOfPurchase': natureOfPurchase,
    };
  }
}