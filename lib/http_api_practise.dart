import 'dart:convert';

import 'package:dio_api_practice/Model/get_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HttpAPIPractise extends StatefulWidget {
  const HttpAPIPractise({super.key});

  @override
  State<HttpAPIPractise> createState() => _HttpAPIPractiseState();
}

class _HttpAPIPractiseState extends State<HttpAPIPractise> {

  final List<GetModel> getList = [];

  Future<List<GetModel>> getDataAPI()async{

    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map<String,dynamic> i in data){
        getList.add(GetModel.fromJson(i));
      }
      return getList;
    }else{
      return getList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getDataAPI(), 
        builder: (BuildContext context, AsyncSnapshot<List<GetModel>> snapshot){
          if(snapshot.hasData){
            return ListView.builder(itemBuilder: (context,index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title is:- ${snapshot.data![index].title.toString()}"),
                       Text("SubTitle is:- ${snapshot.data![index].body.toString()}")
                    ],
                  ),
                ),
              );
            });
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
    );
  }
}