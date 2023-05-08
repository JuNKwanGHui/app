import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CutVideoPage extends StatefulWidget {
  const CutVideoPage({Key? key}) : super(key: key);

  @override
  _CutVideoPageState createState() => _CutVideoPageState();
}

class _CutVideoPageState extends State<CutVideoPage> {
  late Future<ListResult> _futureFileList;

  @override
  void initState() {
    super.initState();
    _futureFileList = _getFilesForSelectedDate(DateTime.now());
  }

  Future<ListResult> _getFilesForSelectedDate(DateTime selectedDate) async {
    final dateFormat = DateFormat('yyyyMMdd');
    final dateString = dateFormat.format(selectedDate);
    final folderPath = '/postanalytical/cut/$dateString';

    final result = await FirebaseStorage.instance.ref(folderPath).listAll();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File List'),
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
                return const Center(child: Text('No files found.'));
              } else {
                final files = snapshot.data!.items;
                return Expanded(
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return ListTile(
                        title: Text(file.name),
                        onTap: () {
                          // 파일 클릭 시 해당 파일을 열거나 다운로드하는 코드를 작성하세요.
                        },
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

  Widget _buildCalendar() {
    return TableCalendar<DateTime>(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.now(),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      onDaySelected: (selectedDate, focusedDate) {
        setState(() {
          _futureFileList = _getFilesForSelectedDate(selectedDate);
        });
      },
    );
  }
}
