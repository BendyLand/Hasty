import 'package:hasty/src/node.dart';
import 'package:hasty/src/style.dart';

// Maps Flutter-like alignment names to CSS flexbox values.
enum MainAxisAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

enum CrossAxisAlignment { start, end, center, stretch }

String _mainAxisCss(MainAxisAlignment a) => switch (a) {
  MainAxisAlignment.start => 'flex-start',
  MainAxisAlignment.end => 'flex-end',
  MainAxisAlignment.center => 'center',
  MainAxisAlignment.spaceBetween => 'space-between',
  MainAxisAlignment.spaceAround => 'space-around',
  MainAxisAlignment.spaceEvenly => 'space-evenly',
};

String _crossAxisCss(CrossAxisAlignment a) => switch (a) {
  CrossAxisAlignment.start => 'flex-start',
  CrossAxisAlignment.end => 'flex-end',
  CrossAxisAlignment.center => 'center',
  CrossAxisAlignment.stretch => 'stretch',
};

String? _mergeStyle(String base, Style? extra) {
  if (extra == null || extra.inlineStyle.isEmpty) return base;
  return '$base; ${extra.inlineStyle}';
}

/// Vertical stack of children — maps to a column flexbox div.
Node vStack({
  List<Node>? children,
  Style? style,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.stretch,
  String? id,
  String? classes,
}) {
  final base =
      'display: flex; flex-direction: column; '
      'justify-content: ${_mainAxisCss(mainAxisAlignment)}; '
      'align-items: ${_crossAxisCss(crossAxisAlignment)}';
  return Node(
    tag: 'div',
    attrs: {'id': id, 'class': classes, 'style': _mergeStyle(base, style)},
    children: children,
  );
}

/// Horizontal stack of children — maps to a row flexbox div.
Node hStack({
  List<Node>? children,
  Style? style,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  String? id,
  String? classes,
}) {
  final base =
      'display: flex; flex-direction: row; '
      'justify-content: ${_mainAxisCss(mainAxisAlignment)}; '
      'align-items: ${_crossAxisCss(crossAxisAlignment)}';
  return Node(
    tag: 'div',
    attrs: {'id': id, 'class': classes, 'style': _mergeStyle(base, style)},
    children: children,
  );
}

/// Layered stack — children are positioned on top of each other.
/// The container is position:relative; children should use position:absolute.
Node zStack({List<Node>? children, Style? style, String? id, String? classes}) {
  return Node(
    tag: 'div',
    attrs: {
      'id': id,
      'class': classes,
      'style': _mergeStyle('position: relative', style),
    },
    children: children,
  );
}

/// Flexible spacer that expands to fill available space in a flex container.
Node spacer() {
  return Node(tag: 'div', attrs: {'style': 'flex: 1'});
}

/// Wraps a single child with padding.
Node padding({
  required Node child,
  double? all,
  double? horizontal,
  double? vertical,
  double? top,
  double? right,
  double? bottom,
  double? left,
}) {
  final parts = <String>[];
  if (all != null) {
    parts.add('padding: ${all}px');
  } else {
    if (vertical != null) {
      parts.add('padding-top: ${vertical}px');
      parts.add('padding-bottom: ${vertical}px');
    }
    if (horizontal != null) {
      parts.add('padding-left: ${horizontal}px');
      parts.add('padding-right: ${horizontal}px');
    }
    if (top != null) parts.add('padding-top: ${top}px');
    if (right != null) parts.add('padding-right: ${right}px');
    if (bottom != null) parts.add('padding-bottom: ${bottom}px');
    if (left != null) parts.add('padding-left: ${left}px');
  }
  return Node(
    tag: 'div',
    attrs: {'style': parts.join('; ')},
    children: [child],
  );
}

/// Centers a child both horizontally and vertically using flexbox.
Node center({required Node child, Style? style}) {
  final base = 'display: flex; justify-content: center; align-items: center';
  return Node(
    tag: 'div',
    attrs: {'style': _mergeStyle(base, style)},
    children: [child],
  );
}
