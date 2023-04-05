import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//Provider
import '../objects/communit_post.dart';
import '../providers/comments_provider.dart';
import '../providers/user_provider.dart';

class ReplyItem extends StatelessWidget {
  final Reply reply;

  ReplyItem({required this.reply});

  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == reply.userID)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    user[0].imageUrl,
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user[0].username,
                  style: GoogleFonts.openSans(
                    color: Colors.white60,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    reply.userReply,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      DateFormat('dd/MM - hh:mm').format(reply.dateTime),
                      style: GoogleFonts.openSans(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
