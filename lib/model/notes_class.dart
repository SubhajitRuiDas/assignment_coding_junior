class NotesClass {
  final int notesId;
  final String notesTitle;
  final String notesContent;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NotesClass({
    required this.notesId,
    required this.notesTitle,
    required this.notesContent,
    required this.createdAt,
    DateTime? updatedAt
  }) : updatedAt = updatedAt ?? createdAt;

  Map<String, dynamic> toMap() {
    return {
      "id" : notesId,
      "title" : notesTitle,
      "content" : notesContent,
      "createdAt" : createdAt.millisecondsSinceEpoch,
      "updatedAt" : updatedAt.millisecondsSinceEpoch,
    };
  }

  factory NotesClass.fromMap(Map<String, dynamic> map) {
    return NotesClass(
    notesId: map["id"],
    notesTitle: map["title"], 
    notesContent: map["content"], 
    createdAt: DateTime.fromMillisecondsSinceEpoch(map["createdAt"] as int),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(map["updatedAt"] as int),
    );
  }
}