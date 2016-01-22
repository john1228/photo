ActiveAdmin.register Transaction do
  config.batch_actions = false
  actions :index, :show
  filter :no
  filter :order_no
  filter :source
  filter :created_at


  index do
    column :no
    column :order_no
    column :source
    column :buy_id
    column :buyer_email
    column :price
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :no
      row :order_no
      row :source
      row :buy_id
      row :buyer_email
      row :price
      row :created_at
    end
  end
end
