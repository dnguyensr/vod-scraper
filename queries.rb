# interpolation takes advantage of pg escaping values
QUERIES = {
  all_vods: %{SELECT * FROM vods},
  find_vods_by_date: %{SELECT * FROM vods WHERE date = :date},
  find_vods_by_id: %{SELECT * FROM vods WHERE id = :id},
  find_vods_by_title: %{SELECT * FROM vods WHERE title ~* :title},
  create_vod: %{
    INSERT INTO vods (id, url, title, date)
    VALUES (:id, :url, :title, :date)
    ON CONFLICT DO NOTHING
  },
  clear_vods: %{DELETE FROM vods},
}
