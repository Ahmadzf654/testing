import 'dart:convert';

import 'package:api_practice/example_three.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id'], thumbnailUrl: i['thumbnailUrl']);
        photosList.add(photos);
      }
      return photosList;
    }
    else{
      return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example 2 of API'),
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
           Navigator.pop(context);
          },
            
            child: const Icon(Icons.arrow_back)),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleThree()));
        }, icon: const Icon(Icons.navigate_next))],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getPhotos(), builder: (context , AsyncSnapshot<List<Photos>> snapshot){
              if(!snapshot.hasData){
                return const Center(child:  CircularProgressIndicator());
              }
              else {
                return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context , index){
                      return  ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          title: Text('notes id:${snapshot.data![index].id}',style: const TextStyle(backgroundColor: Colors.blue,color: Colors.white),),

                          subtitle:  Text(snapshot.data![index].title.toString()),
                          trailing: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].thumbnailUrl.toString()),)
                      );
                    });
              }

            }),
          )
        ],
      ),
    );
  }
}
class Photos {
  String title, url,thumbnailUrl;
  int id;
  Photos({required this.title, required this.url,required this.id,required this.thumbnailUrl});
}
