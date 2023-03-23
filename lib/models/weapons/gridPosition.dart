// ignore_for_file: file_names

class GridPosition {
  int? row;
  int? column;

  GridPosition({this.row, this.column});

  GridPosition.fromJson(Map<String, dynamic> json) {
    row = json['row'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['row'] = row;
    data['column'] = column;
    return data;
  }
}
