import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<SliderMenuContainerState> _key = GlobalKey<SliderMenuContainerState>();

  String title = 'auaicn';
  @override
  Widget build(BuildContext context) {
    return SliderMenuContainer(
      appBarColor: Colors.white,
      key: _key,
      sliderMenuOpenSize: 200,
      title: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      ),
      sliderMenu: MenuWidget(
        onItemClick: (title) {
          _key.currentState!.closeDrawer();
          setState(() {
            this.title = title;
          });
        },
      ),
      sliderMain: MainWidget(),
    );
  }
}

class MenuWidget extends StatelessWidget {
  final Function onItemClick;

  const MenuWidget({required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Text('menu'),
    );
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}
