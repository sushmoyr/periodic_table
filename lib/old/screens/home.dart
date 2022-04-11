import 'package:flutter/material.dart';
import 'package:periodic_table/old/widgets/search_bar.dart';

import '../widgets/home_page_appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: controller,
          slivers: [
            HomePageAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.primaries[index],
                      ),
                  childCount: Colors.primaries.length),
            )
          ],
        ),
      ),
    );
  }

  onFocusChanged(bool isFocused) {
    if (mounted) {
      if (isFocused && controller.offset < 180) {
        controller.animateTo(180,
            duration: kThemeChangeDuration, curve: Curves.easeInOut);
      }
      if (!isFocused && controller.offset <= 160) {
        controller.animateTo(0,
            duration: kThemeChangeDuration, curve: Curves.easeIn);
      }
    }
  }
}
