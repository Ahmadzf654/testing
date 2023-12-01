import 'dart:convert';

import 'package:api_practice/example_four.dart';
import 'package:api_practice/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components/reusable_row.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      userList.clear();
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else {
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Three'),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ClassFour()));
          }, icon: const Icon(Icons.navigate_next))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getUserApi(), builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
              if(!snapshot.hasData)
                {
                  return const Center(
                    child:  CircularProgressIndicator(
                    ),
                  );
                }
              else {
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context , index){
                      return  Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade500,
                              ),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ReUsableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                                  ReUsableRow(title: 'username', value: snapshot.data![index].username.toString()),
                                  ReUsableRow(title: 'e-mail', value: snapshot.data![index].email.toString()),
                                  ReUsableRow(title: 'Address', value: '${snapshot.data![index].address!.city} ${snapshot.data![index].address!.geo!.lat}'),
                                ],
                              ),
                            ),
                          )

                        ],
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

