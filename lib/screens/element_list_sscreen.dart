import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/providers/element_list.dart';
import 'package:periodic_table/widgets/element_cell.dart';
import 'package:periodic_table/widgets/home_appbar.dart';
import 'package:periodic_table/widgets/scale_in.dart';
import 'package:provider/provider.dart';

class ElementListScreen extends StatefulWidget {
  const ElementListScreen({Key? key}) : super(key: key);

  @override
  State<ElementListScreen> createState() => _ElementListScreenState();
}

class _ElementListScreenState extends State<ElementListScreen> {
  late final List<Atom> atoms;

  @override
  void initState() {
    atoms = context.read<ElementList>().state.atoms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DefaultAppBar(
                title: 'Element',
                subtitle: 'List',
                designSubtitle: true,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (Atom atom in atoms)
                    ScaleIn(
                      child: Hero(
                        tag: atom.name!,
                        child: ElementCell(
                          size: const Size(100, 150),
                          atom: atom,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

bool isGreater(num a, num b) {
  var res = a.compareTo(b);
  if (res == 1) {
    return true;
  }
  return false;
}
