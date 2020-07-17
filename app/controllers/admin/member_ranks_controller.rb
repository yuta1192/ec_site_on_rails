class Admin::MemberRanksController < ApplicationController
  def index
    @member_ranks = MemberRank.all
  end
end
