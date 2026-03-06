## 0.0.2

### Layout
- Added `hStack` and `vStack` — horizontal/vertical flexbox containers with `MainAxisAlignment` and `CrossAxisAlignment` support
- Added `zStack` — layered positioning container (`position: relative`)
- Added `spacer` — flex-growing spacer element
- Added `padding` — wraps a single child with configurable padding (all, horizontal, vertical, or per-side)
- Added `center` — centers a child both horizontally and vertically

### Tags
- **Headings**: `h1`, `h2`, `h3`, `h4`, `h5`, `h6`
- **Text**: `text` (with `TextKind` enum), `p`, `span`, `strong`, `em`
- **Containers**: `div`, `section`, `main_`, `header`, `footer`, `nav`, `article`
- **Lists**: `ul`, `ol`, `li`
- **Interactive**: `a`, `button`
- **Media**: `img`, `hr`, `br`
- **Forms**: `form`, `input`, `textarea`, `select`, `option`, `optgroup`, `fieldset`, `legend`, `label`
- **Tables**: `table`, `caption`, `thead`, `tbody`, `tfoot`, `tr`, `th` (with `Scope` enum), `td`, `colgroup`, `col`
- **Escape hatch**: `raw` — injects HTML strings without escaping (unsafe; use only with controlled content)

### Styles
- Added `Style` class with typed properties for color, background, padding, margin, font, dimensions, borders, flexbox, positioning, and more
- Added `Color` with `Color.hex`, `Color.rgb`, `Color.rgba` constructors
- Added `Colors` palette (`black`, `white`, `red`, `orange`, `yellow`, `green`, `teal`, `blue`, `indigo`, `purple`, `pink`, `gray`, `lightGray`, `darkGray`, `transparent`)
- Added `FontWeight` constants (`thin`, `light`, `normal`, `medium`, `semibold`, `bold`, `extrabold`)
- Added enums: `TextAlign`, `TextDecoration`, `Position`, `Display`, `Float`, `FlexWrap`, `AlignSelf`

### Generator
- Added `emit` — writes `index.html` to a configurable output directory; accepts `title`, `fileName`, `outputDir`, and `lang` parameters
- `emit` produces a complete HTML document: `<!DOCTYPE html>`, `<html lang="...">`, `<meta charset="utf-8">`, and `<meta name="viewport">` are always included
- `emit` prettifies output with indented formatting before writing — the resulting file is human-readable and well-indented
- `emit` uses `mason_logger` for a progress spinner during the build, with a green ✓ on success or red ✗ on failure
- Added `renderHtml` — returns the raw HTML string for a node tree without writing any files

### CLI / Argparse
- Added `Parser` — registers and parses typed CLI flags (supports `=` and `:` separators, typed arguments, and unknown-flag rejection)
- Added `ArgParseException` for structured parse errors

### Tests
- Added full test coverage for all layout functions (`hStack`, `vStack`, `zStack`, `spacer`, `padding`, `center`)
- Added full test coverage for `Parser` (flag parsing, type coercion, all three separators, error cases, `--` passthrough)

### Bug Fixes
- Fixed malformed HTML output caused by `beautiful_soup_dart`'s `prettify()` re-parsing the generated HTML and scrambling tag nesting order
- Replaced the post-processing step with indentation built directly into the generation loop — output is now correctly structured and well-indented

### Removed
- Removed `beautiful_soup_dart` dependency; prettification is now handled natively
- Removed unused `Node.css` field and the dead `cssSet` collection/write infrastructure that depended on it

### Examples
- `example/hasty_example.dart` — updated to showcase `spacer`, `padding`, `center`, `ul`/`li`, and tables alongside forms, layout, and CLI parsing
- `bin/hasty.dart` — updated navbar to use `spacer`; added `intro()` section demonstrating `padding`, `center`, and inline text styling with `span` and `FontWeight`

## 0.0.1

- Initial namespace reservation.
