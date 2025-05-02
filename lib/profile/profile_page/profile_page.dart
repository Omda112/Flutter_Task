import 'dart:io';//input - output
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImagePicker picker = ImagePicker();
  //obj
  File? selectedImage;
  //file input output
  Future<void> imageSelector(ImageSource source) async {
    XFile? image = await picker.pickImage(source: source);

    if (image != null && mounted) { // is the screen found or we navigated to another screen
      setState(() {
        selectedImage = File(image!.path);
      });
    }
  }

  // تعريف متغير للاسم
  String userName = "Emad";
  String email = "emadehab467@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: ListView(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade500,
                  radius: 110,
                  child:
                  selectedImage == null ?
                  Icon(Icons.person, size: 200, color: Colors.white38)
                      : ClipOval(child: Image.file(selectedImage!, fit: BoxFit.cover, width: 220, height: 220,)),
                ),

                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: (context) => SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            Text("change profile", style: TextStyle(fontSize: 25),),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Options(onPressed: () {
                                  imageSelector(ImageSource.camera);
                                  Navigator.pop(context);
                                }, title: "camera", icon: Icons.camera_alt),

                                Options(onPressed: () {
                                  imageSelector(ImageSource.gallery);
                                  Navigator.pop(context);
                                }, title: "gallery", icon: Icons.image),

                                if(selectedImage != null)
                                  Options(onPressed: () {
                                    if (mounted) { // if page still found
                                      setState(() {
                                        selectedImage = null;
                                      });
                                    }
                                    Navigator.pop(context);
                                  }, title: "delete", icon: Icons.delete, selectedImage: selectedImage,), // if true remove will be red button

                              ],
                            ),
                          ], //children
                        ),
                      ));
                    }, // on pressed
                    icon: Icon(Icons.camera_alt, size: 25, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // استخدام GridView بسيط للاسم والإيميل
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //crossAxisCount: 2,
            //childAspectRatio: 2,
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Name", style: TextStyle(fontSize: 25),),
                subtitle: Text(userName, style: TextStyle(fontSize: 18),),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Email", style: TextStyle(fontSize: 25),),
                subtitle: Text(email, style: TextStyle(fontSize: 18),),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey,
                boxShadow: [BoxShadow(color: Colors.white12, blurRadius: 2)]
            ),
          )
        ],
      ),
    );
  }
}


class Options extends StatelessWidget {
  final String title;
  final IconData icon;
  VoidCallback onPressed;
  File? selectedImage;
  Options({this.selectedImage, required this.onPressed, required this.title, required this.icon, super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            color: selectedImage == null ? Colors.grey.shade800 : Colors.red,
            onPressed: onPressed, icon: Icon(icon, size: 40,)),
        Text(title, style: TextStyle(color: selectedImage == null ? Colors.grey.shade800 : Colors.red),),
      ],);
  }
}