# interpolation takes advantage of pg escaping values
QUERIES = {
  all_vods: %{SELECT * FROM vods},
  get_vods_from_yt: %{SELECT * FROM yt},
  get_ids_from_vods: %{SELECT id FROM vods},
  get_ids_from_yt: %{SELECT id FROM yt},
  find_vods_by_date: %{SELECT * FROM vods WHERE date = :date},
  find_vods_by_id: %{SELECT * FROM vods WHERE id = :id},
  find_yt_by_id: %{SELECT * FROM yt WHERE id = :id},
  find_vods_by_title: %{SELECT * FROM vods WHERE title ~* :title},
  create_vod: %{
    INSERT INTO vods (id, url, title, date)
    VALUES (:id, :url, :title, :date)
    ON CONFLICT DO NOTHING
  },
  push_vod_to_yt: %{
    INSERT INTO yt (id, url, title, date)
    VALUES (:id, :url, :title, :date)
    ON CONFLICT DO NOTHING
  },
  delete_vod: %{DELETE FROM vods WHERE id = :id},
  clear_vods: %{DELETE FROM vods},
  clear_yt: %{DELETE FROM yt}
}
