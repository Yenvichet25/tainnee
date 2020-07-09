import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tainnee/pages/OrderPage.dart';
import 'package:tainnee/widget/page_reveal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn)
      ..addListener(() {
        setState(() {});
      });
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        child: Stack(
          children: <Widget>[
            Transform(
                alignment: Alignment.center,
                transform: Matrix4.translationValues(
                    0.0, 0.0 + (10 * animation.value), 0.0)
                  ..scale(1.0 - (0.1 * animation.value)),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)
                    ),
                    child: homepage(size))),
            PageReveal(
              revealPercent: animation.value,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0,
                      (size.height - ((size.height * 0.88) * animation.value)),
                      0.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)
                      ),
                      child: menupage(size))),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 0.0 - ((size.height * 0.4) * animation.value), 0.0),
              child: Center(
                child: CupertinoButton(
                  onPressed: () {
                    animation.value == 0
                        ? animationController.forward(from: 0.1)
                        : animationController.reverse(from: 1.0);
                  },
                  child: Text(
                    "H2E",
                    style: TextStyle(
                        fontFamily: 'Static',
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                        letterSpacing: 2,
                        fontSize: 45),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Container menupage(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/loginbg.jpeg"))),
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: ListView(
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  0.0, size.height - (size.height * animation.value), 0.0),
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: 70,
                  child: CupertinoTextField(
                    padding: EdgeInsets.all(10.0),
                    prefix: Icon(
                      CupertinoIcons.person_solid,
                      color: CupertinoColors.lightBackgroundGray,
                    ),
                    placeholder: "User Name",
                  )),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, size.height - (size.height * animation.value), 0.0),
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: 70,
                  child: CupertinoTextField(
                    padding: EdgeInsets.all(10.0),
                    prefix: Icon(
                      CupertinoIcons.padlock_solid,
                      color: CupertinoColors.lightBackgroundGray,
                    ),
                    obscureText: true,
                    placeholder: "Password",
                  )),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, size.height - (size.height * animation.value), 0.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  color: CupertinoColors.activeOrange,
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => OrderPage(),
                            fullscreenDialog: true));
                  },
                  child: Text(
                    "Sing Up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container homepage(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/martian_surface.png"))),
    );
  }
}
