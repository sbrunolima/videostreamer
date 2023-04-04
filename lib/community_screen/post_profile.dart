import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//Provider
import '../objects/communit_post.dart';
import '../providers/user_provider.dart';

class PostProfile extends StatelessWidget {
  final CommunityPost post;

  PostProfile({required this.post});

  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<UserPovider>(context, listen: false);
    final user = usersData.user
        .where((loadedUser) => loadedUser.userID == post.userID)
        .toList();
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            user[0].imageUrl,
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user[0].username,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
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
    );
  }
}
