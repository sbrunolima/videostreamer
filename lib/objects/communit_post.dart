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

class Reply {
  final String id;
  final String username;
  final String userImage;
  final String userID;
  final String commentID;
  final String userReply;
  final DateTime dateTime;

  Reply({
    required this.id,
    required this.username,
    required this.userImage,
    required this.userID,
    required this.commentID,
    required this.userReply,
    required this.dateTime,
  });
}

class LikePost {
  final String id;
  final String userID;
  final String postID;
  final bool favorite;

  LikePost({
    required this.id,
    required this.userID,
    required this.postID,
    required this.favorite,
  });
}

class LikeComment {
  final String id;
  final String userID;
  final String commentID;
  final bool favorite;

  LikeComment({
    required this.id,
    required this.userID,
    required this.commentID,
    required this.favorite,
  });
}

class LikeReply {
  final String id;
  final String userID;
  final String replyID;
  final bool favorite;

  LikeReply({
    required this.id,
    required this.userID,
    required this.replyID,
    required this.favorite,
  });
}
