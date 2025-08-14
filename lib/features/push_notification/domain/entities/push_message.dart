class PushMessage {
  const PushMessage({this.title, this.body, this.data = const {}});
  final String? title;
  final String? body;
  final Map<String, dynamic> data;
}
