json.extract! transaction, :id, :amount, :odate, :description, :category_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
