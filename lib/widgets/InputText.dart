import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';

class InputText extends StatefulWidget {
  final String hint;
  final String label;
  final String counter;

  final BehaviorSubject<String> subject;
  final bool isPassword;
  final bool enabled;
  final int maxLength;
  final int minLines;
  final int maxLines;
  final Function(String) validator;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;
  final AutovalidateMode autovalidate;
  final Function onEditingComplete;
  final bool autofocus;
  final Widget suffixIcon;
  final Widget prefixIcon;

  final EdgeInsets contentPadding;
  final IconData icon;
  final String initialValue;
  final TextInputAction textInputAction;

  InputText({
    @required this.hint,
    @required this.subject,
    this.isPassword = false,
    this.enabled = true,
    this.autovalidate = AutovalidateMode.onUserInteraction,
    this.autofocus = false,
    this.contentPadding,
    this.counter,
    this.initialValue,
    this.textInputAction,
    this.label,
    this.maxLength,
    this.validator,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.icon,
    this.controller,
    this.onEditingComplete,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.prefixIcon,
  });

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  var isShowingPassword = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.subject.stream,
      builder: _textFieldBuilder,
    );
  }

  Widget _textFieldBuilder(context, AsyncSnapshot<String> snapshot) {
    return TextFormField(
      initialValue: widget.initialValue,
      autovalidateMode: widget.autovalidate,
      obscureText: (widget.isPassword) ? !isShowingPassword : false,
      onChanged: widget.subject.sink.add,
      maxLength: widget.maxLength,
      validator: widget.validator,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterText: widget.counter,
        suffix: widget.icon != null ? Icon(widget.icon) : null,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hint,
        labelText: widget.label,
        errorText: snapshot.error,
        suffixIcon: widget.suffixIcon,
        contentPadding: widget.contentPadding,
      ),
    );
  }
}
