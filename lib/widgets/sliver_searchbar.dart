import 'package:flutter/material.dart';
import 'package:periodic_table/utils/constants.dart';

class SliverSearchbar extends StatelessWidget {
  const SliverSearchbar({Key? key, this.onSearchClick}) : super(key: key);
  final VoidCallback? onSearchClick;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: GestureDetector(
          onTap: onSearchClick,
          child: Material(
            type: MaterialType.card,
            color: searchbarBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            'Search for elements...',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Divider(
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
