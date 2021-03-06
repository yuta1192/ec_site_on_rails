class Admin::GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def search
  end

  def show
    @group = Group.find(params[:id])
    if params[:group].present?
      @group_users_params = search_params
      @users = User.users_search(@group_users_params)
    else
      @group_users = @group.group_users
    end
  end

  def update
  end

  def create
    @group = Group.new(new_params)
    if @group.save!
      redirect_to admin_group_path(@group)
    else
      render 'new'
    end
  end

  def destroy
  end

  private

  def search_params
    params.require(:group).permit(:member_code, :company_name, :department_name, :name_sei, :name_mei, :zip_code_first, :zip_code_second, :e_mail, :tel_first, :tel_second, :tel_third)
  end

  def new_params
    params.require(:group).permit(:name)
  end
end
