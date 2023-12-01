import 'dart:convert';

import 'package:api_practice/exampe_two.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/post_model.dart';






class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }
    else {
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Api practice',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ExampleTwo()));
          }, icon: const Icon(Icons.navigate_next),color: Colors.white, ),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(future: getPostApi(), builder:(context , snapshot){
                if(!snapshot.hasData){
                  return const Center(child:  CircularProgressIndicator());
                }
                else {
                  return ListView.builder(
                    itemCount: postList.length,
                      itemBuilder: (context , index){
                    return Card(

                      elevation: 5,
                      shadowColor: Colors.red,
                      color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text('Title:\n${postList[index].title}',style: const TextStyle(color: Colors.white,),textAlign: TextAlign.justify,),
                                Text('Description:\n${postList[index].body}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.justify,),
                              ]),
                        ));
                  });
                }
              } ),
            ),


          ],
        ),
      ),

    );

  }

}
