import 'dart:io';
import 'dart:typed_data';

import 'package:before_after/before_after.dart';
import 'package:image_picker/image_picker.dart';

import './constants/export_const.dart';
import 'model/data.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var loaded = false;
  var removebg = false;
  var isLoading = false;

  Uint8List? image;
  String imagepath = " ";
  pickImage() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (img != null) {
      imagepath = img.path;

      loaded = true;
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Background Remover"),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: removebg
              ? BeforeAfter(
                  beforeImage: Image.file(File(imagepath)),
                  afterImage: Image.memory(image!),
                )
              : loaded
                  ? GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Image.file(File(imagepath)))
                  : Center(
                      child: Container(
                          child: ElevatedButton(
                              onPressed: () {
                                pickImage();
                                print("image picked");
                              },
                              child: Text("import image"))),
                    ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          onPressed: loaded
              ? () async {
                  setState(() {
                    isLoading = true;
                  });
                  image = await Api.removebg(imagepath);
                  if (image != null) {
                    removebg = true;

                    isLoading = false;
                    setState(() {});
                  }
                }
              : null,
          child: isLoading
              ? CircularProgressIndicator()
              : Text("Remove Background")),
    );
  }
}
