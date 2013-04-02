Order.transaction do 
  (1..100).each do |i|
    Order.create(:name => "Custemer #{i}", :address => "#{i} Main Street", :email => "customer -#{i}@examp.com", :pay_type => "Check")
  end
end