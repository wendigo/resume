#import "@preview/based:0.1.0": base64
#import "@preview/backtrack:1.0.0": current-version

#let content = yaml("en.yml")

#set document(
    title: (content.name + " resume"),
    author: content.name,
    keywords: content.keywords
)

#set page(footer: [
  #set align(center)
  #text(size: 8pt, fill: gray)[
  #counter(page).display(
    "1/1",
    both: true,
  )]
])

#set par(justify: true)
#set text(font: content.font, size: 10pt)
#show heading: set text(font: content.font, size: 14pt, weight: "regular")
#show link: underline

#[
    #set align(center)
    = #content.name
    = #text(size: 10pt, weight: "regular")[
        #v(-1em)
        #content.summary
    ]
]

= #content.sections.contact #v(0.8em)
#grid(
    columns: (15%, 35%, 15%, 35%),
    rows: (1.5em, 1.5em, 1.5em),
    row-gutter: 0.1em,
    [E-mail:], [#str(base64.decode(content.contact.email))],
    [Github:], [#link(content.contact.github.link)[#content.contact.github.title]],
    [Phone:], [#str(base64.decode(content.contact.mobile))],
    [LinkedIn:], [#link(content.contact.linkedin.link)[#content.contact.linkedin.title]],
    [Location:], [#content.contact.location],
    [],[]
)

#content.intro

== #content.sections.skills #v(0.8em)

#box(height: 5em,
    columns(3, gutter: 10pt)[
        #for skill in content.skills [
            - #skill
        ]
    ]
)
== #content.sections.experience #v(0.8em)

#let render_keyword(keyword) = {
  link(keyword.link)[#keyword.name]
}

#for experience in content.experience [
    #grid(
        columns: (12%, auto),
        column-gutter: 1em,
        [
            #experience.years
        ],
        [
            *#experience.position*

            _ #experience.job _ / #experience.city

            _ Keywords _: #experience.summary.keywords.map(render_keyword).join(", ")

            #eval(experience.summary.details, mode: "markup")
        ],
    )
]

== #content.sections.education #v(0.8em)

#for education in content.education [
    #grid(
        columns: (15%, auto),
        column-gutter: 1em,
        [
            #education.years
        ],
        [
            *#education.subject*

            _ #education.institute _ / #education.city
        ],
    )
]

== #content.sections.projects #v(1em)

#for project in content.projects [
    - *#project.name*

      #project.language / #link(project.repo)[#project.repo]

      #project.summary

]

== #content.sections.languages #v(1em)

#for language in content.languages [
    - #language.language (#language.proficiency)
]

== #content.sections.interests #v(1em)

#for interest in content.interests [
    - #eval(interest, mode: "markup")
]

#[
    #set align(center)
    #set text(fill: silver, size: 8pt)
    #v(3em)
    This resume was carefully crafted using typesetting system #link("https://github.com/typst/typst")[typst] #current-version.displayable. Current #link("https://github.com/wendigo/resume/blob/master/resume-en.pdf")[version] and sources at #link("https://github.com/wendigo/resume")[github].
]

#v(1em)
#text(8pt, fill: silver)[#content.gdpr]
