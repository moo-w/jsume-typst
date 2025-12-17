#import "./share.typ": *
#import "./layouts.typ": *
#import "../locales.typ": *
#import "../utils.typ": *

#let contact_item(value, link-type: "", prefix: "") = {
  if value != "" {
    if link-type != "" {
      underline(offset: 0.3em)[#link(link-type + value)[#(prefix + value)]]
    } else {
      value
    }
  }
}


#let header-section(
  title: "",
  label: "",
  position: center,
  base-font-size: 11pt,
  lang: "en",
) = {
  align(position)[
    #upper(text(base-font-size + 16pt, weight: "extrabold")[#title])
    #v(-1em)
  ]
  align(position)[
    #upper(text(base-font-size + 6pt, weight: "bold")[#label])
    #v(-0.5em)
  ]
}

#let personal-info-section(
  phone: "",
  email: "",
  url: "",
  location: "",
  position: center,
) = {
  align(position)[
    #{
      let gap = 0.2em
      let items = (
        contact_item(location),
        contact_item(phone, link-type: "tel:"),
        contact_item(email, link-type: "mailto:"),
        contact_item(url, link-type: "https://"),
      )

      items
        .filter(x => x != none)
        .join([
          #show "|": sep => {
            h(gap)
            [|]
            h(gap)
          }
          |
        ])
    }
  ]
}

