import 'package:flutter/material.dart';
import 'package:pesen_id/utils/app_text.dart';

class DynamicError extends StatelessWidget {
  const DynamicError({
    Key? key,
    required String errorMsg,
  })  : _errorMsg = errorMsg,
        super(key: key);

  final String? _errorMsg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText.labelMontsW500(
        _errorMsg!,
        16,
        Colors.grey,
      ),
    );
  }
}
