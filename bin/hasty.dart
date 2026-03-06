import 'package:hasty/hasty.dart';

Node navBar() => header(
  children: [
    hStack(
      children: [
        h1('My Blog', style: Style(color: Colors.teal)),
        spacer(),
        nav(
          children: [
            hStack(
              style: Style(gap: 16),
              children: [
                a(href: '#posts', content: 'Posts'),
                a(href: '#contact', content: 'Contact'),
                a(href: '#team', content: 'Team'),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

Node postCard({required String title, required String body}) => div(
  classes: 'card',
  style: Style(
    backgroundColor: Colors.white,
    padding: 16,
    borderRadius: 8,
    border: '1px solid ${Colors.lightGray}',
  ),
  children: [h3(title), p(body)],
);

Node contactForm() => form(
  action: '/contact',
  method: 'post',
  children: [
    vStack(
      style: Style(gap: 12),
      children: [
        vStack(
          style: Style(gap: 4),
          children: [
            label(htmlFor: 'name', content: 'Name'),
            input(
              type: 'text',
              id: 'name',
              name: 'name',
              placeholder: 'Your name',
              required: true,
            ),
          ],
        ),
        vStack(
          style: Style(gap: 4),
          children: [
            label(htmlFor: 'email', content: 'Email'),
            input(
              type: 'email',
              id: 'email',
              name: 'email',
              placeholder: 'you@example.com',
              required: true,
            ),
          ],
        ),
        vStack(
          style: Style(gap: 4),
          children: [
            label(htmlFor: 'message', content: 'Message'),
            textarea(
              id: 'message',
              name: 'message',
              placeholder: 'Say hello...',
              rows: 5,
              required: true,
            ),
          ],
        ),
        button('Send', type: 'submit'),
      ],
    ),
  ],
);

Node teamTable() => table(
  style: Style(width: 600, borderWidth: 1, borderColor: Colors.lightGray),
  children: [
    caption('Meet the team'),
    thead(
      children: [
        tr(
          children: [
            th(content: 'Name', scope: Scope.col),
            th(content: 'Role', scope: Scope.col),
            th(content: 'Location', scope: Scope.col),
          ],
        ),
      ],
    ),
    tbody(
      children: [
        tr(
          children: [
            td(content: 'Alice'),
            td(content: 'Engineer'),
            td(content: 'Remote'),
          ],
        ),
        tr(
          children: [
            td(content: 'Bob'),
            td(content: 'Designer'),
            td(content: 'New York'),
          ],
        ),
        tr(
          children: [
            td(content: 'Carol'),
            td(content: 'Product'),
            td(content: 'London'),
          ],
        ),
      ],
    ),
  ],
);

Node intro() => padding(
  all: 40,
  child: center(
    child: vStack(
      crossAxisAlignment: CrossAxisAlignment.center,
      style: Style(gap: 8),
      children: [
        h2(
          'Welcome to My Blog',
          style: Style(color: Colors.darkGray, textAlign: TextAlign.center),
        ),
        p('Thoughts on Dart, Flutter, and building things on the web.'),
        hStack(
          style: Style(gap: 12),
          children: [
            span('Dart', style: Style(color: Colors.teal, fontWeight: FontWeight.semibold)),
            span('·'),
            span('Flutter', style: Style(color: Colors.indigo, fontWeight: FontWeight.semibold)),
            span('·'),
            span('Web', style: Style(color: Colors.blue, fontWeight: FontWeight.semibold)),
          ],
        ),
      ],
    ),
  ),
);

void main() async {
  final page = vStack(
    style: Style(
      padding: 24,
      margin: 0,
      fontFamily: 'sans-serif',
      maxWidth: 800,
    ),
    id: 'app',
    children: [
      navBar(),
      hr(),
      intro(),
      section(
        id: 'posts',
        children: [
          h2('Recent Posts'),
          hStack(
            style: Style(gap: 16),
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              postCard(
                title: 'Hello, Hasty!',
                body:
                    'Getting started with a SwiftUI-inspired static site generator in Dart.',
              ),
              postCard(
                title: 'Composing Layouts',
                body:
                    'Use hStack, vStack, and spacer to build clean, flexible page structures.',
              ),
            ],
          ),
        ],
      ),
      section(id: 'contact', children: [h2('Contact'), contactForm()]),
      section(id: 'team', children: [h2('Team'), teamTable()]),
      footer(
        style: Style(color: Colors.gray, marginTop: 48),
        children: [p('Built with Hasty.')],
      ),
    ],
  );
  await emit(page, title: 'My Blog');
}
