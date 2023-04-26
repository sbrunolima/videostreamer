import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/user_provider.dart';

class PostProfile extends StatelessWidget {
  final CommunityPost post;

  PostProfile({required this.post});

  final String noImage = 'https://i.stack.imgur.com/34AD2.jpg';

  @override
  Widget build(BuildContext context) {
    //Load all DATA FROM FIREBASE => User
    //-------------------------------------------------------------------------
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == post.userID)
        .toList();
    //END Load all DATA FROM FIREBASE => User
    //-------------------------------------------------------------------------

    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              //User profile Image
              user[0].imageUrl,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
              loadingBuilder:
                  (context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Image.network(
                  height: 30,
                  width: 30,
                  'https://i.stack.imgur.com/34AD2.jpg',
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //Username
                user[0].username.isEmpty ? 'load error' : user[0].username,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                //Post date
                DateFormat('dd/MM - hh:mm').format(post.dateTime),
                style: GoogleFonts.openSans(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
