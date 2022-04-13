import 'package:flutter/material.dart';
import 'package:periodic_table/providers/app_settings.dart';
import 'package:periodic_table/widgets/home_appbar.dart';
import 'package:periodic_table/widgets/sliver_searchbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = context.watch<AppSettings>().state.settings?.name;

    return Scaffold(
      body: CustomScrollView(
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
        ],
      ),
    );
  }

  void _navigateToSearchPage() {
    //TODO: Navigate Search page
    print('Navigate to search');
  }
}
