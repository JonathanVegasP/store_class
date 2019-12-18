import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:rxdart/rxdart.dart';

typedef _OnItemPressed = String Function(dynamic);
typedef _OnSuggestionsChanged = Future<List> Function(String);

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
  final _OnItemPressed onItemPressed;
  final _OnSuggestionsChanged items;

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
    this.onItemPressed,
    this.items,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> with ChangeNotifier {
  final _controller = TextEditingController();
  final _layer = LayerLink();
  final _suggestions = BehaviorSubject<List>();
  final _focus = FocusNode();
  OverlayEntry _entry;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
    _focus.addListener(() {
      if (_focus.hasFocus) {
        _entry = _overlayEntry();
        Overlay.of(context).insert(_entry);
      } else {
        _entry.remove();
      }
    });
    widget.focusNode?.addListener(() {
      if (widget.focusNode.hasFocus) {
        _entry = _overlayEntry();
        Overlay.of(context).insert(_entry);
      } else {
        _entry.remove();
      }
    });
    _controller.addListener(() async {
      final data = _controller.text;
      if (data.isNotEmpty && widget.items != null) {
        final list = await widget.items(_controller.text);
        print(list);
        _suggestions.add(list);
      } else {
        _suggestions.add([]);
      }
    });
  }

  @override
  void didUpdateWidget(InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      if (widget.focusNode != null && !widget.focusNode.hasListeners)
        widget.focusNode?.addListener(() {
          if (widget.focusNode.hasFocus) {
            _entry = _overlayEntry();
            Overlay.of(context).insert(_entry);
          } else {
            _entry.remove();
          }
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
            child: StreamBuilder<List>(
              stream: _suggestions.stream,
              builder: (context, snapshot) {
                return snapshot.hasData && _controller.text.isNotEmpty
                    ? ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                _controller.text =
                                    widget.onItemPressed(snapshot.data[index]);
                                _suggestions.add([]);
                              },
                              title: Text(
                                snapshot.data[index] ?? "",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container();
              },
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
            focusNode:  widget.focusNode ?? _focus,
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
