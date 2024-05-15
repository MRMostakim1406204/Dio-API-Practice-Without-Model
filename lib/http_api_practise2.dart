import 'dart:convert';

import 'package:dio_api_practice/Model/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpAPIPractise2 extends StatefulWidget {
  const HttpAPIPractise2({super.key});

  @override
  State<HttpAPIPractise2> createState() => _HttpAPIPractise2State();
}

class _HttpAPIPractise2State extends State<HttpAPIPractise2> {
  List<PhotoModel> photoList = [];

  Future<List<PhotoModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        photoList.add(PhotoModel.fromJson(i));
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getPhotos(),
          builder:
              (BuildContext context, AsyncSnapshot<List<PhotoModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                        )
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
