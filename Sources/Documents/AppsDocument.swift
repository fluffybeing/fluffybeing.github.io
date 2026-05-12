import SwiftHtml

let appsDocument = Document(.html) {
Section(title: "Projects") {
Div {
P("Projects coming soon. Stay tuned!")
}
.class("prose")
}
}
