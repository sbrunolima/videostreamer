import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Providers
import '../providers/images_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  var userSnapshot;
  var _userId;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User? user = _auth.currentUser;
    _userId = user!.uid;
    if (_isInit) {
      Provider.of<ImagesProvider>(context, listen: false).loadProfileImages();
    }

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final imagesData = Provider.of<ImagesProvider>(context, listen: false);
    final images = imagesData.images;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final userData = snapshot.data;
            return Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      '${images[0].imageUrl.toString()}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 50),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: GestureDetector(
                    onTap: () => FirebaseAuth.instance.signOut(),
                    child: Row(
                      children: [
                        Icon(EneftyIcons.logout_bold, color: Colors.red),
                        const SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
