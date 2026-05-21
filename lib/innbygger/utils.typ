// Format ISO timestamp to Norwegian date/time (DD.MM.YYYY HH:MM)
#let iso-til-norsk-dato(iso) = {
  let parts = iso.split("T")
  let d = parts.at(0).split("-")
  if d.len() >= 3 {
    let time = if parts.len() > 1 and parts.at(1).len() >= 5 {
      " " + parts.at(1).slice(0, 5)
    } else { "" }
    d.at(2) + "." + d.at(1) + "." + d.at(0) + time
  } else { iso }
}
