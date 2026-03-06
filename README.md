# Hasty

A SwiftUI-inspired static site generator for Dart. Compose HTML pages using typed, composable functions — no raw strings, no templates, no fuss.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  hasty: ^0.0.2
```

Then run:

```sh
dart pub get
```

## Quick Start

```dart
import 'package:hasty/hasty.dart';

void main() async {
  final page = vStack(
    id: 'app',
    style: Style(fontFamily: 'sans-serif', padding: 24, maxWidth: 800),
    children: [
      h1('Hello, Hasty!', style: Style(color: Colors.indigo)),
      p('A page built entirely in Dart.'),
    ],
  );

  await emit(page, title: 'Hello Hasty'); // writes build/index.html
}
```

## Concepts

### Nodes

Everything is a `Node` — a lightweight representation of an HTML element. Tag functions like `div`, `h1`, and `p` return nodes that you compose into a tree.

### Layout

Hasty provides Flutter-style layout primitives that map to CSS flexbox:

```dart
hStack(
  children: [
    h1('My Site'),
    spacer(), // expands to push nav to the right
    nav(children: [
      hStack(style: Style(gap: 16), children: [
        a(href: '#about', content: 'About'),
        a(href: '#contact', content: 'Contact'),
      ]),
    ]),
  ],
)
```

| Function   | HTML output              | Description                              |
|------------|--------------------------|------------------------------------------|
| `vStack`   | `<div>` (flex column)    | Vertical stack                           |
| `hStack`   | `<div>` (flex row)       | Horizontal stack                         |
| `zStack`   | `<div>` (relative)       | Layered stack (children use absolute)    |
| `spacer`   | `<div>` (flex: 1)        | Expands to fill remaining space          |
| `padding`  | `<div>`                  | Wraps a child with configurable padding  |
| `center`   | `<div>` (flex center)    | Centers a child horizontally/vertically  |

Both `hStack` and `vStack` accept `MainAxisAlignment` and `CrossAxisAlignment` to control child alignment.

### Styles

Use the `Style` class for type-safe inline CSS — no raw strings needed:

```dart
Style(
  color: Colors.indigo,
  backgroundColor: Colors.white,
  padding: 16,
  borderRadius: 8,
  border: '1px solid ${Colors.lightGray}',
  fontWeight: FontWeight.semibold,
  textAlign: TextAlign.center,
)
```

**Colors** — `Colors.black`, `Colors.white`, `Colors.red`, `Colors.orange`, `Colors.yellow`, `Colors.green`, `Colors.teal`, `Colors.blue`, `Colors.indigo`, `Colors.purple`, `Colors.pink`, `Colors.gray`, `Colors.lightGray`, `Colors.darkGray`, `Colors.transparent`

Custom colors: `Color.hex('#ff6600')`, `Color.rgb(255, 102, 0)`, `Color.rgba(255, 102, 0, 0.5)`

**FontWeight** — `thin`, `light`, `normal`, `medium`, `semibold`, `bold`, `extrabold`

**Enums** — `TextAlign`, `TextDecoration`, `Position`, `Display`, `Float`, `FlexWrap`, `AlignSelf`

### Tags

#### Headings
`h1` `h2` `h3` `h4` `h5` `h6`

#### Text
`p` `span` `strong` `em` — and `text(content, kind: TextKind.caption)` for the full set (`h1`–`h6`, `body`, `caption`, `label`)

#### Containers
`div` `section` `article` `main_` `header` `footer` `nav`

#### Lists
```dart
ul(children: [
  li('First item'),
  li('Second item'),
])
```

#### Links & Buttons
```dart
a(href: 'https://example.com', content: 'Visit', target: '_blank')
button('Submit', type: 'submit')
```

#### Media
`img(src: 'photo.png', alt: 'A photo')` `hr()` `br()`

#### Forms

```dart
form(
  action: '/contact',
  method: 'post',
  children: [
    label(htmlFor: 'email', content: 'Email'),
    input(type: 'email', id: 'email', name: 'email', required: true),
    textarea(name: 'message', placeholder: 'Your message', rows: 5),
    select(name: 'topic', children: [
      option(value: 'support', content: 'Support'),
      option(value: 'sales', content: 'Sales', selected: true),
    ]),
    button('Send', type: 'submit'),
  ],
)
```

#### Tables

```dart
table(children: [
  caption('Team'),
  thead(children: [
    tr(children: [
      th(content: 'Name', scope: Scope.col),
      th(content: 'Role', scope: Scope.col),
    ]),
  ]),
  tbody(children: [
    tr(children: [td(content: 'Alice'), td(content: 'Engineer')]),
    tr(children: [td(content: 'Bob'),   td(content: 'Designer')]),
  ]),
])
```

#### Raw HTML

For trusted content only — bypasses escaping:

```dart
raw('<strong>bold</strong>')
```

Never pass user-supplied data to `raw`.

### Emitting output

```dart
// Write build/index.html — output is automatically prettified
await emit(page, title: 'My Site');

// Custom output directory, file name, and language
await emit(page, outputDir: 'public', fileName: 'about', title: 'About', lang: 'fr');

// Get the raw HTML string without writing any files
final html = renderHtml(page);
```

`emit` displays a progress spinner via `mason_logger` and prints a green ✓ with elapsed time on completion.

### CLI argument parsing

Hasty includes a lightweight argument parser for build scripts:

```dart
import 'dart:io';
import 'package:hasty/hasty.dart';

void main(List<String> args) async {
  final parser = Parser();
  parser.register('output', 'Output directory', type: String);
  parser.register('--minify', 'Skip formatting');

  try {
    parser.parse(args);
  } catch (e) {
    print(e);
    exit(1);
  }

  final outDir = parser.getParsed()['output'] ?? 'build';
  await emit(page, outputDir: outDir);
}
```

Flags can be passed as `output=public`, `output:public`, or `output public`.

## Full Example

See [`example/hasty_example.dart`](example/hasty_example.dart) for a complete page demonstrating nav with `spacer`, a `padding`/`center` hero, a `ul`/`li` feature list, a specs table, a contact form, and CLI argument parsing.

See [`bin/hasty.dart`](bin/hasty.dart) for a working blog layout that additionally shows inline text styling with `span` and `FontWeight`.
