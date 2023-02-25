class ReportsController < ApplicationController
  def index
    @@params = params
  end

  def report_by_category
    transactions = Transaction.where(kind: @@params[:kind]).where('odate BETWEEN ? AND ?', @@params[:date_from], @@params[:date_to])
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

    @category_names = []
    @amount = []
    @categories.each do |name, amount|
      @category_names << name
      @amount << amount
    end
  end
  
  def report_by_dates
    @transactions = Transaction.where(kind: @@params[:kind]).where('odate BETWEEN ? AND ?', @@params[:date_from], @@params[:date_to]).group('odate::date').sum(:amount)
    @dates = []
    @sum = []
    @transactions.each do |date, sum|
      reversed_date = date.strftime("%d-%m-%Y")
      @dates << reversed_date
      @sum << sum.to_s
    end
  end
end
