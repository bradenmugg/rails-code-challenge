# Creating non-shipped orders.
5.times { Order.create!() }
# Shipped at times are randomly assigned.
5.times { Order.create!(shipped_at: Time.now + Random.rand(60).minute) }