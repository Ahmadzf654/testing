import 'dart:convert';

import 'package:api_practice/example_five.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components/reusable_row.dart';

class ClassFour extends StatefulWidget {
  const ClassFour({super.key});

  @override
  State<ClassFour> createState() => _ClassFourState();
}

class _ClassFourState extends State<ClassFour> {
  var data;
  Future<void> getPostApi()async{

    print('124');
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    
    if(response.statusCode == 200)
      {
        data = jsonDecode(response.body.toString());
      }
    else {
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Example four'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LastExample()));
          }, icon: const Icon(Icons.navigate_next)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getPostApi(), builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const  Center(child: CircularProgressIndicator());
                }
              else if ( snapshot.hasError)
                {
                  return Text('errrror');
                }
              else {
                //return Text(data[0]['name'].toString());
                return ListView.builder(
                  itemCount: data.length,
                    itemBuilder: (context , index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [

                          ReUsableRow(title: 'name', value: data[index]['name'].toString()),
                        ],
                      ),
                    ),
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
