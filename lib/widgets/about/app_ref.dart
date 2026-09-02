import 'package:aves/model/device.dart';
import 'package:aves/ref/locales.dart';
import 'package:aves/theme/icons.dart';
import 'package:aves/widgets/about/policy_page.dart';
import 'package:aves/widgets/common/basic/link_chip.dart';
import 'package:aves/widgets/common/extensions/build_context.dart';
import 'package:aves/widgets/common/identity/aves_logo.dart';
import 'package:flutter/material.dart';

class AppReference extends StatelessWidget {
  static const projectGithub = 'https://github.com/CookieCums/Aves-Next';
  static const projectFaq = '$projectGithub/wiki/FAQ';
  static const appName = 'Aves-Next';

  const AppReference({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _buildAppLine(context),
          const SizedBox(height: 16),
          Wrap(
            alignment: .center,
            spacing: 16,
            crossAxisAlignment: .center,
            children: AppReference.buildLinks(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAppLine(BuildContext context) {
    final localeName = context.localeName;
    final textScaler = MediaQuery.textScalerOf(context);
    return Row(
      mainAxisSize: .min,
      children: [
        AvesLogo(
          size: textScaler.scale(_getAppTitleStyle(localeName).fontSize!) * 1.3,
        ),
        const SizedBox(width: 8),
        Text(
          appName,
          style: _getAppTitleStyle(localeName),
        ),
        const SizedBox(width: 8),
        Text(
          device.packageVersion,
          style: _getAppTitleStyle(localeName),
        ),
      ],
    );
  }

  TextStyle _getAppTitleStyle(String localeName) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    letterSpacing: canHaveLetterSpacing(localeName) ? 1 : 0,
    fontFeatures: const [FontFeature.enable('smcp')],
  );

  static List<Widget> buildLinks(BuildContext context) {
    final l10n = context.l10n;
    return [
      const LinkChip(
        leading: Icon(
          AIcons.github,
          size: 24,
        ),
        text: 'GitHub',
        urlString: AppReference.projectGithub,
      ),
      LinkChip(
        leading: const Icon(
          AIcons.legal,
          size: 22,
        ),
        text: l10n.aboutLinkLicense,
        urlString: '${AppReference.projectGithub}/blob/develop/LICENSE',
      ),
      LinkChip(
        leading: const Icon(
          AIcons.privacy,
          size: 22,
        ),
        text: l10n.aboutLinkPolicy,
        onTap: () => _goToPolicyPage(context),
      ),
    ];
  }

  static void _goToPolicyPage(BuildContext context) {
    Navigator.maybeOf(context)?.push(
      MaterialPageRoute(
        settings: const RouteSettings(name: PolicyPage.routeName),
        builder: (context) => const PolicyPage(),
      ),
    );
  }
}
