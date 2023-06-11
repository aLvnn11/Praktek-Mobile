import 'package:flutter/material.dart';
import 'package:basic/fullscreen_dialog.dart';
import 'package:basic/provider10.dart';
import 'package:provider/provider.dart';

class Screen10 extends StatefulWidget {
  const Screen10({super.key});

  @override
  State<Screen10> createState() => _Screen10State();
}

class _Screen10State extends State<Screen10> {
  List<String> ringtones = [
    'None',
    'None',
    'None',
    'None',
    'None',
    'None',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktek M10'),
        backgroundColor: Color.fromARGB(255, 226, 46, 1),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          MaterialBanner(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Banner',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Text.')
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context)
                  ..removeCurrentMaterialBanner()
                  ..showMaterialBanner(showBanner(context, '')),
                child: const Text('Show Banner'),
              ),
            ],
          ),
          MaterialBanner(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Dialogs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Alvin Laia')
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => showPeringatan(context),
                ),
                child: const Text('Alert'),
              ),
              TextButton(
                onPressed: () => showRingtoneDialog(context),
                child: const Text('Simple Dialog'),
              ),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: ((context) => const FullScreenDialog()))),
                  child: const Text('Fullscreen Dialog'))
            ],
          ),
          MaterialBanner(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Snackbars',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                    'Snackbars provide brief messages about app processes at the bottom of the screen.'),
              ],
            ),
            actions: [
              TextButton(
                  child: const Text('Snackbar'),
                  onPressed: () => ScaffoldMessenger.of(context)
                      .showSnackBar((showSnackBar10(context, '')))),
            ],
          ),
        ],
      ),
    );
  }

  showBanner(BuildContext context, info) {
    return MaterialBanner(
      content: Text('Ringtone telah diubah menjadi $info'),
      leading: const Icon(
        Icons.info,
        color: Colors.red,
      ),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(showSnackBar10(context, info));
          },
          child: const Text('Update'),
        ),
        TextButton(
          onPressed: () =>
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          child: const Text('Dismiss'),
        ),
      ],
    );
  }

  showPeringatan(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset settings?'),
      content: const Text(
          'This will reset your device to its default factory settings.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }

  showSnackBar10(BuildContext context, info) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 6),
      content: Text('Ringtone $info telah diterapkan'),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () => ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..removeCurrentMaterialBanner(),
      ),
    );
  }

  showRingtoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext peringatan) {
        final provider = Provider.of<Provider10>(peringatan);
        return AlertDialog(
          title: const Text('Select Ringtone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (var ringtone in provider.ringtones)
                RadioListTile(
                  title: Text(ringtone),
                  value: ringtone,
                  groupValue: provider.selectedRingtone,
                  onChanged: (value) {
                    provider.selectedRingtone = value.toString();
                  },
                ),

              // Add more radio list tiles for each ringtone
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showMaterialBanner(
                    showBanner(context, provider.selectedRingtone));
                print('Selected Ringtone: ${provider.selectedRingtone}');
                Navigator.of(peringatan).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
