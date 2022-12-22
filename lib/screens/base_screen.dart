import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../service_locator.dart';

class BaseScreen<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T) onModelReady;

  const BaseScreen(
      {Key? key,
      required ScopedModelDescendantBuilder<T> builder,
      required this.onModelReady})
      : _builder = builder,
        super(key: key);

  @override
  BaseScreenState<T> createState() => BaseScreenState<T>();
}

class BaseScreenState<T extends Model> extends State<BaseScreen<T>> {
  final T _model = locator<T>();

  @override
  void initState() {
    widget.onModelReady(_model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
        model: _model,
        child: ScopedModelDescendant<T>(
            builder: widget._builder, child: Container(color: Colors.red)));
  }
}
