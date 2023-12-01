import 'dart:convert';

import 'package:api_practice/self_testing.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/products_model.dart';

class LastExample extends StatefulWidget {
  const LastExample({super.key});

  @override
  State<LastExample> createState() => _LastExampleState();
}


class _LastExampleState extends State<LastExample> {
  bool isTrue = true;
  void toggle(){
    setState(() {
      isTrue = !isTrue;
    });
  }

  Future<ProductsModel> getProductsApi() async{
    final response = await http.get(Uri.parse('https://webhook.site/9345d939-6e71-4e17-956d-69ae7fa916d8'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    }
    else {
      return ProductsModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Last Example', style: TextStyle(
          fontFamily: 'Times New Roman',
          color: Colors.white,

        ),),

        iconTheme: const  IconThemeData(color: Colors.white),

        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SelfTesting()));
          }, icon: const Icon(Icons.navigate_next))
        ],

      ),
      body:   Column(
        children: [
          Expanded(child: FutureBuilder<ProductsModel>(future: getProductsApi(), builder: (context, snapshot){
            if(!snapshot.hasData){
              return const  Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index){
                    return   Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         ListTile(
                          title: Text(snapshot.data!.data![index].shop!.name.toString(),style: const TextStyle(color: Colors.deepOrange),),
                         subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString(),style:const  TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                           leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height *.3,
                          width: MediaQuery.of(context).size.width *1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount : snapshot.data!.data![index].images!.length,
                              itemBuilder: (context, position){
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height *.25,
                                width: MediaQuery.of(context).size.width *.5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage(snapshot.data!.data![index].images![position].url.toString()),fit: BoxFit.cover),
                                ),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.data![index].categories!.type.toString()),
                                  ],
                                ),

                              ),

                            );

                          }),
                        ),
                        GestureDetector(
                          onTap: (){
                            toggle();
                    },
                            child: Icon(snapshot.data!.data![index].inWishlist == isTrue ? Icons.favorite : Icons.favorite_outline)),

                      ],
                    );
                  });
            }

          }))
        ],
      ),
    );
  }
}

