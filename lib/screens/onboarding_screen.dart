import 'package:flutter/material.dart';
import 'package:periodic_table/providers/element_providers.dart';
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

  @override
  void initState() {
    _textEditingController.addListener(_textListener);
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                decoration: InputDecoration(
                    hintText: 'Enter Your name',
                    errorText: hasError ? 'Name Can not be empty' : null),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Set Name'),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() async {
    var text = _textEditingController.text;
    if (text.isEmpty) {
      _showBanner();
      return;
    }

    context.read<AppSettings>().setName(_textEditingController.text);
  }

  void _showBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text('Name can\'t be empty'),
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
