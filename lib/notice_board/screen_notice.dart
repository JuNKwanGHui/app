import 'package:flutter/material.dart';

import 'memo_add_page.dart';
import 'memo.dart';
import 'memo_repository.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Memo App',
//     home: MyApp(),
//   ));
// }

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  final MemoRepository _memoRepository = MemoRepository();
  List<Memo> _memos = [];

  @override
  void initState() {
    super.initState();
    _memos = _memoRepository.getMemos();
  }

  void _addMemo(BuildContext context) async {
    final result = await Navigator.of(context).push<Memo>(
      MaterialPageRoute(builder: (context) => const MemoAddPage()),
    );

    if (result != null) {
      _memoRepository.addMemo(result);
      setState(() {
        _memos = _memoRepository.getMemos();
      });
    }
  }

  void _editMemo(BuildContext context, int index) async {
    final memo = _memos[index];
    final result = await Navigator.of(context).push<Memo>(
      MaterialPageRoute(builder: (context) => MemoAddPage(memo: memo)),
    );

    if (result != null) {
      _memoRepository.updateMemo(result);
      setState(() {
        _memos = _memoRepository.getMemos();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Memo App'),
        ),
        body: ListView.builder(
          itemCount: _memos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_memos[index].title),
              subtitle: Text(_memos[index].content),
              onTap: () => _editMemo(context, index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addMemo(context),
          tooltip: 'Add Memo',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
