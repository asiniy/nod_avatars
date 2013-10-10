if @photo.persisted?
  json.success true
  json.content render(partial: 'photos/photo', object: @photo)
  json.photo_count Photo.published.count
else
  json.success false
  json.errors render_errors errors_for(@photo)
end
