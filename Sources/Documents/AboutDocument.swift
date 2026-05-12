import SwiftHtml

let aboutDocument = Document(.html) {
	Section(title: "Who") {
		Div {
			P("I'm Rahul, a curious guy who loves to challenge himself in every possible way. I'm driven by honesty, good energy, and being someone people feel safe around.")
			P("I have a diverse range of interests that keep me busy—running, cycling, skiing, motorcycling, writing, reading, photography, and badminton.")
			P("I'm an extroverted introvert; I love meeting new people and exploring new places, but I recharge my energy at home.")
			P("I like sharing ideas, opinions, and learnings, continuously refining them along the way.")
		}
		.class("prose")
	}

	Hr()

	Section(title: "What") {
		Div {
			P("I spend most of my time building mobile apps—crafting polished, well-architected iOS experiences with Swift and UIKit/SwiftUI.")
			P {
				Text("I work as a Senior Software Engineer at ")
				A("Teledyne FLIR")
					.href("https://www.teledyneinstruments.com")
				Text(" in Stockholm, where I build camera and imaging software for iOS.")
			}
			P {
				Text("You can read more about what I'm up to right now on ")
				A("my now page")
					.href("/now/")
					.class("plain")
				Text(".")
			}
			.class("callout")
		}
		.class("prose")
	}

	Hr()

	Section(title: "Why") {
		Div {
			P("I've always had a deep curiosity for learning and creating. As long as I can remember, I've found joy in building things—whether it was sketching, tinkering with electronics, or writing code.")
			P("Ever since I wrote my first lines of code, most of my creative output has been in the form of software—apps, tools, and experiments that solve real problems.")
			P("I've lived and worked across India, Singapore, California, and now Sweden. Each place has shaped how I think about craft, culture, and collaboration.")
			P {
				Text("On ")
				A("my someday page")
					.href("/someday/")
					.class("plain")
				Text(", you can learn more about my ")
				A("long-term life goals")
					.href("/someday/")
					.class("plain")
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

		P {
			Text("I plan to one day ")
			A("quit social media")
				.href("/quitting-social-media/")
				.class("plain")
			Text(", but until then you can find me there.")
		}
		.class("callout")
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
