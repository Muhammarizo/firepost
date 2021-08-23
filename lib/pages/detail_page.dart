import 'dart:io';
import 'package:firepost/model/post_model.dart';
import 'package:firepost/services/pref_service.dart';
import 'package:firepost/services/rtdb_service.dart';
import 'package:firepost/services/stor_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class DetailPage extends StatefulWidget {
  static final String id = 'detail_page';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  var titleController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async {
    String title = titleController.text.toString();
    String content = contentController.text.toString();

    if (title.isEmpty || content.isEmpty) return;
    if (_image == null) return; // rasm tanlamasen jim turoradi

    _apiUploadImage(title, content);
  }

  void _apiUploadImage(String title, String content) {
    StoreService.uploadImage(_image!).then((img_url) => {
          _apiAddPost(title, content, img_url!),
        });
  }

  _apiAddPost(String title, String content, String img_url) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(new Post(id!, title, content, img_url))
        .then((response) => {
              _respAddPost(),
            });
  }

  _respAddPost() {
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    Future _getImage() async {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("No image selected");
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              GestureDetector(
                onTap: _getImage,
                child: Container(
                    width: 100,
                    height: 100,
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('images/camera.png')),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: 'Content'),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: TextButton(
                  onPressed: _addPost,
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
