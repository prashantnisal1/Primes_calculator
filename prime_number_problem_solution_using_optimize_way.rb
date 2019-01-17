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






=begin

Output : 
  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Q1:  Find the sum of all the primes below 2 million ?
Ans: Sum of all prime numbers below  2000000 is 142913828922
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Q2: Which prime, below one million, can be written as the sum of the most consecutive primes?
sum if primes : 997651
terms : 543
list of most consecutive primes : [7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997, 1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399, 1409, 1423, 1427, 1429, 1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489, 1493, 1499, 1511, 1523, 1531, 1543, 1549, 1553, 1559, 1567, 1571, 1579, 1583, 1597, 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667, 1669, 1693, 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787, 1789, 1801, 1811, 1823, 1831, 1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889, 1901, 1907, 1913, 1931, 1933, 1949, 1951, 1973, 1979, 1987, 1993, 1997, 1999, 2003, 2011, 2017, 2027, 2029, 2039, 2053, 2063, 2069, 2081, 2083, 2087, 2089, 2099, 2111, 2113, 2129, 2131, 2137, 2141, 2143, 2153, 2161, 2179, 2203, 2207, 2213, 2221, 2237, 2239, 2243, 2251, 2267, 2269, 2273, 2281, 2287, 2293, 2297, 2309, 2311, 2333, 2339, 2341, 2347, 2351, 2357, 2371, 2377, 2381, 2383, 2389, 2393, 2399, 2411, 2417, 2423, 2437, 2441, 2447, 2459, 2467, 2473, 2477, 2503, 2521, 2531, 2539, 2543, 2549, 2551, 2557, 2579, 2591, 2593, 2609, 2617, 2621, 2633, 2647, 2657, 2659, 2663, 2671, 2677, 2683, 2687, 2689, 2693, 2699, 2707, 2711, 2713, 2719, 2729, 2731, 2741, 2749, 2753, 2767, 2777, 2789, 2791, 2797, 2801, 2803, 2819, 2833, 2837, 2843, 2851, 2857, 2861, 2879, 2887, 2897, 2903, 2909, 2917, 2927, 2939, 2953, 2957, 2963, 2969, 2971, 2999, 3001, 3011, 3019, 3023, 3037, 3041, 3049, 3061, 3067, 3079, 3083, 3089, 3109, 3119, 3121, 3137, 3163, 3167, 3169, 3181, 3187, 3191, 3203, 3209, 3217, 3221, 3229, 3251, 3253, 3257, 3259, 3271, 3299, 3301, 3307, 3313, 3319, 3323, 3329, 3331, 3343, 3347, 3359, 3361, 3371, 3373, 3389, 3391, 3407, 3413, 3433, 3449, 3457, 3461, 3463, 3467, 3469, 3491, 3499, 3511, 3517, 3527, 3529, 3533, 3539, 3541, 3547, 3557, 3559, 3571, 3581, 3583, 3593, 3607, 3613, 3617, 3623, 3631, 3637, 3643, 3659, 3671, 3673, 3677, 3691, 3697, 3701, 3709, 3719, 3727, 3733, 3739, 3761, 3767, 3769, 3779, 3793, 3797, 3803, 3821, 3823, 3833, 3847, 3851, 3853, 3863, 3877, 3881, 3889, 3907, 3911, 3917, 3919, 3923, 3929, 3931]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
=end