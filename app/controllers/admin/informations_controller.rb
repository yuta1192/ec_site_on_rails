class Admin::InformationsController < ApplicationController
  def index
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
    @info_title = InfoTitle.first
    @informations = Information.all
    @information = Information.find(params[:id])
  end

  def update
    @info_title = InfoTitle.first
    @informations = Information.all
    @infomation = Information.find(params[:id])
    if @infomation.update(info_params)
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
    @info_title = InfoTitle.first
    @informations = Information.all
    @infomation = Information.new(info_params)
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
      binding.pry
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
end
