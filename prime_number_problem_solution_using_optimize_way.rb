=begin

Problem 1:
  The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17
  Find the sum of all the primes below 2 million. ans is 14291..
  
  Solution: 
    prime number conditon: 
    Prime numbers are positive integers greater than 1 that has only two divisors 1 and the number itself. 

    logic:
      Take a array from 0 to 2000000.
      Start from 2, delete every multiple of 2 from the array, except itself.
      Go to 3 ,delete every multiple of 3 from the array, except itself.
      4 is already deleted so go to 5 to delete multiple of 5.

      Continue untill we reach square root of 2000000. here squre root of 2000000 is 1414.
   
      Finally,This array will contain only the prime numbers up to 2000000.so that we can apply sumation on this array.

problem 2:
  Which prime, below one million, can be written as the sum of the most consecutive primes?
=end



class PrimeNumberCalulator

  attr_accessor :limit, :prime_number_list

  def initialize(limit = 2000000)
    @limit = limit
    @primes= [2]
    @primes[0] = @primes[1] = nil
    @primeSum =[]
    @primeSum[0] = 0
    @count_of_primeSum = 0
    @result= {}
    @counter = 0
    @sum = 0
    # number_of_primes = 1
  end

  def prime_upto(limit)
    # array with all the numbers from 0 to the limit
    @primes = (0..limit).to_a

    # 0 and 1  aren't prime.
    @primes[0] = @primes[1] = nil
    
    # Iterate through @primes array
    
    @primes.each do |p|
      # Skip if nil
      next unless p

      # Break if we are past the square root of the limit value 
      break if p*p > limit
      @counter += 1
      # Start at the square of the current number, and step through.
      # Go up to the limit value, by multiples of the current number, and replace  with nil.
      
      (p*p).step(limit,p) { |m| 
        @primes[m] = nil 
      }
    end
    # Finally, apply sum on the compacted array.campact will remove nil values from array.
    # puts "in #{counter} steps."
    return @primes.compact
  end


  # Which prime, below one million, can be written as the sum of the most consecutive primes?
  def get_consecutive_prime_below_one_million(primes)
    sumation = 0;
    prime_number_list = []
    number_of_primes = 0 
    primes.each_with_index do | prime_number , i |
       # puts "#{prime_number}  - #{i}"
      @sum = @sum + prime_number
      @primeSum[i+1] = @sum if @sum < @limit;
    end
    # puts "#{@primeSum}"

    count_of_primeSum =  @primeSum.length
    number_of_primes = 1 
    count_of_primeSum.times do |i|
      for j in (count_of_primeSum - 1).downto(i + number_of_primes ) do
        difference = @primeSum[j] - @primeSum[i]

        if (j-i > number_of_primes) && (difference < limit) &&  ( primes.include? difference)
          # puts "#{i}--#{j}"
          
          prime_number_list  = primes[i...j]
          number_of_primes = j-i
          sumation = difference 
        end
      end
    end
      @result[:sumation] = sumation 
      @result[:number_of_terms] = number_of_primes 
      @result[:prime_number_list] = prime_number_list 

      @result
  end

  def show_result_for_Q1(prime_numbers_array)
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts 'Q1:  Find the sum of all the primes below 2 million ?'
    puts "Ans: Sum of all prime numbers below  #{@limit} is #{prime_numbers_array.sum}"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n\n"
  end

  def show_result_for_Q2(result)
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Q2: Which prime, below one million, can be written as the sum of the most consecutive primes?"
    puts "sum if primes : #{ result[:sumation]}"
    puts "terms : #{ result[:number_of_terms]}"
    puts "list of most consecutive primes : #{ result[:prime_number_list]}"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n\n"
  end
end

prime_q1 = PrimeNumberCalulator.new
prime_q1.limit = 2000000
prime_numbers_array = prime_q1.prime_upto(prime_q1.limit)
prime_q1.show_result_for_Q1(prime_numbers_array)


prime_q2 = PrimeNumberCalulator.new
prime_q2.limit = 1000000
prime_numbers_array = prime_q2.prime_upto(prime_q2.limit)
result = prime_q2.get_consecutive_prime_below_one_million(prime_numbers_array)
prime_q2.show_result_for_Q2(result)






