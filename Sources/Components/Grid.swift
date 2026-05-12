import SwiftHtml

struct Grid: TagRepresentable {
	enum Columns: String {
		case c2

		var `class`: String {
			rawValue
		}
	}

	var columns: Columns
	var spacing: Spacing
	@TagBuilder var content: () -> Tag

	func build() -> Tag {
		Div {
			content()
		}
		.class("grid", columns.class, spacing.class)
	}
}
