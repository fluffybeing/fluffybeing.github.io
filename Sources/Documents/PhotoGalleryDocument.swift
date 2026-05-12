import SwiftHtml

func photoGalleryDocument(photos: PhotoCollection) -> Document {
	Document(.html) {
		Div {
			for photo in photos.images {
				Div {
					Img(src: photo.thumbSrc, alt: photo.title)
						.class("plain photo-gallery-img")
						.attribute("loading", "lazy")
						.attribute("decoding", "async")
						.attribute("onclick", "openLightbox('\(photo.imageSrc)')")
				}
				.class("photo-gallery-item")
			}
		}
		.class("photo-gallery")

		// Lightbox overlay
		Div {
			Div {
				Span("×")
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
