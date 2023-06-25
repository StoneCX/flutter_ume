import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ume/flutter_ume.dart';

import 'constant.dart';

class CustomLog implements Pluggable {
  @override
  Widget? buildWidget(BuildContext? context) => _buildLogPanel(context);

  @override
  ImageProvider<Object> get iconImageProvider =>
      MemoryImage(base64Decode(logo));

  @override
  String get name => 'webviewTool';

  @override
  String get displayName => 'webviewTool';

  @override
  void onTrigger() {
    debugPrint('$name onTrigger');
  }

  static List<String> _logList = <String>[];
  static List<String> get logList => _logList;

  static void log(String info) {
    _logList.add(info);
    print(info);
  }

  Widget _buildLogPanel(BuildContext? context) {
    if (context == null) return Container();
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: LogViewerPage()),
    );
  }
}

class LogViewerPage extends StatefulWidget {
  LogViewerPage({Key? key}) : super(key: key);

  @override
  _LogViewerPageState createState() => _LogViewerPageState();
}

class _LogViewerPageState extends State<LogViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomLog Viewer'),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text('${CustomLog.logList[index]}'),
            );
          },
          separatorBuilder: (ctx, index) => Divider(),
          itemCount: CustomLog.logList.length),
    );
  }
}
