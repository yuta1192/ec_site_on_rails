module Admin::InqueriesHelper
  def inquery_select_box
    @inquery_select = Inquery.all.map{|c|[c.title, c.id]}
    @inquery_select.unshift(["新規作成",99])
  end
end
