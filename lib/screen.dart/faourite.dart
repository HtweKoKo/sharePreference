import 'package:dictionary_app/database/dictionaryDao.dart';
import 'package:dictionary_app/database/dictionaryDatabase.dart';
import 'package:dictionary_app/screen.dart/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favorite> {
  DictionaryDao _dictionaryDao = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Favourite"),),
      // body: FutureBuilder<List<DictionaryTableData>>(
      //   future: _dictionaryDao.favouriteScreen(),
      //   builder:((context, snapshot) {
      //     if(snapshot.hasData){
      //         return ListView.builder(
      //             itemCount: snapshot.data!.length,
      //           itemBuilder:((context, index) {
      //               return InkWell(
      //                 onTap: (){
      //                   Get.to(()=> Detail(data: snapshot.data![index]));
      //                 },
      //                 child: Card(
      //                   child: ListTile(
      //                       title: Text(snapshot.data![index].eng),
      //                       subtitle: Text(snapshot.data![index].myan),
      //                   ),
      //                 ),
      //               );

      //           }) );
      //     }
      //     if(snapshot.hasError){
      //       return Text(snapshot.error.toString());
      //     }
      //     return CircularProgressIndicator();
      //   }) ),
      body: StreamBuilder<List<DictionaryTableData>>(
        stream: _dictionaryDao.streamFav(),
         builder:((context, snapshot) {
          if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                itemBuilder:((context, index) {
                    return InkWell(
                      onTap: (){
                        Get.to(()=> Detail(data: snapshot.data![index]));
                      },
                      child: Card(
                        child: ListTile(
                            title: Text(snapshot.data![index].eng),
                            subtitle: Text(snapshot.data![index].myan),
                        ),
                      ),
                    );

                }) );
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          return CircularProgressIndicator();} ),
  
    ));
  }
}