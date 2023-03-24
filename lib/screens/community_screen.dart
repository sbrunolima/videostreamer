import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

//Widgets
import '../community_screen/post_item.dart';

//Providers
import '../providers/community_post_provider.dart';

class CommunutyScreen extends StatefulWidget {
  @override
  State<CommunutyScreen> createState() => _CommunutyScreenState();
}

class _CommunutyScreenState extends State<CommunutyScreen> {
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      _isLoading = true;
    });

    Provider.of<CommunytPostProvider>(context, listen: false)
        .loadPosts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<CommunytPostProvider>(context, listen: false);
    final post = postsData.posts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        title: Text('Community'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: post.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    PostItem(post: post[index]),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          postsData.loadPosts();
        },
      ),
    );
  }
}
