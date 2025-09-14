import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/domain/model/content_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isGridView;
  final int selectedIndex; // 0: Folder, 1: File, 2: Image
  final AccountModel? acountInfos;
  final double totalStorage;
  final List<ContentModel> folderContent;

  // Arama metinleri
  final String qFolder;
  final String qFile;
  final String qImage;

  // İsim listeleri
  final List<String> fileNames;
  final List<String> imageNames;

  HomeState({
    this.isLoading = false,
    this.isGridView = false,
    this.selectedIndex = 0,
    this.acountInfos,
    this.totalStorage = 100,
    this.qFolder = "",
    this.qFile = "",
    this.qImage = "",
    
    this.fileNames = const [
      "bb",
      "aaa",
      "Music",
      "Pictursdfsdfes",
      "Vidsdfos",
      "Wosdfrk",
      "Perssdfonal",
    ],
    this.imageNames = const [
      "Docssuments",
      "Downlossads",
      "Musssic",
      "ssPictures",
      "Videddos",
      "Woffrk",
      "Perseeonal",
    ],
    this.folderContent = const [],
  });

  factory HomeState.initial() =>  HomeState(acountInfos: null,folderContent: []);

  // Computed (filtreler)
  List<ContentModel> get filteredFolders {
    final q = qFolder.trim().toLowerCase();
    if (q.isEmpty) return folderContent.where((c) => c.isFolder).map((c) => c).toList();
    return folderContent
        .where((c) => c.isFolder && c.name.toLowerCase().contains(q))
        .map((c) => c)
        .toList();
    
  }

  List<String> get filteredFiles {
    final q = qFile.trim().toLowerCase();
    if (q.isEmpty) return fileNames;
    return fileNames.where((n) => n.toLowerCase().contains(q)).toList();
  }

  List<String> get filteredImages {
    final q = qImage.trim().toLowerCase();
    if (q.isEmpty) return imageNames;
    return imageNames.where((n) => n.toLowerCase().contains(q)).toList();
  }

  HomeState copyWith({
    bool? isLoading,
    bool? isGridView,
    int? selectedIndex,
    AccountModel? acountInfos,
    double? totalStorage,
    String? qFolder,
    String? qFile,
    String? qImage,
    List<String>? folderNames,
    List<String>? fileNames, // ✅ eklendi
    List<String>? imageNames, // ✅ eklendi
    List<ContentModel>? folderContent,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isGridView: isGridView ?? this.isGridView,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      acountInfos: acountInfos ?? this.acountInfos,
      totalStorage: totalStorage ?? this.totalStorage,
      qFolder: qFolder ?? this.qFolder,
      qFile: qFile ?? this.qFile,
      qImage: qImage ?? this.qImage,
      fileNames: fileNames ?? this.fileNames, // ✅
      imageNames: imageNames ?? this.imageNames, // ✅
      folderContent: folderContent ?? this.folderContent,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isGridView,
    selectedIndex,
    acountInfos,
    totalStorage,
    qFolder,
    qFile,
    qImage,
    fileNames, // ✅
    imageNames, // ✅
    folderContent
  ];
}
