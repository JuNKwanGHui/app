import 'package:flutter/material.dart';
import 'memo.dart';

class MemoAddPage extends StatefulWidget {
  final Memo? memo;

  const MemoAddPage({Key? key, this.memo}) : super(key: key);

  @override
  _MemoAddPageState createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.memo != null) {
      _titleController.text = widget.memo!.title;
      _contentController.text = widget.memo!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo == null ? 'Add Memo' : 'Edit Memo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: 'Content',
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final title = _titleController.text;
            final content = _contentController.text;
            final memo = Memo(title: title, content: content);

            Navigator.of(context).pop(memo);
          }
        },
        tooltip: 'Save Memo',
        child: const Icon(Icons.save),
      ),
    );
  }
}
