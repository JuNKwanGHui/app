import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(DriveVideo());
}

Future<Uint8List> readFileAsBytes(String path) async {
  final file = File(path);
  final bytes = await file.readAsBytes();
  return Uint8List.fromList(bytes);
}

class DriveVideo extends StatefulWidget {
  @override
  _DriveVideo createState() => _DriveVideo();
}

class _DriveVideo extends State<DriveVideo> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseStorage.instance.ref('/test').listAll();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text(
            'Download Files',
            style: TextStyle(color: Colors.black87),
          ),
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final files = snapshot.data!.items;

              return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    double? progress = downloadProgress[index];

                    return ListTile(
                      title: Text(file.name),
                      subtitle: progress != null
                          ? LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.black26,
                      )
                          : null,
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.download,
                          color: Colors.black,
                        ),
                        onPressed: () => downloadFile(index, file),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error occurred'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );

  Future<void> downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();
    // Request permission to access the photo library
    var status = await Permission.photos.request();
    if (status.isGranted) {
// Permission granted, proceed with saving the video
    } else {
// Permission denied, handle the error
    }

    final appDir = await getApplicationDocumentsDirectory();
    final filePath = path.join(appDir.path, 'my_video.mp4');
    final file = File(filePath);

// 파일 다운로드
    final response = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
      onReceiveProgress: (count, total) {
        final progress = count / total;
        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

// 파일 저장
    await file.writeAsBytes(response.data!);

// 비디오 저장
    if (url.contains('.mp4')) {
      final result = await PhotoManager.editor.saveVideo(
        file,
        title: 'my_video',
      );
      print('Video saved successfully');
    }
// 이미지 저장
    else {
      final bytes = await file.readAsBytes();
      final result = await PhotoManager.editor.saveImage(
        bytes,
        title: 'my_image',
      );
      print(result);
    }
  }
}

