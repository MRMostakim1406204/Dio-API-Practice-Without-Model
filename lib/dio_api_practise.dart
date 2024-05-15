import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioAPIPractise extends StatefulWidget {
  const DioAPIPractise({super.key});

  @override
  State<DioAPIPractise> createState() => _DioAPIPractiseState();
}

class _DioAPIPractiseState extends State<DioAPIPractise> {

  Future<List<dynamic>> fetchData()async{
    Dio dio = Dio();

    var response = await dio.get("https://jsonplaceholder.typicode.com/posts/1/comments");
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(), 
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>>snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name:  ${snapshot.data![index]["name"]}"),
                    Text("E-mail:  ${snapshot.data![index]["email"]}"),
                    Text("Subtitle:  ${snapshot.data![index]["body"]}")
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
          
        })
    );
  }
}