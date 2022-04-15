import 'package:flutter/material.dart';
import 'package:periodic_table/providers/app_settings.dart';
import 'package:periodic_table/screens/periodic_table_screen.dart';
import 'package:periodic_table/utils/helpers.dart';
import 'package:periodic_table/widgets/explore_card.dart';
import 'package:periodic_table/widgets/element_of_the_day.dart';
import 'package:periodic_table/widgets/fade_in.dart';
import 'package:periodic_table/widgets/fade_in_slider.dart';
import 'package:periodic_table/widgets/home_appbar.dart';
import 'package:periodic_table/widgets/app_searchbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = context.watch<AppSettings>().state.settings?.name;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppBar(
                title: 'Hello',
                subtitle: name,
                style: Theme.of(context).textTheme.displaySmall,
                action: const Icon(
                  Icons.settings,
                  color: Colors.white70,
                ),
              ),
              FadeIn(
                delay: Duration(milliseconds: 500),
                child: Searchbar(
                  onSearchClick: _navigateToSearchPage,
                ),
                curve: Interval(0.5, 1, curve: Curves.fastOutSlowIn),
              ),
              FadeInSlider(
                child: ElementOfTheDay(),
                delay: Duration(milliseconds: 700),
              ),
              FadeIn(
                delay: Duration(milliseconds: 900),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    bottom: 16,
                  ),
                  child: Text(
                    'Explore',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 60),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  children: [
                    FadeInSlider(
                      delay: const Duration(milliseconds: 700),
                      child: ExploreCard(
                        title: 'Periodic',
                        subtitle: 'Table',
                        onTap: () {
                          Navigator.push(
                            context,
                            buildPage(
                              page: const PeriodicTableScreen(),
                            ),
                          );
                        },
                      ),
                      direction: FadeInSliderDirection.fromBottom,
                    ),
                    FadeInSlider(
                      delay: Duration(milliseconds: 700),
                      child: ExploreCard(
                        title: 'Element',
                        subtitle: 'List',
                        onTap: () {
                          Navigator.push(
                            context,
                            buildPage(
                              page: const PeriodicTableScreen(),
                            ),
                          );
                        },
                      ),
                      direction: FadeInSliderDirection.fromBottom,
                    ),
                  ],
                  childAspectRatio: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onElementList() {}

  void _navigateToSearchPage() {
    DateTime dateTime = DateTime.now();

    //TODO: Navigate Search page
    print('Navigate to search at ${dateTime.toIso8601String()}\n');
  }
}

/*





 */
