import 'package:cmruapp/services/page_services.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final String id;
  const PostDetailScreen({super.key, required this.id});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  dynamic _post = {};

  @override
  void initState() {
    super.initState();
    PageService.fetchPage(widget.id).then((post) {
      setState(() {
        _post = post;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_post['title']),
      ),
      body: Container(
        child: Text(_post['content']),
      ),
    );
  }
}