import SwiftHtml

public struct ListLayout: TagRepresentable {
	var title: String
	var description: String?
	var canonicalHref: String

	func build() -> Tag {
		Html {
			SiteHead(title: title, description: description, canonicalHref: canonicalHref)

			Body {
				VStack(alignment: .stretch, spacing: .s48) {
					SiteHeader(title: title, subtitle: description, backLink: .home)

					SwiftHtml.Main {
						VStack(alignment: .stretch, spacing: .s48) {
							Content()
						}
					}

					SiteFooter()
				}
			}
		}
		.lang("en")
	}
}
