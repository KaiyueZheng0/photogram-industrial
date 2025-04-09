json.extract! comment, :id, :body, :photo_id, :author_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
