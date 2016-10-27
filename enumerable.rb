module Enumerable
	def my_each
		i = 0
		while i < self.length
			yield(self[i])
			i += 1
		end
	end

	def my_each_with_index
		i = 0
		while i < self.length
			yield(self[i], i)
			i += 1
		end
	end

	def my_select
		i = 0
		result = []
		while i < self.length
			result << self[i] if yield(self[i])
			i += 1
		end
		result
	end

	def my_all?
		self.my_each do |element|
			return false unless yield(element)
		end
		true
	end

	def my_any?
		self.my_each do |element|
			return true if yield(element)
		end
		false
	end

	def my_none?
		self.my_each do |element|
			return false if yield(element)
		end
		true
	end

	def my_count
		i = 0
		self.my_each do |element|
			if block_given?
				i += 1 if yield(element)
			else
				i += 1
			end
		end
		i
	end

	def my_map(&block)
		result = []
		if block_given?
			self.my_each do |element|
				result << yield(element)
			end
		else
			self.my_each do |element|
				result << element.block.call
			end
		end
		result
	end

	def my_inject(i = nil)
		if i == nil
			n = 1
		else
			n = i
		end
		self.my_each do |element|
			n = yield(n, element)
		end
		n
	end
end

def multiply_els(array)
		array.my_inject{ |result, element| result * element }
end

["A", "b", 1, 2].my_each do |elmnt|
	puts elmnt
end

["A", "b", 1, 2].my_each_with_index do |elmnt, indx|
	puts "#{indx}. #{elmnt}"
end

puts ["A", "b", 1, 2].my_select { |elmnt| elmnt.is_a? Integer }

puts ["A", "b", 1, 2].my_all?  { |elmnt| elmnt.is_a? Integer }
puts [1, 2].my_all?  { |elmnt| elmnt.is_a? Integer }

puts ["A", "b", 1, 2].my_any?  { |elmnt| elmnt.is_a? Integer }
puts ["A", "b"].my_any?  { |elmnt| elmnt.is_a? Integer }

puts ["A", "b", 1, 2].my_none?  { |elmnt| elmnt.is_a? Integer }
puts ["A", "b"].my_none?  { |elmnt| elmnt.is_a? Integer }

puts ["A", "b", 1, 2].my_count { |elmnt| elmnt.is_a? Integer}
puts ["A", "b", 1, 2].my_count

puts [10, 20, 1, 2].my_map { |elmnt| elmnt + 9}

puts multiply_els([2,4,5])

power = Proc.new do |i|
	i ** 2
end

puts [10, 20, 1, 2].my_map(&power)

puts [10, 20, 1, 2].my_map { |elt| elt ** 3 }