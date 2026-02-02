import 'package:hasty/src/element.dart';

/// A wrapper class for any elements that do not require any extras nor tags.
/// This class exists mainly for type compatibility.
class Primitive extends Element {
  final dynamic value;
  const Primitive(this.value);
  @override
  String get str => value.toString();
}
