class Admin::InformationsController < ApplicationController
  def index
    @informations = Information.all
    @information = Information.new
    @info_title = InfoTitle.first
  end

  def info_title
    info_title = InfoTitle.first
    if info_title.update!(title: params[:info_title][:title].present? ? params[:info_title][:title] : info_title.title,
                          hyoji_count: params[:info_title][:hyoji_count].present? ? params[:info_title][:hyoji_count] : info_title.hyoji_count)
      redirect_to admin_informations_path
    else
      # todo エラーの場合
      render
    end
  end

  def edit
    @info_title = InfoTitle.first
    @informations = Information.all
    @information = Information.find(params[:id])
  end

  def update
    info = Information.find(params[:id])
    ActiveRecord::Base.transaction do
      info.update!(
        date: params[:information][:date],
        detail: params[:information][:detail],
        release_flg: false,
        published_start_yyyymmdd: params[:information][:published_start_yyyymmdd],
        published_start_hhmm: params[:information][:published_start_hhmm],
        published_end_yyyymmdd: params[:information][:published_end_yyyymmdd],
        published_end_hhmm: params[:information][:published_end_hhmm],
        # todo 添付ファイルを送信できるように修正する（複数送信できること)
        # if params[:information][:attachment_file].present?
        #   attachment_file1: params[:information][:attachment_file1],
        #   attachment_file2: params[:information][:attachment_file2],
        #   attachment_file3: params[:information][:attachment_file3],
        #   attachment_file4: params[:information][:attachment_file4],
        #   attachment_file5: params[:information][:attachment_file5]
        # end
      )
    end
      redirect_to edit_admin_information_path(info)
    rescue => e
      # todo エラーの場合をかく
      render 'information/index'
  end

  def create
    ActiveRecord::Base.transaction do
      info = Information.new(
        date: params[:information][:date],
        detail: params[:information][:detail],
        release_flg: false,
        published_start_yyyymmdd: params[:information][:published_start_yyyymmdd],
        published_start_hhmm: params[:information][:published_start_hhmm],
        published_end_yyyymmdd: params[:information][:published_end_yyyymmdd],
        published_end_hhmm: params[:information][:published_end_hhmm],
        # todo 添付ファイルを送信できるように修正する（複数送信できること)
        # if params[:information][:attachment_file].present?
        #   attachment_file1: params[:information][:attachment_file1],
        #   attachment_file2: params[:information][:attachment_file2],
        #   attachment_file3: params[:information][:attachment_file3],
        #   attachment_file4: params[:information][:attachment_file4],
        #   attachment_file5: params[:information][:attachment_file5]
        # end
      )
      info.save!
    end
      redirect_to admin_informations_path
    rescue => e
      # todo エラーの場合をかく
      render 'information/index'
  end

  def destroy
    info = Information.find(params[:id])
    if info.destroy!
      redirect_to admin_informations_path
    else
      # todo エラーの場合をかく
      render 'information/edit'
    end
  end

  def change_release
    ActiveRecord::Base.transaction do
      info = Information.find(params[:id])
      if info.blank?
        # todo info見つからない場合のエラー文送って返す
        return redirect_to admin_informations_path
      end
      release_flg = info.release_flg
      # release_flgがtrueならfalseに、falseならtrue
      change_flg = release_flg == true ? false : true

      info.update!(release_flg: change_flg)
    end
      redirect_to admin_informations_path
    rescue => e
      # todo エラーの場合をかく
      render 'information/index'
  end

end
