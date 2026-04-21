import 'dart:io';

import 'package:hasty/hasty.dart';

// navBar() / navLink()
Node siteNav() => header(
  children: [
    hStack(
      children: [
        h1('Hasty', style: Style(color: Colors.indigo)),
        spacer(),
        navBar(
          links: [
            navLink(label: 'About', href: '#about'),
            navLink(label: 'Features', href: '#features'),
            navLink(label: 'Components', href: '#components'),
            navLink(label: 'Specs', href: '#specs'),
            navLink(label: 'Contact', href: '#contact'),
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

Node featureCard({required String title, required String body}) => card(
  backgroundColor: Colors.white,
  style: Style(border: '1px solid ${Colors.lightGray}'),
  children: [h3(title), p(body)],
);

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

// button variants
Node buttonShowcase() => section(
  id: 'buttons',
  children: [
    h3('Buttons'),
    hStack(
      style: Style(gap: 12),
      children: [
        button('Primary', variant: ButtonVariant.primary),
        button('Secondary', variant: ButtonVariant.secondary),
        button(
          'Floating',
          variant: ButtonVariant.floating,
          data: {'action': 'open-modal'},
        ),
        button(
          'Custom',
          style: Style(
            backgroundColor: Colors.purple,
            color: Colors.white,
            padding: 10,
            borderRadius: 6,
          ),
          data: {'action': 'custom-action'},
        ),
      ],
    ),
  ],
);

Node badgeShowcase() => section(
  id: 'badges',
  children: [
    h3('Badges'),
    hStack(
      style: Style(gap: 8),
      children: [
        badge('Active', color: Colors.green),
        badge('Pending', color: Colors.yellow),
        badge('Error', color: Colors.red),
        badge('Info', color: Colors.blue),
        badge('Draft', color: Colors.gray),
      ],
    ),
  ],
);

Node statCardShowcase() => section(
  id: 'stat-cards',
  children: [
    h3('Stat Cards'),
    hStack(
      style: Style(gap: 16),
      children: [
        statCard(
          icon: '🚀',
          value: '128',
          label: 'Deployments',
          color: Colors.indigo,
        ),
        statCard(
          icon: '✅',
          value: '99.9%',
          label: 'Uptime',
          color: Colors.green,
        ),
        statCard(
          icon: '⚡',
          value: '42ms',
          label: 'Avg. Response',
          color: Colors.teal,
        ),
      ],
    ),
  ],
);

Node inputShowcase() => section(
  id: 'inputs',
  children: [
    h3('Inputs'),
    vStack(
      style: Style(gap: 12),
      children: [
        vStack(
          style: Style(gap: 4),
          children: [
            label(htmlFor: 'search', content: 'Search'),
            input(
              id: 'search',
              name: 'search',
              placeholder: 'Search...',
              data: {'controller': 'search', 'action': 'input->search#query'},
            ),
          ],
        ),
        vStack(
          style: Style(gap: 4),
          children: [
            label(htmlFor: 'notes', content: 'Notes'),
            textarea(
              id: 'notes',
              name: 'notes',
              placeholder: 'Add a note...',
              rows: 3,
              data: {'controller': 'autogrow'},
            ),
          ],
        ),
      ],
    ),
  ],
);

Node componentsSection() => section(
  id: 'components',
  children: [
    h2('New Components'),
    buttonShowcase(),
    badgeShowcase(),
    statCardShowcase(),
    inputShowcase(),
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
  final parser = Parser();
  parser.register('output', 'The output directory', type: String);
  parser.register('--output', 'The output directory', type: String);
  try {
    parser.parse(args);
  } catch (e) {
    print(e);
    exit(1);
  }
  final outDir = parser.getParsed()['output'] ?? 'build';
  final page = vStack(
    id: 'app',
    style: Style(
      fontFamily: 'sans-serif',
      padding: 24,
      maxWidth: 800,
      margin: 0,
    ),
    children: [
      siteNav(),
      hero(),
      aboutSection(),
      componentsSection(),
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
  await emit(page, outputDir: outDir, title: 'Hasty Example');
}
