import 'package:hasty/hasty.dart';
import 'package:test/test.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Style
  // ---------------------------------------------------------------------------

  group('Style.inlineStyle', () {
    test('gap properties', () {
      final s = Style(gap: 16, rowGap: 8, columnGap: 4);
      expect(s.inlineStyle, contains('gap: 16.0px'));
      expect(s.inlineStyle, contains('row-gap: 8.0px'));
      expect(s.inlineStyle, contains('column-gap: 4.0px'));
    });

    test('position and offsets', () {
      final s = Style(
        position: Position.absolute,
        top: 0,
        right: 10,
        bottom: 20,
        left: 30,
      );
      expect(s.inlineStyle, contains('position: absolute'));
      expect(s.inlineStyle, contains('top: 0.0px'));
      expect(s.inlineStyle, contains('right: 10.0px'));
      expect(s.inlineStyle, contains('bottom: 20.0px'));
      expect(s.inlineStyle, contains('left: 30.0px'));
    });

    test('position enum values', () {
      expect(
        Style(position: Position.static_).inlineStyle,
        contains('position: static'),
      );
      expect(
        Style(position: Position.relative).inlineStyle,
        contains('position: relative'),
      );
      expect(
        Style(position: Position.fixed).inlineStyle,
        contains('position: fixed'),
      );
      expect(
        Style(position: Position.sticky).inlineStyle,
        contains('position: sticky'),
      );
    });

    test('zIndex', () {
      expect(Style(zIndex: 10).inlineStyle, contains('z-index: 10'));
    });

    test('display enum values', () {
      expect(
        Style(display: Display.flex).inlineStyle,
        contains('display: flex'),
      );
      expect(
        Style(display: Display.grid).inlineStyle,
        contains('display: grid'),
      );
      expect(
        Style(display: Display.none).inlineStyle,
        contains('display: none'),
      );
      expect(
        Style(display: Display.inlineBlock).inlineStyle,
        contains('display: inline-block'),
      );
    });

    test('float', () {
      expect(Style(float: Float.left).inlineStyle, contains('float: left'));
      expect(Style(float: Float.right).inlineStyle, contains('float: right'));
    });

    test('flexWrap', () {
      expect(
        Style(flexWrap: FlexWrap.wrap).inlineStyle,
        contains('flex-wrap: wrap'),
      );
      expect(
        Style(flexWrap: FlexWrap.wrapReverse).inlineStyle,
        contains('flex-wrap: wrap-reverse'),
      );
    });

    test('alignSelf', () {
      expect(
        Style(alignSelf: AlignSelf.center).inlineStyle,
        contains('align-self: center'),
      );
      expect(
        Style(alignSelf: AlignSelf.start).inlineStyle,
        contains('align-self: flex-start'),
      );
      expect(
        Style(alignSelf: AlignSelf.stretch).inlineStyle,
        contains('align-self: stretch'),
      );
    });

    test('empty style produces empty string', () {
      expect(Style().inlineStyle, isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // Node construction
  // ---------------------------------------------------------------------------

  group('Node', () {
    test('null and empty attrs are filtered out', () {
      final node = Node(
        tag: 'div',
        attrs: {'id': 'foo', 'class': null, 'style': ''},
      );
      expect(node.attrs.containsKey('id'), isTrue);
      expect(node.attrs.containsKey('class'), isFalse);
      expect(node.attrs.containsKey('style'), isFalse);
    });

    test('boolAttrs defaults to empty list', () {
      final node = Node(tag: 'div');
      expect(node.boolAttrs, isEmpty);
    });
  });

  // ---------------------------------------------------------------------------
  // Form elements
  // ---------------------------------------------------------------------------

  group('Form elements', () {
    test('input renders as void element (no closing tag)', () {
      final html = renderHtml(input(type: 'text', placeholder: 'Name'));
      expect(html, contains('<input'));
      expect(html, isNot(contains('</input>')));
    });

    test('input boolean attrs render as standalone names', () {
      final html = renderHtml(input(required: true, disabled: true));
      expect(html, contains(' required'));
      expect(html, contains(' disabled'));
      expect(html, isNot(contains('required="')));
    });

    test('input checked only present when true', () {
      final unchecked = renderHtml(input(type: 'checkbox'));
      expect(unchecked, isNot(contains('checked')));

      final checked = renderHtml(input(type: 'checkbox', checked: true));
      expect(checked, contains(' checked'));
    });

    test('textarea renders with closing tag', () {
      final html = renderHtml(textarea(placeholder: 'Message', rows: 4));
      expect(html, contains('<textarea'));
      expect(html, contains('</textarea>'));
      expect(html, contains('rows="4"'));
    });

    test('select with options', () {
      final html = renderHtml(
        select(
          children: [
            option(value: 'a', content: 'Option A'),
            option(value: 'b', content: 'Option B', selected: true),
          ],
        ),
      );
      expect(html, contains('<select>'));
      expect(html, contains('</select>'));
      expect(html, contains('value="a"'));
      expect(html, contains('value="b"'));
      expect(html, contains(' selected'));
    });

    test('select multiple attr', () {
      final html = renderHtml(select(multiple: true));
      expect(html, contains(' multiple'));
    });

    test('fieldset and legend', () {
      final html = renderHtml(
        fieldset(
          children: [
            legend('Personal info'),
            input(name: 'name'),
          ],
        ),
      );
      expect(html, contains('<fieldset>'));
      expect(html, contains('<legend>Personal info</legend>'));
    });

    test('label with htmlFor', () {
      final html = renderHtml(label(htmlFor: 'email', content: 'Email'));
      expect(html, contains('for="email"'));
      expect(html, contains('Email'));
    });

    test('form with action and method', () {
      final html = renderHtml(form(action: '/submit', method: 'post'));
      expect(html, contains('action="/submit"'));
      expect(html, contains('method="post"'));
    });

    test('complete login form structure', () {
      final html = renderHtml(
        form(
          action: '/login',
          method: 'post',
          children: [
            label(htmlFor: 'username', content: 'Username'),
            input(
              type: 'text',
              id: 'username',
              name: 'username',
              required: true,
            ),
            label(htmlFor: 'password', content: 'Password'),
            input(
              type: 'password',
              id: 'password',
              name: 'password',
              required: true,
            ),
            button('Log in', type: 'submit'),
          ],
        ),
      );
      expect(html, contains('action="/login"'));
      expect(html, contains('type="password"'));
      expect(html, contains('type="submit"'));
      expect(html, contains('</form>'));
    });
  });

  // ---------------------------------------------------------------------------
  // Table elements
  // ---------------------------------------------------------------------------

  group('Table elements', () {
    test('basic table structure', () {
      final html = renderHtml(
        table(
          children: [
            thead(
              children: [
                tr(
                  children: [
                    th(content: 'Name'),
                    th(content: 'Age'),
                  ],
                ),
              ],
            ),
            tbody(
              children: [
                tr(
                  children: [
                    td(content: 'Alice'),
                    td(content: '30'),
                  ],
                ),
                tr(
                  children: [
                    td(content: 'Bob'),
                    td(content: '25'),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
      expect(html, contains('<table>'));
      expect(html, contains('<thead>'));
      expect(html, contains('<tbody>'));
      expect(html, contains('<th>Name</th>'));
      expect(html, contains('<td>Alice</td>'));
      expect(html, contains('</table>'));
    });

    test('caption', () {
      final html = renderHtml(table(children: [caption('User List')]));
      expect(html, contains('<caption>User List</caption>'));
    });

    test('tfoot', () {
      final html = renderHtml(
        table(
          children: [
            tfoot(
              children: [
                tr(children: [td(content: 'Total')]),
              ],
            ),
          ],
        ),
      );
      expect(html, contains('<tfoot>'));
      expect(html, contains('</tfoot>'));
    });

    test('th scope attribute', () {
      final col = renderHtml(th(content: 'Name', scope: Scope.col));
      expect(col, contains('scope="col"'));

      final row = renderHtml(th(content: 'Alice', scope: Scope.row));
      expect(row, contains('scope="row"'));
    });

    test('colspan and rowspan', () {
      final html = renderHtml(td(content: 'Merged', colspan: 2, rowspan: 3));
      expect(html, contains('colspan="2"'));
      expect(html, contains('rowspan="3"'));
    });

    test('col is a void element', () {
      final html = renderHtml(col(span: 2));
      expect(html, contains('<col'));
      expect(html, isNot(contains('</col>')));
      expect(html, contains('span="2"'));
    });

    test('colgroup with cols', () {
      final html = renderHtml(colgroup(children: [col(span: 1), col(span: 2)]));
      expect(html, contains('<colgroup>'));
      expect(html, contains('</colgroup>'));
    });

    test('td with children instead of content', () {
      final html = renderHtml(
        td(
          children: [a(href: '/user/1', content: 'Alice')],
        ),
      );
      expect(html, contains('<a href="/user/1">Alice</a>'));
    });
  });

  // ---------------------------------------------------------------------------
  // Security / escaping
  // ---------------------------------------------------------------------------

  group('HTML escaping', () {
    test('content escapes < > &', () {
      final html = renderHtml(p('<script>alert(1)</script>'));
      expect(html, contains('&lt;script&gt;'));
      expect(html, isNot(contains('<script>')));
    });

    test('content escapes ampersand', () {
      final html = renderHtml(p('foo & bar'));
      expect(html, contains('foo &amp; bar'));
    });

    test('attribute value escapes double-quote (prevents breakout)', () {
      // The " chars are escaped so the browser sees one attribute, not two.
      // onmouseover is present but as inert text inside the id value, not a handler.
      final html = renderHtml(div(id: 'x" onmouseover="evil()'));
      expect(html, contains('id="x&quot; onmouseover=&quot;evil()"'));
    });

    test('attribute value escapes ampersand', () {
      final html = renderHtml(a(href: '/search?a=1&b=2', content: 'Search'));
      expect(html, contains('href="/search?a=1&amp;b=2"'));
    });

    test('raw() bypasses escaping for trusted content', () {
      final html = renderHtml(raw('<strong>bold</strong>'));
      expect(html, contains('<strong>bold</strong>'));
    });
  });

  // ---------------------------------------------------------------------------
  // Void elements (general)
  // ---------------------------------------------------------------------------

  group('Void elements', () {
    test('hr has no closing tag', () {
      final html = renderHtml(hr());
      expect(html, contains('<hr>'));
      expect(html, isNot(contains('</hr>')));
    });

    test('img has no closing tag', () {
      final html = renderHtml(img(src: 'photo.png', alt: 'Photo'));
      expect(html, contains('<img'));
      expect(html, isNot(contains('</img>')));
    });

    test('br has no closing tag', () {
      final html = renderHtml(br());
      expect(html.trim(), equals('<br>'));
    });
  });

  // ---------------------------------------------------------------------------
  // Layout
  // ---------------------------------------------------------------------------

  group('vStack', () {
    test('renders a div with column flex styles', () {
      final html = renderHtml(vStack());
      expect(html, contains('<div'));
      expect(html, contains('flex-direction: column'));
      expect(html, contains('display: flex'));
    });

    test('default main axis alignment is flex-start', () {
      final html = renderHtml(vStack());
      expect(html, contains('justify-content: flex-start'));
    });

    test('mainAxisAlignment.center maps to center', () {
      final html = renderHtml(
        vStack(mainAxisAlignment: MainAxisAlignment.center),
      );
      expect(html, contains('justify-content: center'));
    });

    test('mainAxisAlignment.spaceBetween maps to space-between', () {
      final html = renderHtml(
        vStack(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      );
      expect(html, contains('justify-content: space-between'));
    });

    test('crossAxisAlignment.center maps to align-items: center', () {
      final html = renderHtml(
        vStack(crossAxisAlignment: CrossAxisAlignment.center),
      );
      expect(html, contains('align-items: center'));
    });

    test('id and classes are rendered as attributes', () {
      final html = renderHtml(vStack(id: 'main', classes: 'container'));
      expect(html, contains('id="main"'));
      expect(html, contains('class="container"'));
    });

    test('extra Style properties are merged in', () {
      final html = renderHtml(vStack(style: Style(gap: 16)));
      expect(html, contains('gap: 16.0px'));
      expect(html, contains('display: flex'));
    });

    test('renders children', () {
      final html = renderHtml(vStack(children: [p('Hello'), p('World')]));
      expect(html, contains('<p>Hello</p>'));
      expect(html, contains('<p>World</p>'));
    });
  });

  group('hStack', () {
    test('renders a div with row flex styles', () {
      final html = renderHtml(hStack());
      expect(html, contains('flex-direction: row'));
      expect(html, contains('display: flex'));
    });

    test('default cross axis alignment is center', () {
      final html = renderHtml(hStack());
      expect(html, contains('align-items: center'));
    });

    test('mainAxisAlignment.end maps to flex-end', () {
      final html = renderHtml(hStack(mainAxisAlignment: MainAxisAlignment.end));
      expect(html, contains('justify-content: flex-end'));
    });

    test('crossAxisAlignment.stretch maps to stretch', () {
      final html = renderHtml(
        hStack(crossAxisAlignment: CrossAxisAlignment.stretch),
      );
      expect(html, contains('align-items: stretch'));
    });

    test('extra Style properties are merged in', () {
      final html = renderHtml(hStack(style: Style(gap: 8)));
      expect(html, contains('gap: 8.0px'));
      expect(html, contains('flex-direction: row'));
    });
  });

  group('zStack', () {
    test('renders position: relative', () {
      final html = renderHtml(zStack());
      expect(html, contains('position: relative'));
    });

    test('extra Style properties are merged in', () {
      final html = renderHtml(zStack(style: Style(width: 200)));
      expect(html, contains('position: relative'));
      expect(html, contains('width: 200.0px'));
    });

    test('id and classes are rendered', () {
      final html = renderHtml(zStack(id: 'layer', classes: 'overlay'));
      expect(html, contains('id="layer"'));
      expect(html, contains('class="overlay"'));
    });
  });

  group('spacer', () {
    test('renders flex: 1', () {
      final html = renderHtml(spacer());
      expect(html, contains('flex: 1'));
    });

    test('is a div with no children', () {
      final html = renderHtml(spacer());
      expect(html, contains('<div'));
      expect(html, contains('</div>'));
    });
  });

  group('padding widget', () {
    test('all sets uniform padding', () {
      final html = renderHtml(padding(child: p('x'), all: 16));
      expect(html, contains('padding: 16.0px'));
    });

    test('horizontal sets left and right padding', () {
      final html = renderHtml(padding(child: p('x'), horizontal: 12));
      expect(html, contains('padding-left: 12.0px'));
      expect(html, contains('padding-right: 12.0px'));
    });

    test('vertical sets top and bottom padding', () {
      final html = renderHtml(padding(child: p('x'), vertical: 8));
      expect(html, contains('padding-top: 8.0px'));
      expect(html, contains('padding-bottom: 8.0px'));
    });

    test('individual sides', () {
      final html = renderHtml(
        padding(child: p('x'), top: 1, right: 2, bottom: 3, left: 4),
      );
      expect(html, contains('padding-top: 1.0px'));
      expect(html, contains('padding-right: 2.0px'));
      expect(html, contains('padding-bottom: 3.0px'));
      expect(html, contains('padding-left: 4.0px'));
    });

    test('wraps the child', () {
      final html = renderHtml(padding(child: p('inner'), all: 8));
      expect(html, contains('<p>inner</p>'));
    });
  });

  group('center', () {
    test('renders flex centering styles', () {
      final html = renderHtml(center(child: p('x')));
      expect(html, contains('display: flex'));
      expect(html, contains('justify-content: center'));
      expect(html, contains('align-items: center'));
    });

    test('wraps the child', () {
      final html = renderHtml(center(child: h1('Title')));
      expect(html, contains('<h1>Title</h1>'));
    });

    test('extra Style properties are merged in', () {
      final html = renderHtml(center(child: p('x'), style: Style(height: 100)));
      expect(html, contains('height: 100.0px'));
      expect(html, contains('justify-content: center'));
    });
  });

  // ---------------------------------------------------------------------------
  // Parser
  // ---------------------------------------------------------------------------

  group('Parser', () {
    test('boolean flag is true when present', () {
      final p = Parser()..register('--verbose', 'Enable verbose output');
      p.parse(['--verbose']);
      expect(p.getParsed()['--verbose'], isTrue);
    });

    test('unrecognised flag throws ArgParseException', () {
      final p = Parser()..register('--known', 'A known flag');
      expect(() => p.parse(['--unknown']), throwsA(isA<ArgParseException>()));
    });

    test('typed flag with space separator', () {
      final p = Parser()..register('output', 'Output dir', type: String);
      p.parse(['output', 'build']);
      expect(p.getParsed()['output'], equals('build'));
    });

    test('typed flag with = separator', () {
      final p = Parser()..register('output', 'Output dir', type: String);
      p.parse(['output=dist']);
      expect(p.getParsed()['output'], equals('dist'));
    });

    test('typed flag with : separator', () {
      final p = Parser()..register('output', 'Output dir', type: String);
      p.parse(['output:public']);
      expect(p.getParsed()['output'], equals('public'));
    });

    test('typed int flag is coerced', () {
      final p = Parser()..register('count', 'A count', type: int);
      p.parse(['count=42']);
      expect(p.getParsed()['count'], equals(42));
    });

    test('typed double flag is coerced', () {
      final p = Parser()..register('ratio', 'A ratio', type: double);
      p.parse(['ratio=3.14']);
      expect(p.getParsed()['ratio'], closeTo(3.14, 0.001));
    });

    test('typed bool flag is coerced', () {
      final p = Parser()..register('minify', 'Minify output', type: bool);
      p.parse(['minify=true']);
      expect(p.getParsed()['minify'], isTrue);
    });

    test('wrong type for typed flag throws ArgParseException', () {
      final p = Parser()..register('count', 'A count', type: int);
      expect(
        () => p.parse(['count=notanumber']),
        throwsA(isA<ArgParseException>()),
      );
    });

    test('typed flag with missing argument throws ArgParseException', () {
      final p = Parser()..register('output', 'Output dir', type: String);
      expect(() => p.parse(['output']), throwsA(isA<ArgParseException>()));
    });

    test('anyFlagsParsed is false before parsing', () {
      final p = Parser()..register('--verbose', 'Verbose');
      expect(p.anyFlagsParsed(), isFalse);
    });

    test('anyFlagsParsed is true after a flag is parsed', () {
      final p = Parser()..register('--verbose', 'Verbose');
      p.parse(['--verbose']);
      expect(p.anyFlagsParsed(), isTrue);
    });

    test('-- allows unknown flags after it', () {
      final p = Parser()..register('--known', 'A known flag');
      expect(() => p.parse(['--', '--anything']), returnsNormally);
    });

    test('multiple flags parsed together', () {
      final p = Parser()
        ..register('--verbose', 'Verbose')
        ..register('output', 'Output dir', type: String);
      p.parse(['--verbose', 'output=dist']);
      expect(p.getParsed()['--verbose'], isTrue);
      expect(p.getParsed()['output'], equals('dist'));
    });

    test('getParsed returns empty map when nothing is parsed', () {
      final p = Parser()..register('--verbose', 'Verbose');
      p.parse([]);
      expect(p.getParsed(), isEmpty);
    });
  });
}
