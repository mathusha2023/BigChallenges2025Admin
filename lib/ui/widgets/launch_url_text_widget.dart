import 'package:bc_admin/ui/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrlTextWidget extends StatelessWidget {
  const LaunchUrlTextWidget({
    super.key,
    required this.url,
    required this.text,
    required this.errorMessage,
  });

  final Uri url;
  final String text;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          if (context.mounted) {
            showErrorSnackBar(context, errorMessage);
          }
        }
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
