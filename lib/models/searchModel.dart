// ignore_for_file: file_names

import '../enum/dataType.dart';

class SearchModel {
  String? displayIcon;
  String? displayName;
  DataType dataType;
  SearchModel({this.displayIcon, this.displayName, required this.dataType});
}
