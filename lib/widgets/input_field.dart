import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final Stream<String> stream;
  final FocusNode focusNode;
  final String labelText;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color textColor;
  final String initialValue;
  final bool obscureText;

  const InputField({
    Key key,
    this.stream,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.prefixIconColor = Colors.white,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textColor = Colors.white,
    this.initialValue = "",
    this.obscureText = false,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.stream,
      builder: (context, snapshot) {
        return TextField(
          controller: _controller,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            labelText: widget.labelText,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: widget.prefixIconColor,
            ),
            counterText: "",
            errorText: snapshot.error,
          ),
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
          style: TextStyle(
            color: widget.textColor,
          ),
          textCapitalization: TextCapitalization.sentences,
          obscureText: widget.obscureText,
        );
      },
    );
  }
}
