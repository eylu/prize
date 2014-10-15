json.array!(@articles) do |article|
  json.extract! article, :id, :title, :category_id, :hits, :thumb, :summary, :content, :flg
  json.url article_url(article, format: :json)
end
