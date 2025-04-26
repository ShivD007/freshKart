import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/textfield.dart';
import 'package:fresh_kart/features/settings/presentation/providers/setting_provider.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/utils/app_strings.dart';

class UpdateAddressComponent extends ConsumerStatefulWidget {
  const UpdateAddressComponent({super.key});

  @override
  ConsumerState<UpdateAddressComponent> createState() =>
      _UpdateAddressComponentState();
}

class _UpdateAddressComponentState
    extends ConsumerState<UpdateAddressComponent> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Update Address', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        CustomTextField(
          controller: controller,
          labelText: AppStrings.newAddress,
          hintText: '',
          validator: (text) {
            if (text?.isEmpty ?? true) return AppStrings.emailEmptyError;
            return null;
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ref.read(settingProvider.notifier).updateAddress(controller.text,
                onComplete: () {
              CustomNavigator.pop(context);
            });
          },
          child: const Text(AppStrings.submit),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
