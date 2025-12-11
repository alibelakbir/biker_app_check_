import 'package:flutter/material.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_theme.dart';
import '../../../themes/app_raduis.dart';

class PinInput extends StatefulWidget {
  final String? errorText;
  final Function(String) onCompleted;
  final int length;
  final bool autoFocus;

  const PinInput({
    super.key,
    this.errorText,
    required this.onCompleted,
    this.length = 4,
    this.autoFocus = true,
  });

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  late List<String> _pin;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
    _pin = List.filled(widget.length, '');
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length <= 1) {
      _pin[index] = value;

      // Move to next field if input is provided
      if (value.isNotEmpty && index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }

      // Move to previous field if input is deleted
      if (value.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }

      // Check if all fields are filled
      if (_pin.every((digit) => digit.isNotEmpty)) {
        widget.onCompleted(_pin.join());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Code de vérification',
          style: AppTextStyles.base.s12.w500.blackColor,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.length,
            (index) => _buildPinField(index),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.errorText!,
              style: AppTextStyles.base.s12.w400.redColor,
            ),
          ),
      ],
    );
  }

  Widget _buildPinField(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: kRadius8,
        border: Border.all(
          color: widget.errorText != null && widget.errorText!.isNotEmpty
              ? AppColors.red
              : const Color(0xFFE6E2EA),
          width: 1,
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        autofocus: widget.autoFocus && index == 0,
        style: AppTextStyles.base.s20.w600.blackColor,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) => _onChanged(value, index),
      ),
    );
  }
}
