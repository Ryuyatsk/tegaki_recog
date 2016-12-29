require 'kconv'
require 'csv'
CSV.generate do |csv|
  # データの整理
  data = {}
  TextBlock.all.each do |t|
    datum = {}
    image = Image.find(t.image_id)
    filename = image.filename
    datum[:filename] = filename
    datum[:x1], datum[:y1] = t.x1, t.y1
    datum[:x2], datum[:y2] = t.x2, t.y2
    datum[:text] = t.text
    data[t.id] = datum
  end
  csv << ["id", "filename", "text", "x1", "y1", "x2", "y2"]  # Header
  # Body
  data.each do |id, datum|
    csv << [ id, datum[:filename], datum[:text], datum[:x1], datum[:y1], datum[:x2], datum[:y2] ]
  end
end.tosjis
