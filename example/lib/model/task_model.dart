// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  String title;
  String description;
  bool? status;
  TaskModel({required this.title, required this.description, this.status});

  TaskModel copyWith({String? title, String? description, bool? status}) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] != null ? map['status'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TaskModel(title: $title, description: $description, status: $status)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.status == status;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ status.hashCode;
}
