import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/data/daily_element.dart';
import 'package:periodic_table/utils/constants.dart';
import 'package:periodic_table/widgets/element_cell.dart';
import 'package:periodic_table/widgets/sliver_card.dart';

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
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      sliver: SliverCard(
        alignment: Alignment.centerLeft,
        cornerRadius: 36,
        child: SizedBox(
          width: 240,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: FutureBuilder<Atom>(
              future: element,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildDataWidget(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('An error occurred'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataWidget(Atom element) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementCell(size: Size(100, 140), atom: element),
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
