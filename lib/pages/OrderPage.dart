import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectIndex = 0;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Order",
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        trailing: CupertinoButton(
          onPressed: () {},
          child: Icon(CupertinoIcons.person_add_solid),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildOrderImage(size),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildOrderImage(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.28,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.black, width: 1)),
                child: CupertinoButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Icon(
                    CupertinoIcons.photo_camera_solid,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.black, width: 1),
                ),
                child: _image != null
                    ? Image.file(
                        _image,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            );
          }
        },
      ),
    );
  }
}
