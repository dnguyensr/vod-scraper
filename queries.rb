# interpolation takes advantage of pg escaping values
QUERIES = {
  all_vods: %{select * from vods},
  find_vods_by_date: %{select * from vods where date = :date},
  find_vods_by_id: %{select * from vods where id = :id},
  find_vods_by_title: %{select * from vods where title ~* :title},
}
