import 'package:flutter/material.dart';
import 'package:periodic_table/providers/element_providers.dart';
import 'package:periodic_table/screens/home.dart';
import 'package:periodic_table/widgets/element_text.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool hasError = false;

  late ValueNotifier<bool> loading;

  @override
  void initState() {
    _textEditingController.addListener(_textListener);
    loading = ValueNotifier(false);
    super.initState();
  }

  void _textListener() {
    if (_textEditingController.text.isEmpty) {
      setState(() {
        hasError = true;
      });
    } else {
      setState(() {
        hasError = false;
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_textListener);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loading = ValueNotifier(context.watch<AppSettings>().loading);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElementText(
                    text: 'Periodic',
                    letterSpacing: 1,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 42, top: 8),
                    child: ElementText(
                      text: 'Table',
                      style: Theme.of(context).textTheme.displaySmall,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  TextField(
                    controller: _textEditingController,
                    enabled: !context.watch<AppSettings>().loading,
                    decoration: InputDecoration(
                        hintText: 'Enter Your name',
                        errorText: hasError ? 'Name Can not be empty' : null),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: context.watch<AppSettings>().loading
                          ? null
                          : _handleSubmit,
                      child: const Text('Set Name'),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            (context.watch<AppSettings>().loading == true)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() async {
    var text = _textEditingController.text;
    if (text.isEmpty) {
      _showBanner('Name can\'t be empty');
      return;
    }

    var result =
        await context.read<AppSettings>().setName(_textEditingController.text);

    if (result) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      _showBanner('An error occurred. Try again');
    }
  }

  void _showBanner(String message) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
            },
            child: Text('Dismiss'),
          ),
        ],
      ),
    );
  }
}
