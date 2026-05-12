import Foundation
import SwiftHtml

struct SiteHead: TagRepresentable {
	var title: String?
	var description: String?
	var canonicalHref: String
	var publishedAt: Date? = nil
	var updatedAt: Date? = nil

	func build() -> Tag {
		Head {
			Meta().charset("utf-8")
			Meta().name(.viewport).content("width=device-width, initial-scale=1, viewport-fit=cover")

			if let title {
				Title("\(title) · \(Site.author)")
			} else {
				Title(Site.author)
			}

			Meta().name(.author).content(Site.author)

			SwiftHtml.Link(rel: .canonical).href(canonicalHref)
			Meta().property("og:url").content(canonicalHref)

			if let description {
				Meta().name(.description).content(description)
				Meta().property("og:description").content(description)
			}

			Meta().property("og:title").content(title ?? Site.author)
			Meta().property("og:author").content(Site.author)
			Meta().property("og:image").content("\(Site.cdn)/og.jpg")

			if publishedAt != nil || updatedAt != nil {
				Meta().property("og:type").content("article")

				if let publishedAt {
					Meta().property("article:published_time").content(publishedAt.dayMonthYear)
				}

				if let updatedAt {
					Meta().property("article:modified_time").content(updatedAt.dayMonthYear)
				}
			}

			SwiftHtml.Link(rel: .icon)
				.href("/favicon.ico")
			SwiftHtml.Link(rel: .appleTouchIcon)
				.href("/apple-touch-icon.png")

			let cssHref = "/\(Site.cssFileName)?v=\(assetsHashes[Site.cssFileName] ?? "0")"

			SwiftHtml.Link(rel: .preload)
				.href(cssHref)
				.attribute("as", "style")

			SwiftHtml.Link(rel: .stylesheet)
				.href(cssHref)

			SwiftHtml.Link(rel: .alternate)
				.type("application/rss+xml")
				.title(Site.author)
				.href("/feed.rss")

			Script()
				.defer()
				.data(key: "domain", "fluffybeing.github.io")
				.src("https://plausible.io/js/plausible.js")

			SwiftHtml.Link(rel: .stylesheet)
				.href("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css")
			Script()
				.src("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js")
			Script("hljs.highlightAll();")
		}
	}
}
