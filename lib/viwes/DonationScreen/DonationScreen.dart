import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

class DonationScreen extends StatelessWidget {
  DonationScreen({super.key});
  final Uri _url = Uri.parse('https://ko-fi.com/asport');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(20, 245, 0, 86),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: GlassContainer(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: GlassText('''If it was helpful for you 
                    
Please support me to keep this application in store 

I made this application without any ads and sponsorship'''),
                  ),
                ),
              ),
            ),
            KofiButton(
              kofiName: "my-name",
              kofiColor: KofiColor.Red,
              onDonation: () {
                _launchUrl();
              },
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 120,
              height: 200,
              child: GlassButton(
                child: Row(children: const [
                  Icon(
                    Icons.star_border_purple500,
                    color: Colors.amber,
                  ),
                  GlassText(" Rate App")
                ]),
                //TODO add stores ID
                onPressed: () {
                  LaunchReview.launch();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
