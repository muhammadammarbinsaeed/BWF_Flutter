class Note {
  int? id;
  String title;
  String description;
  DateTime createdAt;
  String Status;
  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.Status
  });
  Map<String,dynamic> toMap() {
               return {
                'title': title,
                'description': description,
                'createdAt': createdAt.toIso8601String(),
                'Status': Status
               };
  }
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String,
      
      ), 
      Status:map['Status'] as String,
    );
  }

}