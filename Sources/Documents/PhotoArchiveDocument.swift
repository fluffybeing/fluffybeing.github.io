import SwiftHtml

func photoArchiveDocument(albums: [PhotoCollection]) -> Document {
	Document(.html) {
		VStack(alignment: .stretch, spacing: .s48) {
			for album in albums {
				Div {
					A(album.title)
						.href("/photos/\(album.slug)/")
						.class("plain album-title")

					Div {
						for photo in album.images.prefix(5) {
							Div {
								Img(src: photo.thumbSrc, alt: photo.title)
									.class("plain")
									.attribute("loading", "lazy")
									.attribute("decoding", "async")
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
