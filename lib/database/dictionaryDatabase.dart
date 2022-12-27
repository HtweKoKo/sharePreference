
import 'dart:io';

import 'package:dictionary_app/database/dictionaryDao.dart';
import 'package:dictionary_app/database/dictionaryTable.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
part 'dictionaryDatabase.g.dart';
@DriftDatabase(tables: [DictionaryTable],daos: [DictionaryDao])
class DictionaryDatabase extends _$DictionaryDatabase {
  DictionaryDatabase() : super(_openDatabase());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;


}

LazyDatabase _openDatabase(){

return LazyDatabase(()async{

    final dbfolder = await getApplicationDocumentsDirectory();
    final dbfile = File(join(dbfolder.path,"engineering.db"));

    if(! await dbfile.exists()){
      final blob  = await rootBundle.load("assets/engineering.db");
      final buffer = blob.buffer;
      await dbfile.writeAsBytes(buffer.asUint8List(blob.offsetInBytes,blob.lengthInBytes));
    }
    return NativeDatabase(dbfile);

});

}
