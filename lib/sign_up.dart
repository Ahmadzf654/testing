import 'dart:convert';

import 'package:api_practice/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password)async{
    try {
      Response response = await  post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email' :  email,
          'password':  password,
      }
      );
      if(response.statusCode == 200){
        var data  = jsonDecode(response.body.toString());
        print(data['token']);
        print('account login successfully');
      } else {
        print('failed');
      }
    } catch (e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign UP',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.pink,
        iconTheme: const  IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadImage()));
          }, icon: const Icon(Icons.navigate_next))
        ],
      ),

      body:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Email'
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: 'password'
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (){

              login(emailController.text.toString(),passwordController.text.toString());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green,
              ),
              child: const Center(child: Text('Sign Up'),),
            ),
          )
        ],
      ),
    );
  }
}
