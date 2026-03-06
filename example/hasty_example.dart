import 'dart:io';

import 'package:hasty/hasty.dart';

// spacer() between title and links — no need for MainAxisAlignment.spaceBetween
Node navBar() => header(
  children: [
    hStack(
      children: [
        h1('Hasty', style: Style(color: Colors.indigo)),
        spacer(),
        nav(
          children: [
            hStack(
              style: Style(gap: 16),
              children: [
                a(href: '#about', content: 'About'),
                a(href: '#features', content: 'Features'),
                a(href: '#specs', content: 'Specs'),
                a(href: '#contact', content: 'Contact'),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

// padding() + center() for a hero callout
Node hero() => padding(
  all: 48,
  child: center(
    child: vStack(
      crossAxisAlignment: CrossAxisAlignment.center,
      style: Style(gap: 8),
      children: [
        h2(
          'Build HTML in pure Dart.',
          style: Style(color: Colors.darkGray, textAlign: TextAlign.center),
        ),
        p(
          'No templates. No raw strings. Just composable functions and type-safe styles.',
        ),
      ],
    ),
  ),
);

Node featureCard({required String title, required String body}) => div(
  classes: 'card',
  style: Style(
    border: '1px solid ${Colors.lightGray}',
    borderRadius: 8,
    padding: 16,
    backgroundColor: Colors.white,
  ),
  children: [h3(title), p(body)],
);

// ul/li for a feature list
Node aboutSection() => section(
  id: 'about',
  children: [
    h2('About'),
    p('Hasty is a SwiftUI-inspired static site generator for Dart.'),
    ul(
      children: [
        li('Compose pages with hStack, vStack, zStack, and spacer'),
        li('Type-safe styles via Style and Colors — no raw CSS strings'),
        li('Full form, table, and list support'),
        li('Built-in HTML escaping and prettified output'),
      ],
    ),
  ],
);

// table for a feature overview
Node specsTable() => section(
  id: 'specs',
  children: [
    h2('Specs'),
    table(
      style: Style(width: 500),
      children: [
        caption('Feature Overview'),
        thead(
          children: [
            tr(
              children: [
                th(content: 'Feature', scope: Scope.col),
                th(content: 'Supported', scope: Scope.col),
              ],
            ),
          ],
        ),
        tbody(
          children: [
            tr(
              children: [
                td(content: 'Layout primitives'),
                td(content: 'Yes'),
              ],
            ),
            tr(
              children: [
                td(content: 'Forms'),
                td(content: 'Yes'),
              ],
            ),
            tr(
              children: [
                td(content: 'Tables'),
                td(content: 'Yes'),
              ],
            ),
            tr(
              children: [
                td(content: 'HTML escaping'),
                td(content: 'Yes'),
              ],
            ),
            tr(
              children: [
                td(content: 'Prettified output'),
                td(content: 'Yes'),
              ],
            ),
            tr(
              children: [
                td(content: 'CLI arg parsing'),
                td(content: 'Yes'),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
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

void main(List<String> args) async {
  // 1. Parse CLI args
  final parser = Parser();
  parser.register('output', 'The output directory', type: String);
  try {
    parser.parse(args);
  } catch (e) {
    print(e);
    exit(1);
  }
  final outDir = parser.getParsed()['output'] ?? 'build';

  // 2. Build the page tree
  final page = vStack(
    id: 'app',
    style: Style(
      fontFamily: 'sans-serif',
      padding: 24,
      maxWidth: 800,
      margin: 0,
    ),
    children: [
      navBar(),
      hr(),
      hero(),
      aboutSection(),
      section(
        id: 'features',
        children: [
          h2('Features'),
          hStack(
            style: Style(gap: 16),
            children: [
              featureCard(
                title: 'Composable',
                body:
                    'Build pages like Flutter widgets using hStack, vStack, and zStack.',
              ),
              featureCard(
                title: 'Typed Styles',
                body: 'Use Style and Colors for type-safe inline CSS.',
              ),
              featureCard(
                title: 'Complete HTML',
                body:
                    'Forms, tables, lists, media — all covered out of the box.',
              ),
            ],
          ),
        ],
      ),
      specsTable(),
      section(id: 'contact', children: [h2('Contact'), contactForm()]),
      footer(
        style: Style(marginTop: 48, color: Colors.gray),
        children: [p('Built with Hasty.')],
      ),
    ],
  );

  // 3. Emit
  await emit(page, outputDir: outDir, title: 'Hasty Example');
}
