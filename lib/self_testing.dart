import 'dart:convert';

import 'package:api_practice/models/api_testing.dart';
import 'package:api_practice/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SelfTesting extends StatefulWidget {
  const SelfTesting({super.key});

  @override
  State<SelfTesting> createState() => _SelfTestingState();
}

class _SelfTestingState extends State<SelfTesting> {


  Future<ApiTesting> getApiPost() async {
    final response = await http.get(Uri.parse('https://api.publicapis.org/entries'));
    if (response.statusCode == 200) {
      var data2 = jsonDecode(response.body);
      return ApiTesting.fromJson(data2);
    } else {
      throw Exception('Failed to load API data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Testing', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
          }, icon: const Icon(Icons.navigate_next)),
        ],
      ),
      body: FutureBuilder(
        future: getApiPost(),
        builder: (context, AsyncSnapshot<ApiTesting> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Entries>? testingList = snapshot.data?.entries;

            return testingList != null
                ? ListView.builder(
              itemCount: testingList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(testingList[index].cors.toString()),
                    InkWell(
                      onTap: (){
                        _launchURL(testingList[index].link.toString());
                      },
                        child: Text(testingList[index].link.toString(),style: const TextStyle(color: Colors.blueAccent),)),
                  ],
                );
              },
            )
                : const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
Future<void> _launchURL(String? url) async {
  if (url != null && await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}





// import 'dart:convert';
//
// import 'package:api_practice/models/api_testing.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SelfTesting extends StatefulWidget {
//   const SelfTesting({super.key});
//
//   @override
//   State<SelfTesting> createState() => _SelfTestingState();
// }
//
// class _SelfTestingState extends State<SelfTesting> {
//   List<Entries> testingList = [];
//   Future<List<Entries>> getApiPost() async{
//     final response = await http.get(Uri.parse('https://api.publicapis.org/entries'));
//     var data2 = jsonDecode(response.body.toString());
//     print(data2);
//     if(response.statusCode == 200){
//      for(Map g in data2){
//       print(data2);
//        testingList.add(Entries.fromJson(g));
//      }
//      return testingList;
//     }
//     else {
//       return  testingList;
//
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Self Testing',style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.brown,
//         iconTheme: IconThemeData(
//           color: Colors.white
//         ),
//
//       ),
//       body:  Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: FutureBuilder(future: getApiPost(), builder: (context, AsyncSnapshot<List<Entries>> snapshot){
//               if(!snapshot.hasData){
//                 print(testingList.length);
//                 return Center(child: CircularProgressIndicator());
//               }
//               else {
//                 print(testingList.length);
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                     itemBuilder: (context , index){
//                   return Column(
//                     children: [
//                       Text(snapshot.data![index].cors.toString()),
//                     ],
//                   );
//                 });
//               }
//
//             }),
//           )
//         ],
//       ),
//
//     );
//   }
// }
