class Image::RegisterController < ApplicationController

  # *** トップページ ***
  def index
    tmp = TmpImage.first
    @image = tmp[:filename]
    @blocks = TextBlock.view_css(tmp[:image_id])
  end


  # *** ラベル登録用のメソッド ***
  def register
    pos = params[:pos]
    text = TextBlock.create(
      image_id: TmpImage.first[:image_id],
      text: pos[:text],
      x1: pos[:pos1_x1],  y1: pos[:pos1_y1],
      x2: pos[:pos2_x2],  y2: pos[:pos2_y2]
    )
    redirect_to root_path
  end


  # *** 前の操作を取り消すメソッド ***
  def delete
    TextBlock.last.delete
    redirect_to root_path
  end


  # *** 次の画像に移動するメソッド ***
  def next
    # 現状の画像を完了に
    tmp = TmpImage.first
    image = Image.find_by(filename: tmp[:filename])
    image.update_attribute(:is_complete, true)
    # 新しい画像に切り替える
    files = Dir::entries("app/assets/images/")
    files.each do |file|
      if file.include?(".jpg") || file.include?(".png") || file.include?(".jpeg")
        # ファイル名が既に書き込まれていないか確認
        db_files = Image.where(filename: file)
        if db_files.empty?
          image = Image.create(filename: file)
          TmpImage.first.update_attribute(:filename, file)
          TmpImage.first.update_attribute(:image_id, image.id)
          break
        end
      end
    end
    # トップページへ遷移
    redirect_to root_path
  end


  # *** ダウンロードページ ***
  def download
    respond_to do |format|
      format.html
      format.csv do
        filename = 'recognition_result'
        headers['Content-Disposition'] = "attachment; filename=\"#{filename}.csv\""
      end
    end
  end


  # *** リセット（初期化）用のページ ***
  def reset
    # データベースの中身を削除する
    Image.all.each do |t|
      t.delete
    end
    TmpImage.all.each do |t|
      t.delete
    end
    TextBlock.all.each do |t|
      t.delete
    end
    # 最初の画像を指定する ※ サンプル画像以外の場合はこちらを書き換え
    image = Image.create(filename:"image_sample_01.png")
    TmpImage.create(filename:image[:filename], image_id: image.id)
    redirect_to root_path
  end

end
