import 'package:flutter/material.dart';
import 'package:periodic_table/data/daily_element.dart';
import 'package:periodic_table/providers/app_settings.dart';
import 'package:periodic_table/providers/element_list.dart';
import 'package:periodic_table/utils/constants.dart';
import 'package:periodic_table/widgets/element_of_the_day.dart';
import 'package:periodic_table/widgets/element_text.dart';
import 'package:periodic_table/widgets/home_appbar.dart';
import 'package:periodic_table/widgets/sliver_card.dart';
import 'package:periodic_table/widgets/sliver_searchbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = context.watch<AppSettings>().state.settings?.name;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            DefaultAppBar(
              title: 'Hello',
              subtitle: name,
              style: Theme.of(context).textTheme.displaySmall,
              action: const Icon(
                Icons.settings,
                color: Colors.white70,
              ),
            ),
            SliverSearchbar(
              onSearchClick: _navigateToSearchPage,
            ),
            ElementOfTheDay(),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 24,
                bottom: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Explore',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 60),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: elevatedSurfaceColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ElementText(
                            text: 'Periodic',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: ElementText(
                              text: 'Table',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: elevatedSurfaceColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ElementText(
                            text: 'Element',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: ElementText(
                              text: 'List',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                childAspectRatio: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSearchPage() {
    DateTime dateTime = DateTime.now();

    //TODO: Navigate Search page
    print('Navigate to search at ${dateTime.toIso8601String()}\n');
  }
}
