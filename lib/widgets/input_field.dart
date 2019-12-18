import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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
  final List<TextInputFormatter> inputFormatters;
  final String prefixText;

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
    this.inputFormatters,
    this.prefixText,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final _controller = TextEditingController();
  final _layer = LayerLink();
  final _suggestions = BehaviorSubject<List<String>>();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
    _focus.addListener(() {
      if (_focus.hasFocus) {
      } else {}
    });
    widget.focusNode?.addListener(() {
      if (_focus.hasFocus) {
      } else {}
    });
  }

  @override
  void didUpdateWidget(InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != this.widget) {
      if (oldWidget.focusNode == null && this.widget.focusNode != null)
        widget.focusNode?.addListener(() {
          if (_focus.hasFocus) {
          } else {}
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _suggestions.close();
    _focus.dispose();
    super.dispose();
  }

  OverlayEntry _overlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    final size = renderBox.size;
    return OverlayEntry(builder: (context) {
      return Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layer,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            elevation: 2.0,
            child: StreamBuilder<List<String>>(
              stream: _suggestions.stream,
              builder: (context, snapshot) {},
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: widget.stream,
      builder: (context, snapshot) {
        return CompositedTransformTarget(
          link: _layer,
          child: TextField(
            controller: _controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              labelText: widget.labelText,
              prefixText: widget.prefixText,
              prefixIcon: widget.prefixText == null && widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: snapshot.hasError
                          ? Colors.red
                          : widget.prefixIconColor,
                    )
                  : null,
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
            inputFormatters: widget.inputFormatters,
          ),
        );
      },
    );
  }
}
