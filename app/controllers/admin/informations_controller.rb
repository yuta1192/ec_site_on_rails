class Admin::InformationsController < ApplicationController
  def index
    @errors = []
    @informations = Information.all
    @information = Information.new
    @info_title = InfoTitle.first
  end

  def info_title
    @informations = Information.all
    @information = Information.new
    @info_title = InfoTitle.first
    if @info_title.update(info_title_params)
      redirect_to admin_informations_path
    else
      render 'index'
    end
  end

  def edit
    @errors = []
    @info_title = InfoTitle.first
    @informations = Information.all
    @information = Information.find(params[:id])
  end

  def update
    @info_title = InfoTitle.first
    @informations = Information.all
    @infomation = Information.find(params[:id])

    published_start = nil
    published_end = nil

    @errors = params_valid_check(info_params)

    if @errors.present?
      render 'index' and return
    end

    if info_params[:published_start_yyyymmdd].present?
      published_start = info_params[:published_start_yyyymmdd] + ' ' + info_params[:published_start_hhmm]
    end
    if info_params[:published_end_yyyymmdd].present?
      published_end = info_params[:published_end_yyyymmdd] + ' ' +info_params[:published_end_hhmm]
    end

    if @infomation.update(detail: info_params[:detail], release_flg: info_params[:release_flg], date: info_params[:date], published_start: published_start, published_end: published_end)
      if attachment_files_add(@infomation, params)
        redirect_to edit_admin_information_path(@infomation)
      else
        render 'edit' and return
      end
    else
      render 'edit'
    end
  end

  def create
    # todo 修正
    @info_title = InfoTitle.first
    @informations = Information.all

    published_start = nil
    published_end = nil

    @errors = params_valid_check(info_params)

    if @errors.present?
      render 'index' and return
    end

    if info_params[:published_start_yyyymmdd].present?
      published_start = info_params[:published_start_yyyymmdd] + ' ' + info_params[:published_start_hhmm]
    end
    if info_params[:published_end_yyyymmdd].present?
      published_end = info_params[:published_end_yyyymmdd] + ' ' +info_params[:published_end_hhmm]
    end

    @infomation = Information.new(
      detail: info_params[:detail],
      release_flg: info_params[:release_flg],
      date: info_params[:date],
      published_start: published_start,
      published_end: published_end
    )
    if @infomation.save
      if attachment_files_new(@infomation, params)
        redirect_to edit_admin_information_path(@infomation)
      else
        render 'index' and return
      end
    else
      render 'index'
    end
  end

  def destroy
    @info_title = InfoTitle.first
    @informations = Information.all
    @infomation = Information.find(params[:id])

    if @infomation.destroy
      redirect_to admin_informations_path
    else
      render 'index'
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

  def download
    @informetion = InformationAttachmentFile.find(params[:id])
    # ref: https://github.com/carrierwaveuploader/carrierwave#activerecord
    filepath = @informetion.attachment_file.current_path
    stat = File::stat(filepath)
    send_file(filepath, :filename => @informetion.filename, :length => stat.size)
  end

  private

    def info_params
      params.require(:information).permit(:detail, :release_flg, :date, :published_start_yyyymmdd, :published_start_hhmm, :published_end_yyyymmdd, :published_end_hhmm)
    end

    def info_title_params
      params.require(:info_title).permit(:title, :hyoji_count)
    end

    def attachment_files_new(info, params)
      begin
        if params[:information][:attachment_file1].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file1],
            filename: params[:information][:attachment_file1].original_filename
          )
        end
        if params[:information][:attachment_file2].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file2],
            filename: params[:information][:attachment_file2].original_filename
          )
        end
        if params[:information][:attachment_file3].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file3],
            filename: params[:information][:attachment_file3].original_filename
          )
        end
        if params[:information][:attachment_file4].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file4],
            filename: params[:information][:attachment_file4].original_filename
          )
        end
        if params[:information][:attachment_file5].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file5],
            filename: params[:information][:attachment_file5].original_filename
          )
        end
        return true
      rescue
        return false
      end
    end

    def attachment_files_add(info, params)
      begin
        if params[:information][:attachment_file1].present? || params[:information][:attachment_file2].present? || params[:information][:attachment_file3].present? || params[:information][:attachment_file4].present? || params[:information][:attachment_file5].present?
          InformationAttachmentFile.where(information_id: info.id).destroy
        end
        if params[:information][:attachment_file1].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file1],
            filename: params[:information][:attachment_file1].original_filename
          )
        end
        if params[:information][:attachment_file2].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file2],
            filename: params[:information][:attachment_file2].original_filename
          )
        end
        if params[:information][:attachment_file3].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file3],
            filename: params[:information][:attachment_file3].original_filename
          )
        end
        if params[:information][:attachment_file4].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file4],
            filename: params[:information][:attachment_file4].original_filename
          )
        end
        if params[:information][:attachment_file5].present?
          InformationAttachmentFile.create(
            information_id: info.id,
            attachment_file:  params[:information][:attachment_file5],
            filename: params[:information][:attachment_file5].original_filename
          )
        end
        return true
      rescue
        return false
      end
    end

    def params_valid_check(info_params)
      @errors = []
      if (info_params[:published_start_yyyymmdd].present? && info_params[:published_start_hhmm].blank?) || (info_params[:published_start_yyyymmdd].blank? && info_params[:published_start_hhmm].present?)
        @errors << "掲載開始日を正しく入力してください。"
      end

      if (info_params[:published_end_yyyymmdd].present? && info_params[:published_end_hhmm].blank?) || (info_params[:published_end_yyyymmdd].blank? && info_params[:published_end_hhmm].present?)
        @errors << "掲載終了日を正しく入力してください。"
      end

      if info_params[:published_start_hhmm].present?
        if info_params[:published_start_hhmm].length < 3
          @errors << "掲載開始時刻を正しく入力してください。"
        else
          start_hhmm = info_params[:published_start_hhmm]
          # 末尾から挿入し、 "0:10" のような文字列にする。 ":"の前後で取得
          match = start_hhmm.insert(-3, ":").match(/:/)
          start_hh = match.pre_match
          if start_hh.to_i > 23
            @errors << "掲載開始時間は0~23の数字で記載してください"
          end
          start_mm = match.post_match
          if start_mm.to_i > 59
            @errors << "掲載開始時間は00~59の数字で記載してください"
          end
        end
      end

      if info_params[:published_end_hhmm].present?
        if info_params[:published_end_hhmm].length < 3
          @errors << "掲載開始時刻を正しく入力してください。"
        else
          end_hhmm = info_params[:published_end_hhmm]
          # 末尾から挿入し、 "0:10" のような文字列にする。 ":"の前後で取得
          match = end_hhmm.insert(-3, ":").match(/:/)
          end_hh = match.pre_match
          if end_hh.to_i > 23
            @errors << "掲載開始時間は0~23の数字で記載してください"
          end
          end_mm = match.post_match
          if end_mm.to_i > 59
            @errors << "掲載開始時間は00~59の数字で記載してください"
          end
        end

        return @errors
      end
    end
end
