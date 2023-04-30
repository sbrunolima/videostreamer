import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/images_provider.dart';

//Widgets
import '../widgets/my_back_icon.dart';
import '../widgets/my_title.dart';

class ProfileImages extends StatefulWidget {
  final Function(String) callback;

  //Return the data
  ProfileImages({required this.callback});

  @override
  State<ProfileImages> createState() => _ProfileImagesState();
}

class _ProfileImagesState extends State<ProfileImages> {
  @override
  Widget build(BuildContext context) {
    //Load the images from firabase
    final imagesData = Provider.of<ImagesProvider>(context, listen: false);
    final images = imagesData.images;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        titleSpacing: 0,
        leading: MyBackIcon(),
        title: MyTitle(
          title: 'Edit profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    //If tapped, set the new image to the tapped Image
                    onTap: () {
                      widget.callback(images[index].imageUrl.toString());

                      //Return to previous screen
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          images[index].imageUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
                mainAxisExtent: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
