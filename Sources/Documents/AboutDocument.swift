import SwiftHtml

let aboutDocument = Document(.html) {
	Section(title: "Who") {
		Div {
			P(
				"👋 I'm Rahul: a curious guy, happiest when I'm learning something that's a little beyond me. What I care about most is being honest, bringing good energy into a room, and being someone people feel safe around."
			)
			P(
				"My interests pull in many directions: running, cycling, skiing, motorcycling, badminton, writing, reading, and photography. Most of them are slow crafts that reward showing up more than showing off."
			)
			P(
				"I'm an extroverted introvert. I light up around interesting people and new places, then quietly refill my battery at home with a book, a long walk, or an unhurried evening."
			)
			P(
				"I enjoy thinking in public—sharing ideas, opinions, and half-formed lessons, and refining them as I go. This site is where most of that happens."
			)
		}
		.class("prose")
	}

	Hr()

	Section(title: "What") {
		Div {
			P(
				"I spend most of my days building software mainly iOS apps, written in Swift with SwiftUI and UIKit. I care about the small things: a clean architecture, a considered interaction, a screen that feels calm to use."
			)
			P {
				Text("Currenlty I work as Team lead at ")
				A("Teledyne FLIR")
					.href("https://www.flir.com/en-eu/")
				Text(" in Stockholm, building camera and imaging software for iOS.")
			}
			P(
				"Outside of that, I'm slowly building a small portfolio of indie apps through my own company, writing here, and taking pictures when the light is good."
			)
			P {
				Text("You can read more about what I'm up to right now on ")
				A("my now page")
					.href("/now/")
				Text(".")
			}
			.class("callout")
		}
		.class("prose")
	}

	Hr()

	Section(title: "Why") {
		Div {
			P(
				"For as long as I can remember, I've found a particular kind of joy in making things sketching, taking gadgets apart, writing little programs to see what they'd do. The medium kept changing; the impulse never did."
			)
			P(
				"Software stuck because it sits at the intersection of everything I love: design, logic, language, and the quiet satisfaction of watching an idea become something other people can actually use."
			)
			P(
				"I've lived and worked across India, Singapore, California, and now Sweden. Each place has nudged how I think about craft, culture, and the kind of life worth building and made me a little less attached to any single way of doing things."
			)
			P {
				Text("On ")
				A("my someday page")
				Text(", you can read more about the ")
				A("long-term life I'm hoping to grow into")
					.href("/someday/")
				Text(".")
			}
			.class("callout")
		}
		.class("prose")
	}

	Hr()

	Section(title: "Work") {
		VStack(alignment: .stretch, spacing: .s24) {
			for resource in work {
				LinkedResourceItem(resource: resource, horizontal: true)
			}
		}
	}

	Hr()

	Section(title: "Connect") {
		VStack(alignment: .stretch, spacing: .s24) {
			for resource in connect {
				LinkedResourceItem(resource: resource, horizontal: true)
			}
		}

		Div {
			P {
				Text("I plan to one day ")
				A("quit social media")
					.href("/quitting-social-media/")
				Text(", but until then you can find me there.")
			}
			.class("callout")
		}
		.class("prose")
	}
}

let work: [LinkedResource] = [
	LinkedResource(
		title: "Teledyne FLIR",
		href: "https://www.teledyneinstruments.com",
		description: "Team Lead \u{22c5} 2023\u{2013}Now"
	),
	LinkedResource(
		title: "Spotify",
		href: "https://www.spotify.com",
		description: "Senior Software Engineer \u{22c5} 2020\u{2013}2023"
	),
	LinkedResource(
		title: "Grab",
		href: "https://www.grab.com",
		description: "Senior Software Engineer (iOS) \u{22c5} 2017\u{2013}2020"
	),
	LinkedResource(
		title: "Udacity",
		href: "https://www.udacity.com",
		description: "Course Manager \u{22c5} 2015\u{2013}2017"
	),
	LinkedResource(
		title: "The Walt Disney Company",
		href: "https://www.thewaltdisneycompany.com",
		description: "Software Engineer \u{22c5} 2014\u{2013}2015"
	),
]

let connect = [
	LinkedResource(
		title: "Email",
		href: "mailto:hi@rrahul.cc",
		description: "hi@rrahul.cc",
		highlightedText: "Preferred!"
	),
	LinkedResource(
		title: "GitHub",
		href: "https://github.com/fluffybeing",
		description: "@fluffybeing"
	),
	LinkedResource(
		title: "Twitter",
		href: "https://twitter.com/fluffybeing",
		description: "@fluffybeing"
	),
	LinkedResource(
		title: "LinkedIn",
		href: "https://www.linkedin.com/in/fluffybeing",
		description: "@fluffybeing"
	),
	LinkedResource(
		title: "YouTube",
		href: "https://www.youtube.com/@RR63stream",
		description: "@RR63stream"
	),
]
