class Event {
  String id;
  String title;
  String description;
  String status;
  DateTime startAt;
  String duration;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.startAt,
    required this.duration,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    String startAtString =
        json['startAt'].toString().replaceAll(" ", "").substring(0, 16);
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      startAt: DateTime.parse(startAtString),
      duration: json['duration'].toString(),
    );
  }

  void removeWhere(bool Function(dynamic e) param0) {}
}
