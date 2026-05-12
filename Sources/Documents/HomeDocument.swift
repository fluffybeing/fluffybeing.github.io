import SwiftHtml

let homeDocument = Document(.html) {
	Html {
		SiteHead(description: Site.bio.strippedOfHtmlTags, canonicalHref: Site.url + "/")

		Body {
			VStack(alignment: .stretch, spacing: .s48) {
				SiteHeader(supertitle: "Ideas, loosely held", title: "Rahul Ranjan")

				SwiftHtml.Main {
					VStack(alignment: .stretch, spacing: .s48) {
						BioSection()

						Hr()

						NotesSection()

						Hr()

						PhotosSection()

						Hr()

						ArticlesSection()
					}
				}

				SiteFooter(variant: .home)
			}
		}
	}
	.lang("en")
}

private struct BioSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Bio", hiddenTitle: true) {
			VStack(alignment: .stretch, spacing: .s48) {
				P(Site.bio)

				VStack(alignment: .leading, spacing: .s32, horizontalFrom: .sm) {
					VStack(alignment: .leading, spacing: .s8) {
						A("About")
							.class("title3 serif")
							.href("/about/")

						P("Who, What, Why")
							.class("secondary")
					}

					VStack(alignment: .leading, spacing: .s8) {
						A("Now")
							.class("title3 serif")
							.href("/now/")

						P("Short-term focus")
							.class("secondary")
					}

					VStack(alignment: .leading, spacing: .s8) {
						A("Someday")
							.class("title3 serif")
							.href("/someday/")

						P("Long-term goals")
							.class("secondary")
					}
				}
			}
		}
	}
}

private struct IndieAppsSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Projects", moreLink: .apps("Details")) {
			Grid(columns: .c2, spacing: .s32) {
				for resource in indieApps {
					LinkedResourceItem(resource: resource)
				}
			}
		}
	}
}

private struct NotesSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Notes", moreLink: .notes("Archive")) {
			VStack(alignment: .leading, spacing: .s48) {
				for note in notes.sorted(by: >).prefix(3) {
					NoteItem(note: note)
				}
			}
		}
	}
}

private struct OtherProjectsSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Other projects") {
			Grid(columns: .c2, spacing: .s32) {
				for resource in otherProjects {
					LinkedResourceItem(resource: resource)
				}
			}
		}
	}
}

private struct PhotosSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Photos", moreLink: .photos("Archive")) {
			VStack(alignment: .stretch, spacing: .s32) {
				for album in photoCollections {
					Div {
						A(album.title)
							.href("/photos/\(album.slug)/")
							.class("plain album-title")

						Div {
							for photo in album.images.prefix(5) {
								Div {
									Img(src: photo.thumbSrc, alt: photo.title)
										.class("plain")
										.attribute("onclick", "openLightbox('\(photo.imageSrc)')")
								}
								.class("photo-inline-item")
							}
						}
						.class("photo-inline")
					}
					.class("album-row")
				}
			}

			// Lightbox overlay
			Div {
				Div {
					Span("\u{00d7}")
						.class("lightbox-close")
						.attribute("onclick", "closeLightbox()")
					Img(src: "", alt: "")
						.id("lightbox-img")
						.class("plain")
				}
				.class("lightbox-content")
			}
			.id("lightbox")
			.class("lightbox")
			.attribute("onclick", "closeLightbox()")

			Script("""
			function openLightbox(src) {
				document.getElementById('lightbox-img').src = src;
				document.getElementById('lightbox').style.display = 'flex';
				document.body.style.overflow = 'hidden';
			}
			function closeLightbox() {
				document.getElementById('lightbox').style.display = 'none';
				document.body.style.overflow = '';
			}
			document.addEventListener('keydown', function(e) {
				if (e.key === 'Escape') closeLightbox();
			});
			""")
		}
	}
}

private struct ArticlesSection: TagRepresentable {
	func build() -> Tag {
		Section(title: "Articles", moreLink: .articles("Archive")) {
			VStack(alignment: .leading, spacing: .s32) {
				for page in articles.sorted(by: >).prefix(5) {
					ArticleItem(page: page)
				}
			}
		}
	}
}

let otherProjects: [LinkedResource] = []

