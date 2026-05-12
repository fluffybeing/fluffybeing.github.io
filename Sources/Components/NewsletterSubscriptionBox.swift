import SwiftHtml

struct NewsletterSubscriptionBox: TagRepresentable {
	func build() -> Tag {
		Aside {
			VStack(alignment: .center, spacing: .s24) {
				VStack(alignment: .center, spacing: .s16) {
					H2("Stay in the loop")
						.class("title2 serif medium")

					P(
						"A slow newsletter from me to you: essays, short notes, and things I'm learning. Sent only when I have something worth sharing."
					)
					.class("footnote secondary")
				}

				Form {
					HStack {
						Input()
							.type(.email)
							.name("email")
							.placeholder("your@email.com")
							.required()

						Button("Subscribe")
							.id("submit-button")
							.type(.submit)
					}
				}
				.id("subscription-form")
				.method(.post)

				Script()
					.src("/newsletter-subscription.js")
					.defer()

				P(
					"Great! Please click the link in the email sent to your inbox to confirm your subscription."
				)
				.id("success-message")
				.class("footnote secondary prose")
				.style("display: none;")

				P {
					Span("Something went wrong. Please ")

					A("contact me")
						.href("mailto:hi@rrahul.cc?subject=Subscription error")

					Span(" if the issue persists.")
				}
				.id("error-message")
				.class("footnote secondary")
				.style("display: none;")
			}
		}
		.class("subscription-box")
	}
}
