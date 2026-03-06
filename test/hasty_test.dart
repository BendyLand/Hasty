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
      expect(html, equals('<br>'));
    });
  });
}
