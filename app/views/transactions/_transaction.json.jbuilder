json.extract! transaction, :id, :amount, :odate, :description, :category_id, :kind, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
