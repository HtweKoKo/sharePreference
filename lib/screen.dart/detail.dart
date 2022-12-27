import 'package:dictionary_app/database/dictionaryDao.dart';
import 'package:dictionary_app/database/dictionaryDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;

class Detail extends StatefulWidget {
  final DictionaryTableData data;

 Detail({Key? key,required  this.data,}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DictionaryDao _dictionaryDao = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  Text(widget.data.eng),
      ),
      body: ListView(
        children: [
            StreamBuilder<DictionaryTableData>(
              stream:_dictionaryDao.realtimeFav(widget.data.id),
              builder:((context, snapshot) {
                if(snapshot.hasData){
                print(snapshot.data.toString());
                  return IconButton(onPressed: ()async{
                if(snapshot.data!.favourite == null || snapshot.data!.favourite == false){
                  await _dictionaryDao.updateFavourite(
                    DictionaryTableCompanion(
                      id: drift.Value(widget.data.id),
                      eng: drift.Value(widget.data.eng),
                      myan: drift.Value(widget.data.myan),
                      type: drift.Value(widget.data.type),
                      favourite: drift.Value(true),
                    )
                  );
                }
                else{
                  await _dictionaryDao.updateFavourite(
                    DictionaryTableCompanion(
                      id: drift.Value(widget.data.id),
                      eng: drift.Value(widget.data.eng),
                      myan: drift.Value(widget.data.myan),
                      type: drift.Value(widget.data.type),
                      favourite: drift.Value(false),
                    )
                  );
                }
                setState(() {
                  
                });

          },
           icon:(snapshot.data!.favourite == null || snapshot.data!.favourite == false)
           ? Icon(Icons.favorite_outline) : Icon(Icons.favorite) ) ;
                }
                if(snapshot.hasError){
                  return Text("Error");
                }
                return CircularProgressIndicator();
              }) )
          ,
          
          ListTile(
            title: Text("English"),
            subtitle: Text(widget.data.eng),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 2,
            ),
          ),
          ListTile(
            title: Text("Type"),
            subtitle: Text(widget.data.type),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 2,
            ),
          ),
          ListTile(
            title: Text("Myanmar"),
            subtitle: Text(widget.data.myan),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}