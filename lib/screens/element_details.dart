import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:periodic_table/data/atom.dart';
import 'package:periodic_table/utils/constants.dart';
import 'package:periodic_table/widgets/element_cell.dart';
import 'package:periodic_table/utils/helpers.dart';

class ElementDetails extends StatelessWidget {
  const ElementDetails({Key? key, required this.atom}) : super(key: key);

  final Atom atom;

  @override
  Widget build(BuildContext context) {
    var headlineMedium = Theme.of(context).textTheme.headlineMedium;
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    var titleMedium = Theme.of(context).textTheme.titleMedium;
    var titleLarge = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontWeight: FontWeight.w300, fontStyle: FontStyle.italic);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: MediaQuery.of(context).viewPadding.top + 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Hero(
                  tag: atom.name!,
                  child: ElementCell(
                    size: elementCellSize,
                    atom: atom,
                    filterType: CellFilterType.normal,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: elementCellSize.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          atom.name!,
                          style: headlineMedium!
                              .copyWith(color: hexToM3Color(atom.cpkHex)),
                        ),
                        if (atom.appearance != null)
                          Text(
                            '${atom.appearance?.toUpperCaseFirst()}',
                            style: titleLarge,
                          ),
                        if (atom.category != null)
                          Text(
                            '${atom.category?.toUpperCaseFirst()}',
                            style: titleMedium!
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                        Text(
                          'Number: ${atom.number}',
                          style: titleMedium,
                        ),
                        Text(
                          'Atomic Mass: ${atom.atomicMass}',
                          style: titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            verticalGap16,
            if (atom.summary != null) ...[
              Text(
                'Summary',
                style: headlineSmall,
              ),
              verticalGap16,
              Text(
                atom.summary!,
                style: const TextStyle(
                  fontSize: 16,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
            verticalGap16,
            LabelTextSection(
              children: [
                if (atom.discoveredBy != null)
                  LabelText(label: 'Discovered By', text: atom.discoveredBy!),
                if (atom.namedBy != null)
                  LabelText(label: 'Named By', text: atom.namedBy!),
                if (atom.period != null)
                  LabelText(
                    label: 'Period',
                    text: atom.period!.toString(),
                  ),
                if (atom.yPos != null)
                  LabelText(
                    label: 'Group',
                    text: atom.yPos!.toString(),
                  ),
                if (atom.phase != null)
                  LabelText(
                    label: 'Phase',
                    text: atom.phase!.toString(),
                  ),
                if (atom.density != null)
                  LabelText(
                    label: 'Density',
                    text: atom.density!.toString(),
                  ),
                if (atom.boil != null)
                  LabelText(
                    label: 'Boiling Temperature',
                    text: atom.boil!.toStringAsFixed(2),
                  ),
                if (atom.melt != null)
                  LabelText(
                    label: 'Melting Point',
                    text: atom.melt!.toStringAsFixed(2),
                  ),
                if (atom.molarHeat != null)
                  LabelText(
                    label: 'Molar Heat',
                    text: atom.molarHeat!.toString(),
                  ),
                if (atom.electronAffinity != null)
                  LabelText(
                    label: 'Electron Affinity',
                    text: atom.electronAffinity!.toString(),
                  ),
                if (atom.electronegativityPauling != null)
                  LabelText(
                    label: 'Electron Negativity Pauling',
                    text: atom.electronegativityPauling!.toString(),
                  ),
                if (atom.electronConfiguration != null)
                  LabelText(
                    label: 'Electron Configuration',
                    text: atom.electronConfiguration!.toString(),
                  ),
              ],
            ),
            //TODO: Electron Animation
            ElectronAnimation(shells: atom.shells!),
            LabelTextSection(
              children: [
                if (atom.shells != null)
                  LabelText(
                    label: 'Shells',
                    text: atom.shells.toString(),
                  ),
                if (atom.ionizationEnergies != null)
                  LabelText(
                    label: 'Ionization Energies',
                    text: atom.ionizationEnergies!.toString(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ElectronAnimation extends StatefulWidget {
  const ElectronAnimation({Key? key, required this.shells}) : super(key: key);
  final List<num> shells;

  @override
  State<ElectronAnimation> createState() => _ElectronAnimationState();
}

class _ElectronAnimationState extends State<ElectronAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.reset();
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double value = 0;

  @override
  Widget build(BuildContext context) {
    List<int> eShells = widget.shells.map((e) => e.toInt()).toList();
    return Column(
      children: [
        AnimatedBuilder(
          builder: (BuildContext context, Widget? child) {
            return LayoutBuilder(builder: (context, size) {
              return SizedBox(
                width: size.maxWidth,
                height: size.maxWidth,
                child: CustomPaint(
                  painter: ElectronPainter(eShells, _controller.value),
                ),
              );
            });
          },
          animation: _controller,
        ),
      ],
    );
  }
}

class ElectronPainter extends CustomPainter {
  final List<int> shells;
  final double fraction;

  static const double _minRadius = 30;
  static const double _electronRadii = 4;

  ElectronPainter(this.shells, this.fraction);

  @override
  void paint(Canvas canvas, Size size) {
    int periods = shells.length;

    double maxSize = (size.width - 16) / 2;

    double radius = min((maxSize / periods), _minRadius);

    Offset center = Offset(size.width / 2, size.height / 2);

    double maxAngle = 2 * pi;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue;
    Paint ePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    for (int i = 0; i < periods; i++) {
      var r = (i + 1) * radius;
      canvas.drawCircle(center, r, paint);

      var electronCount = shells[i];

      var angleOffset = (pi * 2) / electronCount;

      var t = (maxAngle * fraction);
      var threshold = (i % 2 == 0) ? t : 1 - t;

      for (int e = 0; e < electronCount; e++) {
        Offset ePoint = Offset.fromDirection(
            (angleOffset * e + 1) + threshold, r + (_electronRadii / 2));
        canvas.drawCircle(center + ePoint, _electronRadii, ePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LabelText {
  final String label;
  final String text;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;

  LabelText({
    required this.label,
    required this.text,
    this.labelStyle,
    this.textStyle,
  });
}

class LabelTextSection extends StatelessWidget {
  const LabelTextSection({Key? key, required this.children}) : super(key: key);

  final List<LabelText> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children
          .map(
            (e) => _buildLabelText(e),
          )
          .toList(),
    );
  }

  Widget _buildLabelText(LabelText labelText) {
    const labelStyle = TextStyle(
      fontSize: 16,
      wordSpacing: 1,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );

    const textStyle = TextStyle(
      fontSize: 16,
      wordSpacing: 1,
      fontWeight: FontWeight.w300,
      height: 1.5,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${labelText.label}: ',
          style: labelText.labelStyle ?? labelStyle,
        ),
        Expanded(
          child: Text(
            labelText.text,
            style: labelText.textStyle ?? textStyle,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
