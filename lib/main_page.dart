import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';


  class HomePage extends StatefulWidget{
    const HomePage({Key? key}):super(key:key);

    @override
    _HomePageState createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    late Future<ListResult> futureFiles;
    Map<int, double> downloadProgress = {};

    @override
    void initState() {
      super.initState();

      futureFiles = FirebaseStorage.instance.ref('/driving_video').listAll();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
          appBar: AppBar(
            title: const Text('Download Files'),
          ),
          body: FutureBuilder<ListResult>(
              future:futureFiles,
              builder: (context, snapshot){
                if (snapshot.hasData){
                  final files = snapshot.data!.items;

                  return ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index){
                        final file = files[index];
                        double? progress = downloadProgress[index];

                        return ListTile(
                          title: Text(file.name),
                          subtitle: progress != null
                                ? LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor:Colors.black26,
                                  )
                                :null,
                          trailing: IconButton(
                            icon:const Icon(
                              Icons.download,
                              color:Colors.black,
                            ),
                            onPressed: () => downloadFile(index, file),
                          ),
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error occurred'));
            }else {
              return const Center(child:CircularProgressIndicator());
            }
          },
        ),
      );
  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    ///Visible to User inside Gallery
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(
      url,
      path,
      onReceiveProgress: (received, total){
        double progress = received / total;

        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

    if (url.contains('.avi')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('.jpg')){
      await GallerySaver.saveImage(path, toDcim: true);
    }
    ///Not visible for user
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded ${ref.name}')),
    );
  }
}