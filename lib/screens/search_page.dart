import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/providers/element_providers.dart';
import 'package:periodic_table/widgets/element_cell.dart';
import 'package:periodic_table/widgets/scale_in.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ElementSearch searchState;
  late List<Atom> result;
  late List<Atom> atoms;

  @override
  void initState() {
    searchState = context.read<ElementSearch>();
    atoms = context.read<ElementList>().state.atoms;
    searchState.addListener(_searchListener);
    result = [];
    super.initState();
  }

  void _searchListener() {
    String term = searchState.state.searchTerm;
    result = atoms.where((element) {
      return (element.name!.toLowerCase().contains(term) ||
              element.number!.toString().contains(term)) &&
          term.isNotEmpty;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Search for elements...',
                  icon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  searchState.setSearchTerm(value);
                },
              ),
              SizedBox(height: 24),
              if (result.isNotEmpty)
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    for (Atom atom in result)
                      ScaleIn(
                        child: Hero(
                          tag: atom.name!,
                          child: ElementCell(
                              size: const Size(100, 150), atom: atom),
                        ),
                      )
                  ],
                )
              /*ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(result[index].name!);
                },
                itemCount: result.length,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