#let work-section(
  data: (),
  lang: "en",
) = {
  let single-work-item(
    company: "",
    website: "",
    location: "",
    position: "",
    start-date: "",
    end-date: "",
    summary: "",
    highlights: (),
  ) = {
    let period = start-date + " ~ " + end-date
    generic_2x2(
      (1fr, 1fr),
      strong(if website == "" { company } else { link(website)[#company] }),
      [_*#period*_],
      emph(position),
      emph(location),
    )
    summary
    for highlight in highlights {
      pad(left: 1em)[- #highlight]
    }
  }

  [
    = #i18n.title.work.at(lang)
    #(
      data
        .map(work-item => single-work-item(
          company: work-item.at("company", default: ""),
          website: work-item.at("website", default: ""),
          location: location-to-str(work-item.at("location", default: "")),
          position: work-item.at("position", default: ""),
          start-date: date-to-str(work-item.at("startDate", default: "")),
          end-date: date-to-str(work-item.at("endDate", default: "")),
          summary: work-item.at("summary", default: ""),
          highlights: work-item.at("highlights", default: ()),
        ))
        .join(v(0.6em))
    )
  ]
}

#let projects-section(
  data: (),
  lang: "en",
) = {
  let single-project-item(
    name: "",
    website: "",
    github-url: "",
    start-date: "",
    end-date: "",
    summary: "",
    highlights: (),
  ) = {
    let period = start-date + " ~ " + end-date
    generic_2x2(
      (1fr, 1fr),
      strong(if website == "" { name } else { link(website)[#name] }),
      [_*#period*_],
      if github-url == "" {
        ""
      } else {
        underline(offset: 0.2em)[#emph(link(github-url)[#"Repo Link"])]
      },
      "",
    )
    summary
    for highlight in highlights {
      pad(left: 1em)[- #highlight]
    }
  }

  [
    = #i18n.title.projects.at(lang)
    #(
      data
        .map(project-item => single-project-item(
          name: project-item.at("name", default: ""),
          website: project-item.at("website", default: ""),
          github-url: project-item.at("githubUrl", default: ""),
          start-date: date-to-str(project-item.at("startDate", default: "")),
          end-date: date-to-str(project-item.at("endDate", default: "")),
          summary: project-item.at("summary", default: ""),
          highlights: project-item.at("highlights", default: ()),
        ))
        .join(v(0.6em))
    )
  ]
}

#let publications-section(
  data: (),
  lang: "en",
) = {
  let single-publication-item(
    name: "",
    url: "",
    release-date: "",
    publisher: "",
    summary: "",
  ) = {
    generic_2x2(
      (1fr, 1fr),
      strong(if url == "" { name } else { link(url)[#name] }),
      [_*#release-date*_],
      emph(publisher),
      "",
    )
    summary
  }

  [
    = #i18n.title.publications.at(lang)
    #(
      data
        .map(publication-item => single-publication-item(
          name: publication-item.at("name", default: ""),
          url: publication-item.at("url", default: ""),
          release-date: date-to-str(publication-item.at("releaseDate", default: "")),
          publisher: publication-item.at("publisher", default: ""),
          summary: publication-item.at("summary", default: ""),
        ))
        .join(v(0.6em))
    )
  ]
}

#let education-section(
  data: (),
  lang: "en",
) = {
  let single-education-item(
    institution: "",
    location: "",
    major: "",
    degree: "",
    gpa: "",
    start-date: "",
    end-date: "",
    activities: (),
    courses: (),
  ) = {
    let period = start-date + " ~ " + end-date
    generic_2x2(
      (1fr, 1fr),
      [*#institution*],
      [_*#period*_],
      emph(degree),
      emph(location),
    )
    par(
      leading: 0.4em,
      courses.map(x => box-text[#x]).join(h(0.4em)),
    )
    for activity in activities {
      pad(left: 1em)[- #activity]
    }
  }

  [
    = #i18n.title.education.at(lang)
    #(
      data
        .map(education-item => single-education-item(
          institution: education-item.at("institution", default: ""),
          location: location-to-str(education-item.at("location", default: "")),
          major: education-item.at("major", default: ""),
          degree: education-item.at("degree", default: ""),
          gpa: education-item.at("gpa", default: ""),
          start-date: date-to-str(education-item.at("startDate", default: "")),
          end-date: date-to-str(education-item.at("endDate", default: "")),
          activities: education-item.at("activities", default: ()),
          courses: education-item.at("courses", default: ()),
        ))
        .join(v(0.6em))
    )
  ]
}

#let certificates-section(
  data: (),
  lang: "en",
) = {
  let single-certificate-item(
    name: "",
    url: "",
    issue-date: "",
    exp-date: "",
    issuer: "",
  ) = {
    let period = issue-date + " ~ " + exp-date
    generic_2x2(
      (1fr, 1fr),
      strong(if url == "" { name } else { link(url)[#name] }),
      [_*#period*_],
      emph(issuer),
      "",
    )
  }

  [
    = #i18n.title.certifications.at(lang)
    #for certificate-item in data {
      single-certificate-item(
        name: certificate-item.at("name", default: ""),
        url: certificate-item.at("url", default: ""),
        issue-date: date-to-str(certificate-item.at("issueDate", default: "")),
        exp-date: date-to-str(certificate-item.at("expDate", default: "")),
        issuer: certificate-item.at("issuer", default: ""),
      )
    }
  ]
}

#let awards-section(
  data: (),
  lang: "en",
) = {
  let single-award-item(
    title: "",
    date: "",
    awarder: "",
    summary: "",
    description: "",
  ) = {
    generic_2x2(
      (auto, 1fr),
      strong(title),
      [_*#date*_],
      emph(awarder),
      "",
    )
    [
      #summary
      #pad(
        left: 1em,
        text(fill: rgb(100, 100, 100))[#description],
      )

    ]
  }

  [
    = #i18n.title.awards.at(lang)
    #(
      data
        .map(award-item => single-award-item(
          title: award-item.at("title", default: ""),
          date: date-to-str(award-item.at("date", default: "")),
          awarder: award-item.at("awarder", default: ""),
          summary: award-item.at("summary", default: ""),
          description: award-item.at("description", default: ""),
        ))
        .join(v(0.6em))
    )
  ]
}

#let skills-section(
  data: (),
  lang: "en",
) = {
  let single-skill-item(
    name: "",
    keywords: (),
  ) = {
    [
      *#name*: #keywords.join([, ]) \
    ]
  }

  [
    = #i18n.title.skills.at(lang)
    #(
      data
        .map(skill-item => single-skill-item(
          name: skill-item.at("name", default: ""),
          keywords: skill-item.at("keywords", default: ()),
        ))
        .join(v(0.2em))
    )
  ]
}

#let languages-section(
  data: (),
  lang: "en",
) = {
  let single-language-item(
    language: "",
    fluency: "",
  ) = {
    [
      *#language* - #fluency \
    ]
  }

  [
    = #i18n.title.languages.at(lang)
    #(
      data
        .map(language-item => single-language-item(
          language: language-item.at("language", default: ""),
          fluency: language-item.at("fluency", default: ""),
        ))
        .join(v(0.2em))
    )
  ]
}
