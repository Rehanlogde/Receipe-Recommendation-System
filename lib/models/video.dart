class Video {
  const Video({
    required this.id,
    required this.recipeId,
    required this.title,
    required this.youtubeVideoId,
    this.channelName,
  });

  final String id;
  final String recipeId;
  final String title;
  final String youtubeVideoId;
  final String? channelName;

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] as String,
      recipeId: json['recipeId'] as String,
      title: json['title'] as String,
      youtubeVideoId: json['youtubeVideoId'] as String,
      channelName: json['channelName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeId': recipeId,
      'title': title,
      'youtubeVideoId': youtubeVideoId,
      'channelName': channelName,
    };
  }
}
