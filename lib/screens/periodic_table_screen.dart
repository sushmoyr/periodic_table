import 'dart:math';

import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/providers/element_list.dart';
import 'package:periodic_table/utils/constants.dart';
import 'package:periodic_table/widgets/element_cell.dart';
import 'package:periodic_table/widgets/home_appbar.dart';
import 'package:periodic_table/widgets/scale_in.dart';
import 'package:provider/provider.dart';

class PeriodicTableScreen extends StatefulWidget {
  const PeriodicTableScreen({Key? key}) : super(key: key);

  @override
  State<PeriodicTableScreen> createState() => _PeriodicTableScreenState();
}

class _PeriodicTableScreenState extends State<PeriodicTableScreen> {
  late List<List<Atom?>> table;
  late final List<Atom> atoms;
  CellFilterType filterType = CellFilterType.normal;

  @override
  void initState() {
    atoms = context.read<ElementList>().state.atoms;

    var state = context.read<ElementList>().state;

    print(state.maxElectronAffinity);
    print(state.minElectronAffinity);

    super.initState();
  }

  Atom? _getElementAtPosition(int x, int y) {
    var found;
    try {
      found = atoms.singleWhere(
        (element) => element.xPos == x && element.yPos == y,
      );
    } catch (e) {
      found = null;
    }
    return found;
  }

  @override
  Widget build(BuildContext context) {
    _buildTableData();
    print(filterType.name);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24),
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultAppBar(
                title: 'Periodic',
                subtitle: 'table',
                designSubtitle: true,
                style: Theme.of(context).textTheme.displaySmall,
                padding: EdgeInsets.only(bottom: 24, left: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Periodic Trend: ',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        PopupMenuButton<CellFilterType>(
                          initialValue: filterType,
                          itemBuilder: (context) => [
                            for (var i in CellFilterType.values)
                              if (i != CellFilterType.none)
                                PopupMenuItem(
                                  child: Text(cellFilterName[i] ?? ''),
                                  value: i,
                                ),
                          ],
                          onSelected: (value) => setState(
                            () {
                              filterType = value;
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  cellFilterName[filterType] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_drop_down_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Table(
                      defaultColumnWidth: FixedColumnWidth(112),
                      children: _buildTableData(),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTableData() {
    List<TableRow> rows = [
      TableRow(children: [
        for (int i = 1; i <= 18; i++)
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(6),
            padding: EdgeInsets.all(4),
            child: Text('$i'),
            decoration: BoxDecoration(
              color: elevatedSurfaceColor,
            ),
          )
      ])
    ];
    for (int i = 1; i <= 10; i++) {
      List<Widget> column = [];
      for (int j = 1; j <= 18; j++) {
        var element = _getElementAtPosition(j, i);
        if (element != null) {
          column.add(
            ScaleIn(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Hero(
                  tag: element.name!,
                  child: ElementCell(
                    size: elementCellSize,
                    atom: element,
                    filterType: filterType,
                  ),
                ),
              ),
            ),
          );
        } else {
          column.add(Container());
        }
      }
      rows.add(
        TableRow(children: column),
      );
    }
    return rows;
  }
}
