import 'memo.dart';

class MemoRepository {
  final List<Memo> _memos = [];

  List<Memo> getMemos() {
    return List.from(_memos);
  }

  void addMemo(Memo memo) {
    _memos.add(memo);
  }

  void updateMemo(Memo memo) {
    final index = _memos.indexWhere((element) => element.title == memo.title);
    if (index >= 0) {
      _memos[index] = memo;
    }
  }
}
