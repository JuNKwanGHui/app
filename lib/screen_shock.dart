import 'package:ddvision/screen_shockgps.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class ShockVideoPage extends StatefulWidget {
  const ShockVideoPage({Key? key}) : super(key: key);

  @override
  _ShockVideoPageState createState() => _ShockVideoPageState();
}

class _ShockVideoPageState extends State<ShockVideoPage> {

  late Future<ListResult> _futureFileList;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();
    _futureFileList = _getFilesForSelectedDate(DateTime.now());
  }

  Future<ListResult> _getFilesForSelectedDate(DateTime selectedDate) async {
    final dateFormat = DateFormat('yyyyMMdd');
    final dateString = dateFormat.format(selectedDate);
    final folderPath = '/postanalytical/shock/$dateString';
    final result = await FirebaseStorage.instance.ref(folderPath).listAll();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '이벤트 영상-충격 감지',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        children: [
          _buildCalendar(),
          FutureBuilder<ListResult>(
            future: _futureFileList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.items.isEmpty) {
                return const Center(child: Text('파일이 존재하지 않습니다.'));
              } else {
                final files = snapshot.data!.items;
                return Expanded(
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      double? progress = downloadProgress[index];

                      return ListTile(
                        title: Text(file.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.download,
                                color: Colors.black,
                              ),
                              onPressed: () => downloadFile(index, file),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.gps_fixed,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                String fileNameWithoutExtension = file.name.split('.').first; // 파일 이름에서 확장자를 제외한 부분을 가져옴
                                String numberPrefix = fileNameWithoutExtension.split('shock1').first; // 파일 이름에서 첫 번째 "_"를 기준으로 앞에 있는 숫자들을 추출
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ShockGps(numberPrefix)),
                                );
                              },
                            ),
                          ],
                        ),
                        subtitle: progress != null
                        ? LinearProgressIndicator(
                          value: progress,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          backgroundColor: Colors.black26,
                        )
                            : null,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

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

  DateTime focusedDay = DateTime.now();

  Widget _buildCalendar() {
    initializeDateFormatting();
    return TableCalendar<DateTime>(
      locale: 'ko_KR',
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.now(),
      focusedDay: focusedDay,
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextFormatter: (date, locale) =>
            DateFormat.yMMMMd(locale).format(date),
        formatButtonVisible: false,
        titleTextStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
        headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
        leftChevronIcon: const Icon(
          Icons.arrow_left,
          size: 40.0,
          color: Colors.black,
        ),
        rightChevronIcon: const Icon(
          Icons.arrow_right,
          size: 40.0,
          color: Colors.black,
        ),
      ),
      onDaySelected: (selectedDate, focusedDate) {
        setState(() {
          _futureFileList = _getFilesForSelectedDate(selectedDate);
          // 날짜 선택 후에 해당 날짜에 머무르게 설정
          focusedDay = selectedDate;
        });
      },
      selectedDayPredicate: (date) {
        // 선택한 날짜에 원으로 표시
        return isSameDay(date, focusedDay);
      },
    );
  }
}
