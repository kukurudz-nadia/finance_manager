class ReportsController < ApplicationController
  def index
    @@params = params
  end

  def report_by_category
    transactions = Transaction.where(kind: @@params[:kind])
    category_ids = []

    transactions.each do |transaction|
      category_ids << transaction.category_id
    end
    category_ids = category_ids.uniq

    @categories = {}
    category_ids.each do |category_id|
      category = Category.find(category_id)
      @categories.store(category.name, Transaction.where(category_id: category_id).sum(:amount))
    end

    @total_sum = @categories.values.sum
  end
  
  def report_by_dates
    @transactions = Transaction.where('odate BETWEEN ? AND ?', @@params[:date_from], @@params[:date_to]).group('odate::date').sum(:amount)
  end
end
