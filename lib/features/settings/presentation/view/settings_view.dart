import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/settings/presentation/components/update_address_component.dart';
import 'package:fresh_kart/features/settings/presentation/providers/setting_provider.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/features/user/presentation/provider/login_providers.dart';
import 'package:fresh_kart/utils/app_strings.dart';
import 'package:fresh_kart/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch<UserEntity>(settingProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  child: Icon(Icons.person, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.fullName, style: theme.textTheme.titleMedium),
                      Text(user.email,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Personal Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(AppStrings.contactInfoSection),
                    _ClickableTile(
                      icon: Icons.phone,
                      label: AppStrings.phoneNumberLabel,
                      value: user.phoneNo,
                      onTap: () => _openDialer(user.phoneNo),
                    ),
                    const Divider(height: 24),
                    _SectionTitle(AppStrings.addressSection),
                    Row(
                      children: [
                        Expanded(
                          child: _InfoTile(
                            icon: Icons.location_on,
                            label: AppStrings.addressLabel,
                            value: user.address?.address ??
                                AppStrings.addressNotProvided,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_location),
                          onPressed: () {
                            Helper.showBottomSheet(
                              context,
                              child: UpdateAddressComponent(
                                addressModel: user.address,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Logout Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Helper.logout(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text(AppStrings.logoutButton),
            ),
          ],
        ),
      ),
    );
  }

  void _openDialer(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle error
    }
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 2),
              Text(value, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}

class _ClickableTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ClickableTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: _InfoTile(icon: icon, label: label, value: value),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}
