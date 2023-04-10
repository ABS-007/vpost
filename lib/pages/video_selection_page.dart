import 'dart:io';
import 'package:blackcoffer/pages/video_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Videopage extends StatefulWidget {
  const Videopage({super.key});

  @override
  State<Videopage> createState() => _VideopageState();
}

class _VideopageState extends State<Videopage> {
  late File _video;
  Future getVideo(ImageSource source) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video == null) return;
    final temporaryvideo = File(video.path);
    setState(() {
      _video = temporaryvideo;
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoInfo(File(video.path))));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: custombutton(Icons.camera, "Pick from Camera",
                  () => getVideo(ImageSource.camera))),
          SizedBox(height: 40),
          Center(
              child: custombutton(Icons.image_outlined, "Pick from Gallery",
                  () => getVideo(ImageSource.gallery))),
        ],
      ),
    );
  }
}

Widget custombutton(
  IconData icon,
  String text,
  VoidCallback onclick,
) {
  return SizedBox(
    width: 400,
    height: 50,
    child: ElevatedButton(
      onPressed: onclick,
      child: Row(
        children: [Icon(icon), SizedBox(width: 20), Text(text)],
      ),
    ),
  );
}
