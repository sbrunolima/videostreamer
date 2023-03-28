class CommunityPost {
  final String id;
  final String userID;
  final String username;
  final String userImage;
  final String postTitle;
  final String postContent;
  final String movie;
  final int likes;
  final DateTime dateTime;

  CommunityPost({
    required this.id,
    required this.userID,
    required this.username,
    required this.userImage,
    required this.postTitle,
    required this.postContent,
    required this.movie,
    required this.likes,
    required this.dateTime,
  });
}

class Comments {
  final String id;
  final String username;
  final String userImage;
  final String userID;
  final String postID;
  final String userComment;
  final int likes;
  final DateTime dateTime;

  Comments({
    required this.id,
    required this.username,
    required this.userImage,
    required this.userID,
    required this.postID,
    required this.userComment,
    required this.likes,
    required this.dateTime,
  });
}

class Like {
  final String id;
  final String userID;
  final String postID;

  Like({
    required this.id,
    required this.userID,
    required this.postID,
  });
}
