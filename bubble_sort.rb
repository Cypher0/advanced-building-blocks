def bubble_sort(array)
	i = array.length - 1
	i.times do
		n = 0
		loop do
			if array[n] > array[n + 1]
				array[n], array[n + 1] = array[n + 1], array[n]
				n += 1
			else
				n += 1
			end
			break if n == i
		end
	end
	print array
end

bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(array)
	i = array.length - 1
	i.times do
		n = 0
		loop do
			if yield(array[n], array[n + 1]) > 0
				array[n], array[n + 1] = array[n + 1], array[n]
				n += 1
			end
			break if n == 0
		end
	end
	print array
end

bubble_sort_by(["hi", "hello", "hey"]) do |left, right|
	left.length - right.length
end