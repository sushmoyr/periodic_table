import 'package:flutter/material.dart';

int index = 0;
var body = Scaffold(
  body: SafeArea(
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(100),
          children: [
            for (List<bool> row in table)
              TableRow(
                children: [
                  for (bool column in row)
                    if (column)
                      Container(
                        height: 150,
                        padding: EdgeInsets.all(16),
                        child: Text(''
                            //style: Theme.of(context).textTheme.headlineSmall,
                            ),
                        /*decoration: BoxDecoration(
                            color: ColorScheme.fromSeed(
                                    seedColor: hexToColor(periodicTable
                                        .elements!
                                        .elementAt(index++)
                                        .cpkHex))
                                .primaryContainer,
                            border: Border.all(color: Colors.black)),*/
                      )
                    else
                      Container()
                ],
              )
          ],
        ),
      ),
    ),
  ),
);

Color hexToColor(String? code) {
  if (code == null) {
    return Colors.black;
  }
  return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
}

List<List<bool>> table = [
  [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    true
  ],
  [
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
  ],
  [
    true,
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
  ],
  [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ],
  [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ],
  [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ],
  [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ],
  [
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    false
  ],
  [
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    false
  ],
];
