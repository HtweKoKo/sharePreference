import 'package:dictionary_app/database/dictionaryDao.dart';
import 'package:dictionary_app/database/dictionaryDatabase.dart';
import 'package:dictionary_app/screen.dart/detail.dart';
import 'package:dictionary_app/screen.dart/faourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  DictionaryDao dictionaryDao = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Engineering  dictionary"),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: (() {
            Get.to(()=>Favorite());
          }),
        )
      ],
      
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: TextFormField(
              onChanged: (str){
                setState(() {
                  
                });
              },
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(10),
                border:OutlineInputBorder() ) 

                ),
          ),
          SizedBox(height: 20,),
          
          FutureBuilder<List<DictionaryTableData>>(
            future: dictionaryDao.searchWords(_controller.text)  ,
            builder:((context, snapshot) {
              if(snapshot.hasData){
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: ListView.builder(
                      itemCount:  snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: (){
                            Get.to(()=>Detail(data: snapshot.data![index],));
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data![index].eng),
                            )),
                        );
                      })),
                  ),
                );
              }
              else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator();
            }),
    ),
        ],
      ));
  }

}