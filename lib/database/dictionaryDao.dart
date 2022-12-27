

import 'package:dictionary_app/database/dictionaryDatabase.dart';
import 'package:dictionary_app/database/dictionaryTable.dart';
import 'package:drift/drift.dart';
part 'dictionaryDao.g.dart';
@DriftAccessor(tables: [DictionaryTable])
class DictionaryDao extends DatabaseAccessor<DictionaryDatabase> with _$DictionaryDaoMixin{
  DictionaryDao(DictionaryDatabase dictionaryDatabase) : super(dictionaryDatabase);

  Future<List<DictionaryTableData>> getAllWords()async{

  return   await select(dictionaryTable).get();

  }
  Future<List<DictionaryTableData>> searchWords(String words)async{
      return await (select(dictionaryTable)
      ..where((tbl) => tbl.eng.like("$words%"))
      ).get();


  }
  Future<bool> updateFavourite(DictionaryTableCompanion data)async{
    return await update(dictionaryTable).replace(data);
  }
  Future<List<DictionaryTableData>> favouriteScreen()async{
    return await (select(dictionaryTable)
    ..where((tbl) => tbl.favourite.isNotNull())
    ).get();
  }
  Stream<DictionaryTableData>  realtimeFav(id){

    return  (select(dictionaryTable)
    ..where((tbl) => tbl.id.equals(id))
    ).watchSingle();
  }
  Stream<List<DictionaryTableData>> streamFav(){

    return( select(dictionaryTable)
    ..where((tbl) => tbl.favourite.equals(true))
    ).watch();
  }
  
}