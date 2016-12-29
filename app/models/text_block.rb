class TextBlock < ApplicationRecord
  validates :text, :x1, :x2, :y1, :y2, :image_id, presence: true

  def self.view_css(image_id)
    output, count = {}, 0
    texts = self.where(image_id: image_id)
    texts.each do |t|
      output[count] = {}
      output[count][:x] = t.x1
      output[count][:y] = t.y1
      output[count][:width]  = t.x2 - t.x1
      output[count][:height] = t.y2 - t.y1
      count += 1
    end
    return output
  end
end
