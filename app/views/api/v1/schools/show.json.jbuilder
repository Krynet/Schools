json.school do
  
    json.id @school.id
    json.name @school.name
    json.address @school.address
    json.zip_code @school.zip_code
    json.city @school.city
    json.openings @school.openings
    json.phone @school.phone
    json.email @school.email
    json.nb_student @school.nb_student
    json.status @school.status
    json.latitude @school.latitude
    json.longitude @school.longitude
  end
