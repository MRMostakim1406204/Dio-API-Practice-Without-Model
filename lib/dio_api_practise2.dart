import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioAPIPractise2 extends StatefulWidget {
  const DioAPIPractise2({super.key});

  @override
  State<DioAPIPractise2> createState() => _DioAPIPractise2State();
}

class _DioAPIPractise2State extends State<DioAPIPractise2> {

  Future<List<dynamic>> getData()async{
    Dio dio = Dio();
    
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(), 
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
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
                      Text(snapshot.data![index]["userId"].toString()),
                      Text(snapshot.data![index]["title"]),
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