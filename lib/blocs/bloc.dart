import 'package:flutter/widgets.dart';

Type _typeOf<T>() => T;

typedef _Dispose<T> = void Function(BuildContext context, T bloc);

class Bloc<T> extends StatefulWidget {
  final Widget child;
  final T bloc;
  final _Dispose<T> dispose;

  const Bloc({Key key, this.bloc, this.child, this.dispose}) : super(key: key);

  static T of<T>(BuildContext context) {
    final inherited =
        context.inheritFromWidgetOfExactType(_typeOf<_BlocInherited<T>>())
            as _BlocInherited<T>;
    return inherited.bloc;
  }

  @override
  _BlocState<T> createState() => _BlocState<T>();
}

class _BlocState<T> extends State<Bloc<T>> {
  @override
  void dispose() {
    widget.dispose(context, widget.bloc);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocInherited<T> extends InheritedWidget {
  const _BlocInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  })  : assert(child != null),
        super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocInherited<T> old) {
    return false;
  }
}
