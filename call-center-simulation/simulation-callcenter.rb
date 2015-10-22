require 'matrix'

# Cumulative sum.
class Array
  def cum_sum
    sum = 0
    self.map{|x| sum += x}
  end

  def sum
    sum = 0
    self.each { |x| sum += x }
    sum
  end
end

# Poisson sampling.
def rpois(lambd)
  l = Math.exp(-lambd)
  k = 0
  p = 1
  begin
    k += 1
    p *= rand 
  end while p > l
  k - 1
end

# Exponential sampling.
def rexp(rate)
  -Math.log(rand) / rate
end

# Gamma sampling.
def rgamma(k, lambd)
  ((1..k).map { rexp(lambd) }).sum
end

#####

# Market conditions.
market_size = 51000                              # Number of suspects.
reachability = 0.75                              # Fraction of market responding to phone calls.

num_suspects = (market_size * reachability).to_i
#num_prospects = 0.3                              # Fraction of market interested in the services. [not in use]

# Marketing strategy.
conversion_rate = 0.055                          # 0.03-0.07 are reasonable numbers
call_tries = 3                                   # maximum number of calls per lead
prob_conversion = 1 - (1-conversion_rate)**call_tries
periods = 32                                     # each period represents a month

calls_per_caller = 96 * (30 * 4/7).to_i         # calls per caller per period
call_center_growth = 0.25                        # call center human resources growth rate per period

avg_retention = 1                                # average retention time (in periods)
gamma_param_b = 0.18                             # used in gamma distribution together with avg_retention

avg_price = ((99*0.85 + 180*0.08 + 450*0.05 + 1100*0.02) + (300*0.02)).to_i          # average price

# Call center structure.
callers = []
(1..periods).each { |n| callers << (2 * (1 + call_center_growth)**n).to_i }

# Leads and customers.
class Lead
  attr_accessor :tries_left, :is_customer, :retention_time

  def initialize(tries_available, retention)
    @tries_left = tries_available
    @retention_time = retention
    @is_customer = false
  end

  def analyze_proposal(conv_rate)
    return @is_customer if @tries_left <= 0 or @is_customer      # enough tries?
    @tries_left -= 1
    @is_customer = true if rand < conv_rate
    @is_customer
  end
end

leads = []
(0..(num_suspects - 1)).each { leads << Lead.new(call_tries, rgamma(avg_retention, gamma_param_b)) }

customers = []

# Simulation.
new_customers_count = []                         # quantity of new customers at each period
leads_count = []                                 # quantity of leads
lost_customers_count = []                        # quantity of customers lost
exhausted_leads_count = []                       # quantity of leads having received maximum number of calls

(0..(periods - 1)).each do |period|
  # cold calls
  new_customers_count << 0
  (1..callers[period]).each do
    (1..calls_per_caller).each do
      lead_idx = (rand * leads.count).to_i
      lead = leads[lead_idx]
      if lead.analyze_proposal(conversion_rate)
        customers << leads[lead_idx]
        leads.delete_at(lead_idx)
        new_customers_count[period] += 1
      end
    end
  end

  # calculate lost customers
  losses_this_period = 0
  customers.each do |c|
    c.retention_time -= 1
    if c.retention_time <= 0
      losses_this_period += 1
      customers.delete(c)
    end
  end
  lost_customers_count << losses_this_period

  # exhausted leads
  exhausted = 0
  leads.each { |l| exhausted += 1 if l.tries_left <= 0 }
  exhausted_leads_count << exhausted

  # count of leads
  leads_count << leads.count

  # correct number of HR callers
  callers[period + 1] = callers[period] if exhausted.to_f / leads_count[period].to_f > 0.5
  callers[period + 1] = [(callers[period] / 2).to_i, 4].max if exhausted.to_f / leads_count[period].to_f >= 0.85

  # waiting
  print "."
end
puts ""

# Pre-calculations.
cum_new_customers = new_customers_count.cum_sum
cum_lost_customers = lost_customers_count.cum_sum
customers_count = Matrix[cum_new_customers] - Matrix[cum_lost_customers]
payments_count = 0
customers_count.row(0).to_a.each { |x| payments_count += x }

# Report.
(0..(periods - 1)).each do |p|
  report = "p=#{p}  "
  report += "Callers: #{callers[p]}. "
  report += "Customers: #{customers_count[0,p]} (+#{new_customers_count[p]} -#{lost_customers_count[p]}). "
  report += "Leads: #{leads_count[p]} (#{exhausted_leads_count[p]} exhausted). "
  report += "Revenue: R$ #{(avg_price * customers_count[0,p] / 1000).to_i}k"
  
  puts report
end

# Accountancy.
puts "Total revenue: R$ #{payments_count * avg_price}"
employees = 0.35
ads = 0.167
physical = 0.15
others = 0.05
taxes = 0.16
profit = (payments_count * avg_price * (1 - taxes - employees - ads - physical - others)).to_i
puts "Total profit: R$ #{profit}"

# Inspect.
#puts callers.inspect
#puts customers_count.inspect
#puts new_customers_count.inspect
#puts lost_customers_count.inspect
#puts leads_count.inspect
#puts exhausted_leads_count.inspect
