import 'package:url_launcher/url_launcher.dart';

void launchPhoneCall(String phoneNumber) async {
  final Uri phoneCallUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(Uri.parse(phoneCallUri.toString()))) {
    await launchUrl(Uri.parse(phoneCallUri.toString()));
  } else {
    // Handle error
    print('Could not launch phone call');
  }
}

void launchWhatsApp(String phoneNumber) async {
  final Uri whatsappUri =
      Uri(scheme: 'https', host: 'wa.me', path: '/$phoneNumber');
  if (await canLaunchUrl(Uri.parse(whatsappUri.toString()))) {
    await launchUrl(Uri.parse(whatsappUri.toString()));
  } else {
    // Handle error
    print('Could not launch WhatsApp');
  }
}

// Function to open Facebook URL
void openUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
