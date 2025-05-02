import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/textfield.dart';
import 'package:fresh_kart/features/settings/data/models/address_model.dart';
import 'package:fresh_kart/features/settings/presentation/providers/setting_provider.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/utils/app_strings.dart';

class UpdateAddressComponent extends ConsumerStatefulWidget {
  const UpdateAddressComponent({super.key, required this.addressModel});
  final AddressModel? addressModel;
  @override
  ConsumerState<UpdateAddressComponent> createState() =>
      _UpdateAddressComponentState();
}

class _UpdateAddressComponentState
    extends ConsumerState<UpdateAddressComponent> {
  late TextEditingController addressController;
  late TextEditingController pincodeController;
  late TextEditingController altMobileController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    addressController =
        TextEditingController(text: widget.addressModel?.address ?? "");
    pincodeController =
        TextEditingController(text: widget.addressModel?.pincode ?? "");
    altMobileController = TextEditingController(
        text: widget.addressModel?.alternateMobileNo ?? "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Update Address', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          // Address field
          CustomTextField(
            controller: addressController,
            labelText: AppStrings.newAddress,
            hintText: '',
            validator: (text) {
              if (text?.isEmpty ?? true) return AppStrings.emailEmptyError;
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Pincode field
          CustomTextField(
            controller: pincodeController,
            labelText: 'Pincode',
            hintText: 'Enter pincode',
            maxLength: 6,
            keyboardType: TextInputType.number,
            validator: (text) {
              if (text == null || text.isEmpty) return 'Pincode is required';
              if (text.length != 6) return 'Pincode must be 6 digits';
              return null;
            },
          ),
          const SizedBox(height: 10),
          // Alternative mobile number field
          CustomTextField(
            controller: altMobileController,
            labelText: 'Alternative Mobile Number',
            hintText: 'Enter alternative number',
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Mobile number is required';
              }
              if (text.length != 10) return 'Mobile number must be 10 digits';
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                ref.read(settingProvider.notifier).updateAddress(
                  context: context,
                  addressController.text,
                  pincodeController.text,
                  altMobileController.text,
                  onComplete: () {
                    CustomNavigator.pop(context);
                  },
                );
              }
            },
            child: const Text(AppStrings.submit),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
