import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/data/daily_element.dart';
import 'package:periodic_table/screens/element_details.dart';
import 'package:periodic_table/utils/helpers.dart';
import 'package:periodic_table/widgets/element_cell.dart';
import 'package:periodic_table/widgets/app_card.dart';

class ElementOfTheDay extends StatefulWidget {
  const ElementOfTheDay({Key? key}) : super(key: key);

  @override
  State<ElementOfTheDay> createState() => _ElementOfTheDayState();
}

class _ElementOfTheDayState extends State<ElementOfTheDay> {
  late Future<Atom>? element;

  @override
  void initState() {
    element = DailyElement.getElementOfTheDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: FutureBuilder<Atom>(
          future: element,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AppCard(
                alignment: Alignment.centerLeft,
                onTap: (snapshot.data != null)
                    ? () {
                        Navigator.of(context).push(
                          buildPage(
                            page: ElementDetails(atom: snapshot.data!),
                            type: PageTransitionType.fade,
                          ),
                        );
                      }
                    : null,
                cornerRadius: 36,
                child: SizedBox(
                  width: 240,
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: _buildDataWidget(snapshot.data!),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const AppCard(
                alignment: Alignment.centerLeft,
                onTap: null,
                cornerRadius: 36,
                child: SizedBox(
                  width: 240,
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Center(
                      child: Text('An error occurred'),
                    ),
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  Widget _buildDataWidget(Atom element) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: element.name!,
            child: ElementCell(
              size: Size(100, 140),
              atom: element,
              filterType: CellFilterType.normal,
            ),
          ),
          Text(
            element.summary ?? '',
            maxLines: 3,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Element\nOf the day',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.lightBlue,
              ),
            ],
          )
        ],
      ),
    );
  }
}
