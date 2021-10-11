import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_codes/country_codes.dart';
import 'package:dairo/presentation/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class WidgetPhoneNumberInputField extends StatefulWidget {
  final ValueChanged<String?>? onCountryCodeChanged;
  final TextEditingController? controller;

  WidgetPhoneNumberInputField({
    @required this.onCountryCodeChanged,
    this.controller,
  });

  @override
  _WidgetPhoneNumberInputFieldState createState() =>
      _WidgetPhoneNumberInputFieldState();
}

class _WidgetPhoneNumberInputFieldState
    extends State<WidgetPhoneNumberInputField> {
  Color borderColor = AppColors.baseBackgroundColor;

  String? _selectedCountryCode = CountryCodes.dialCode(
    CountryCodes.getDeviceLocale(),
  );

  @override
  void initState() {
    widget.onCountryCodeChanged!(_selectedCountryCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Row(
            children: [
              CountryCodePicker(
                boxDecoration: BoxDecoration(
                  color: AppColors.darkAccentColor,
                ),
                padding: EdgeInsets.zero,
                textStyle: TextStyle(fontSize: 15, color: AppColors.white),
                onChanged: (code) => updateCountryCode(code.dialCode),
                showFlagDialog: false,
                builder: (code) => Text(
                  _selectedCountryCode ?? '',
                  style: TextStyle(fontSize: 15, color: AppColors.white),
                ),
              ),
              Expanded(
                child: _phoneTextInputField(context),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Container(
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            ),
          ),
        ],
      );

  Widget _phoneTextInputField(BuildContext context) => TextFormField(
        controller: widget.controller,
        style: TextStyle(fontSize: 15, color: AppColors.white),
        keyboardType: TextInputType.number,
        cursorColor: AppColors.white,
        cursorWidth: 1.5,
        decoration: InputDecoration(
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 4),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        textInputAction: TextInputAction.done,
      );

  void updateCountryCode(String? code) {
    widget.onCountryCodeChanged!(code);
    setState(() => _selectedCountryCode = code);
  }
}
