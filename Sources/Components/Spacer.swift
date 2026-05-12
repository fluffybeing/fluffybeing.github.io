import SwiftHtml

struct Spacer: TagRepresentable {
	func build() -> Tag {
		Div()
			.class("spacer")
	}
}
