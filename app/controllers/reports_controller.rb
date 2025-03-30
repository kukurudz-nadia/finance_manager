class ReportsController < ApplicationController
  rescue_from StandardError, with: :handle_exception
  
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

    if @categories.nil? || @categories.empty?
     redirect_to reports_report_by_category_path, alert: 'You have to fill the form correctly'
    else
      @total_sum = @categories.values.sum

      #for views
      @category_names = []
      @amount = []
      @categories.each do |name, amount|
        @category_names << name
        @amount << amount
      end
      @dates = []
      @dates << Date.parse(@@params[:date_from]).strftime("%d/%m/%Y")
      @dates << Date.parse(@@params[:date_to]).strftime("%d/%m/%Y")
      @kind = @@params[:kind].downcase
    end
  end


  def report_by_dates
    @transactions = Transaction.where(kind: @@params[:kind])
                               .where('odate BETWEEN ? AND ?', @@params[:date_from], @@params[:date_to])
                               .select("odate::date, sum(amount) as total_amount, array_agg(description) as descriptions")
                               .group("odate::date")

    #for views
    @dates = []
    @sum = []
    @descriptions = []
    @kind = @@params[:kind].downcase

    @transactions.each do |transaction|
      reversed_date = transaction.odate.strftime("%d-%m-%Y")
      @dates << reversed_date
      @sum << transaction.total_amount.to_s
      @descriptions << transaction.descriptions.join(", ")  
    end
  end

  private

  def handle_exception(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")
    redirect_to root_path, alert: "An unexpected error occurred. Please try again later."
  end
end
