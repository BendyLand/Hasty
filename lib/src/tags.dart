import 'package:hasty/src/node.dart';
import 'package:hasty/src/style.dart';

String? _styleAttr(Style? style) {
  if (style == null) return null;
  final s = style.inlineStyle;
  return s.isEmpty ? null : s;
}

// SECTION: Text

enum TextKind { h1, h2, h3, h4, h5, h6, body, caption, label }

String _textTag(TextKind kind) => switch (kind) {
  TextKind.h1 => 'h1',
  TextKind.h2 => 'h2',
  TextKind.h3 => 'h3',
  TextKind.h4 => 'h4',
  TextKind.h5 => 'h5',
  TextKind.h6 => 'h6',
  TextKind.body => 'p',
  TextKind.caption => 'small',
  TextKind.label => 'label',
};

/// A text element. Use [kind] to pick the semantic tag (default: body → <p>).
Node text(
  String content, {
  TextKind kind = TextKind.body,
  Style? style,
  String? classes,
}) {
  return Node(
    tag: _textTag(kind),
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

// SECTION: Headings

Node h1(String content, {Style? style, String? classes}) =>
    text(content, kind: TextKind.h1, style: style, classes: classes);

Node h2(String content, {Style? style, String? classes}) =>
    text(content, kind: TextKind.h2, style: style, classes: classes);

Node h3(String content, {Style? style, String? classes}) =>
    text(content, kind: TextKind.h3, style: style, classes: classes);

Node h4(String content, {Style? style, String? classes}) =>
    text(content, kind: TextKind.h4, style: style, classes: classes);

Node h5(String content, {Style? style, String? classes}) =>
    text(content, kind: TextKind.h5, style: style, classes: classes);

Node h6(String content, {Style? style, String? classes}) =>
    text(content, kind: TextKind.h6, style: style, classes: classes);

// SECTION: Inline Text

/// A paragraph.
Node p(String content, {Style? style, String? classes}) {
  return Node(
    tag: 'p',
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

/// An inline span.
Node span(String content, {Style? style, String? classes}) {
  return Node(
    tag: 'span',
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

/// Bold text.
Node strong(String content, {Style? style, String? classes}) {
  return Node(
    tag: 'strong',
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

/// Italic text.
Node em(String content, {Style? style, String? classes}) {
  return Node(
    tag: 'em',
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

// SECTION: Containers

/// A generic container.
Node div({String? id, String? classes, List<Node>? children, Style? style}) {
  return Node(
    tag: 'div',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A semantic section.
Node section({
  String? id,
  String? classes,
  List<Node>? children,
  Style? style,
}) {
  return Node(
    tag: 'section',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// The main content area.
Node main_({String? id, String? classes, List<Node>? children, Style? style}) {
  return Node(
    tag: 'main',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A page header.
Node header({String? id, String? classes, List<Node>? children, Style? style}) {
  return Node(
    tag: 'header',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A page footer.
Node footer({String? id, String? classes, List<Node>? children, Style? style}) {
  return Node(
    tag: 'footer',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A navigation container.
Node nav({String? id, String? classes, List<Node>? children, Style? style}) {
  return Node(
    tag: 'nav',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A generic article container.
Node article({
  String? id,
  String? classes,
  List<Node>? children,
  Style? style,
}) {
  return Node(
    tag: 'article',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

// SECTION: Lists

/// An unordered list.
Node ul({List<Node>? children, String? classes, Style? style}) {
  return Node(
    tag: 'ul',
    attrs: {'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// An ordered list.
Node ol({List<Node>? children, String? classes, Style? style}) {
  return Node(
    tag: 'ol',
    attrs: {'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A list item.
Node li(String content, {Style? style, String? classes}) {
  return Node(
    tag: 'li',
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

// SECTION: Interactive

/// An anchor link.
Node a({
  required String href,
  required String content,
  String? classes,
  String? target,
  Style? style,
}) {
  return Node(
    tag: 'a',
    content: content,
    attrs: {
      'href': href,
      'class': classes,
      'target': target,
      'style': _styleAttr(style),
    },
  );
}

/// A button.
Node button(String label, {String? type, String? classes, Style? style}) {
  return Node(
    tag: 'button',
    content: label,
    attrs: {
      'type': type ?? 'button',
      'class': classes,
      'style': _styleAttr(style),
    },
  );
}

// SECTION: Media

/// An image.
Node img({required String src, String? alt, String? classes, Style? style}) {
  return Node(
    tag: 'img',
    attrs: {
      'src': src,
      'alt': alt,
      'class': classes,
      'style': _styleAttr(style),
    },
  );
}

/// A horizontal rule (divider).
Node hr({Style? style}) {
  return Node(tag: 'hr', attrs: {'style': _styleAttr(style)});
}

/// A line break.
Node br() => Node(tag: 'br');

/// Injects [html] as-is without any escaping.
/// UNSAFE — only use this with content you fully control.
/// Never pass user-supplied data to this function.
// ignore: non_constant_identifier_names
Node raw(String html) => Node(tag: 'span', content: html, rawHtml: true);

// SECTION: Forms

/// A form container.
Node form({
  String? action,
  String? method,
  String? id,
  String? classes,
  Style? style,
  List<Node>? children,
}) {
  return Node(
    tag: 'form',
    attrs: {
      'action': action,
      'method': method,
      'id': id,
      'class': classes,
      'style': _styleAttr(style),
    },
    children: children,
  );
}

/// A form input (void element — no children).
Node input({
  String type = 'text',
  String? name,
  String? id,
  String? value,
  String? placeholder,
  String? min,
  String? max,
  String? step,
  String? pattern,
  String? accept,
  String? classes,
  Style? style,
  bool required = false,
  bool disabled = false,
  bool readonly = false,
  bool checked = false,
}) {
  return Node(
    tag: 'input',
    attrs: {
      'type': type,
      'name': name,
      'id': id,
      'value': value,
      'placeholder': placeholder,
      'min': min,
      'max': max,
      'step': step,
      'pattern': pattern,
      'accept': accept,
      'class': classes,
      'style': _styleAttr(style),
    },
    boolAttrs: [
      if (required) 'required',
      if (disabled) 'disabled',
      if (readonly) 'readonly',
      if (checked) 'checked',
    ],
  );
}

/// A multi-line text input.
Node textarea({
  String? name,
  String? id,
  String? placeholder,
  int? rows,
  int? cols,
  String? content,
  String? classes,
  Style? style,
  bool required = false,
  bool disabled = false,
  bool readonly = false,
}) {
  return Node(
    tag: 'textarea',
    content: content,
    attrs: {
      'name': name,
      'id': id,
      'placeholder': placeholder,
      'rows': rows?.toString(),
      'cols': cols?.toString(),
      'class': classes,
      'style': _styleAttr(style),
    },
    boolAttrs: [
      if (required) 'required',
      if (disabled) 'disabled',
      if (readonly) 'readonly',
    ],
  );
}

/// A dropdown selector.
Node select({
  String? name,
  String? id,
  String? classes,
  Style? style,
  List<Node>? children,
  bool required = false,
  bool disabled = false,
  bool multiple = false,
}) {
  return Node(
    tag: 'select',
    attrs: {
      'name': name,
      'id': id,
      'class': classes,
      'style': _styleAttr(style),
    },
    children: children,
    boolAttrs: [
      if (required) 'required',
      if (disabled) 'disabled',
      if (multiple) 'multiple',
    ],
  );
}

/// An option inside a [select].
Node option({
  required String value,
  required String content,
  bool selected = false,
  bool disabled = false,
}) {
  return Node(
    tag: 'option',
    content: content,
    attrs: {'value': value},
    boolAttrs: [if (selected) 'selected', if (disabled) 'disabled'],
  );
}

/// A grouped set of [option]s inside a [select].
Node optgroup({
  required String label,
  List<Node>? children,
  bool disabled = false,
}) {
  return Node(
    tag: 'optgroup',
    attrs: {'label': label},
    children: children,
    boolAttrs: [if (disabled) 'disabled'],
  );
}

/// A labelled group of form controls.
Node fieldset({
  String? id,
  String? classes,
  Style? style,
  List<Node>? children,
  bool disabled = false,
}) {
  return Node(
    tag: 'fieldset',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
    boolAttrs: [if (disabled) 'disabled'],
  );
}

/// A caption for a [fieldset].
Node legend(String content, {String? classes, Style? style}) {
  return Node(
    tag: 'legend',
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

/// A form label. Use [htmlFor] to associate it with an input's id.
/// Supply either [content] for plain text or [children] for richer markup.
Node label({
  String? htmlFor,
  String? content,
  String? classes,
  Style? style,
  List<Node>? children,
}) {
  return Node(
    tag: 'label',
    content: content,
    attrs: {'for': htmlFor, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

// SECTION: Tables

/// A table.
Node table({String? id, String? classes, Style? style, List<Node>? children}) {
  return Node(
    tag: 'table',
    attrs: {'id': id, 'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A table caption (rendered above the table).
Node caption(String content, {String? classes, Style? style}) {
  return Node(
    tag: 'caption',
    content: content,
    attrs: {'class': classes, 'style': _styleAttr(style)},
  );
}

/// A table header group.
Node thead({String? classes, Style? style, List<Node>? children}) {
  return Node(
    tag: 'thead',
    attrs: {'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A table body group.
Node tbody({String? classes, Style? style, List<Node>? children}) {
  return Node(
    tag: 'tbody',
    attrs: {'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A table footer group.
Node tfoot({String? classes, Style? style, List<Node>? children}) {
  return Node(
    tag: 'tfoot',
    attrs: {'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A table row.
Node tr({String? classes, Style? style, List<Node>? children}) {
  return Node(
    tag: 'tr',
    attrs: {'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

enum Scope { col, row, colgroup, rowgroup }

/// A table header cell. Use [scope] to declare what it headers.
Node th({
  String? content,
  int? colspan,
  int? rowspan,
  Scope? scope,
  String? classes,
  Style? style,
  List<Node>? children,
}) {
  return Node(
    tag: 'th',
    content: content,
    attrs: {
      'colspan': colspan?.toString(),
      'rowspan': rowspan?.toString(),
      'scope': scope?.name,
      'class': classes,
      'style': _styleAttr(style),
    },
    children: children,
  );
}

/// A table data cell.
Node td({
  String? content,
  int? colspan,
  int? rowspan,
  String? classes,
  Style? style,
  List<Node>? children,
}) {
  return Node(
    tag: 'td',
    content: content,
    attrs: {
      'colspan': colspan?.toString(),
      'rowspan': rowspan?.toString(),
      'class': classes,
      'style': _styleAttr(style),
    },
    children: children,
  );
}

/// A group of columns — lets you apply styles to whole columns at once.
Node colgroup({String? classes, Style? style, List<Node>? children}) {
  return Node(
    tag: 'colgroup',
    attrs: {'class': classes, 'style': _styleAttr(style)},
    children: children,
  );
}

/// A single column definition inside a [colgroup] (void element).
Node col({int? span, String? classes, Style? style}) {
  return Node(
    tag: 'col',
    attrs: {
      'span': span?.toString(),
      'class': classes,
      'style': _styleAttr(style),
    },
  );
}
