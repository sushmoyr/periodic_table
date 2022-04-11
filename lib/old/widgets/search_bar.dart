/*
import 'package:flutter/material.dart';

class SliverSearchBar extends StatefulWidget {
  const SliverSearchBar({Key? key, this.onFocusChange}) : super(key: key);
  final Function(bool isFocused)? onFocusChange;

  @override
  State<SliverSearchBar> createState() => _SliverSearchBarState();
}

class _SliverSearchBarState extends State<SliverSearchBar>
    with TickerProviderStateMixin {
  bool isFocused = false;
  late double extentSize;

  @override
  void initState() {
    extentSize = 100;
    print('extent $extentSize');
    focusNode.addListener(() {
      widget.onFocusChange?.call(focusNode.hasFocus);
      if (isFocused != focusNode.hasFocus) {
        setState(() {
          isFocused = focusNode.hasFocus;
        });
      }
    });
    super.initState();
  }

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverSearchBarDelegate(
        focusNode: focusNode,
        extentSize: 64,
      ),
      floating: true,
      pinned: true,
    );
  }
}

class SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final FocusNode? focusNode;
  final double extentSize;
  SliverSearchBarDelegate({
    this.focusNode,
    required this.extentSize,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SearchField(
      focusNode: focusNode,
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SearchField extends StatefulWidget {
  const SearchField({Key? key, this.focusNode}) : super(key: key);
  final FocusNode? focusNode;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnClick,
      child: Material(
        elevation: 8,
        child: Hero(
          tag: 'SearchTag',
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.search),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search for elements...',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleOnClick() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchPage(
          focusNode: widget.focusNode,
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.focusNode}) : super(key: key);
  final FocusNode? focusNode;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    widget.focusNode?.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        elevation: 8,
        child: Column(
          children: [
            Hero(
              tag: 'SearchTag',
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: TextField(
                          focusNode: widget.focusNode,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Search for elements...',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: periodicTable.elements!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(periodicTable.elements!.elementAt(index).name!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
