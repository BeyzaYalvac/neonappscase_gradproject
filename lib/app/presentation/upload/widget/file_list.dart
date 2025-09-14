import 'package:flutter/material.dart';

class FileList extends StatelessWidget {
  final Listfiles; // UI için sade model (state’deki tip)
  const FileList({super.key, this.Listfiles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.insert_drive_file_outlined),
        title: Text(Listfiles[i].name),
        subtitle: Text('${Listfiles[i].sizeKb} KB'),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {}, // aksiyonlar
        ),
      ),
      separatorBuilder: (_, __) => const Divider(height: 8),
      itemCount: Listfiles.length,
    );
  }
}
