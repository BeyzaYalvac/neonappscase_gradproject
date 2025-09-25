import 'package:flutter/material.dart';

class FileList extends StatelessWidget {
  final dynamic listFiles; // UI için sade model (state’deki tip)
  const FileList({super.key, this.listFiles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.insert_drive_file_outlined),
        title: Text(listFiles[i].name),
        subtitle: Text('${listFiles[i].sizeKb} KB'),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {}, 
        ),
      ),
      separatorBuilder: (_, __) => const Divider(height: 8),
      itemCount: listFiles.length,
    );
  }
}
