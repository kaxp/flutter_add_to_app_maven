import 'package:url_launcher/url_launcher.dart';

const WebViewConfiguration wc = WebViewConfiguration(
  enableJavaScript: true,
  enableDomStorage: true,
);

Future<void> launchURL(String url, {bool allowExternal = true}) async {
  try {
    final String encodedUrl = Uri.encodeFull(url);
    if (await canLaunchUrl(Uri.parse(encodedUrl))) {
      await launchUrl(
        Uri.parse(encodedUrl),
        webViewConfiguration: wc,
        mode: allowExternal ? LaunchMode.externalApplication : LaunchMode.platformDefault,
      );
    }
  } catch (e) {
  }
}

Future<void> launchURI(Uri uri, {bool allowExternal = true}) async {
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        Uri.parse(uri.toString()),
        webViewConfiguration: wc,
        mode: allowExternal ? LaunchMode.externalApplication : LaunchMode.platformDefault,
      );
    }
  } catch (e) {
  }
}
