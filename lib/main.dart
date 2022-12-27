import 'package:dictionary_app/database/dictionaryDao.dart';
import 'package:dictionary_app/database/dictionaryDatabase.dart';
import 'package:dictionary_app/screen.dart/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void  main() {
  DictionaryDatabase dictionaryDatabase = DictionaryDatabase();
  DictionaryDao dictionaryDao = dictionaryDatabase.dictionaryDao;
  Get.put(dictionaryDao);
  runApp(GetMaterialApp(
    
      home: Home(),
  ));
}