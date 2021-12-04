function getDiagnostics(filename)
    lines = readlines(filename)
    ndigits = length(lines[1])
    nums = parse.(Int32, lines, base=2)
    counts = zeros(Int32, ndigits)
    for n in nums
        for i in 1:ndigits
            pow = 2^(i-1)
            d = n & pow
            counts[i] += (d/pow)
        end
    end
    gamma = counts .> length(lines)/2
    g = 0
    for i in 1:length(gamma)
        g += gamma[i] * 2^(i-1)
    end
    epsilon = counts .< length(lines)/2
    e = 0
    for i in 1:length(epsilon)
        e += epsilon[i] * 2^(i-1)
    end
    return g * e
end

function nthDigit(num, digit, ndigits)
    pow = 2^(ndigits-digit)
    return convert(Int32, (num & pow) / pow)
end

function getRatings(filename)
    lines = readlines(filename)
    ndigits = length(lines[1])
    nums = parse.(Int32, lines, base=2)
    nums2 = copy(nums)
    round = 1
    while length(nums) > 1
        count = 0
        for n in nums
            count += nthDigit(n, round, ndigits)
        end
        oneorzero = convert(Int32, count >= length(nums)/2)
        filter!( (x) -> nthDigit(x, round, ndigits) == oneorzero, nums)
        @show nums
        round += 1
    end
    oxygen = nums[1]
    nums = nums2
    # shameless copy-paste here
    round = 1
    while length(nums) > 1
        count = 0
        for n in nums
            count += nthDigit(n, round, ndigits)
        end
        oneorzero = convert(Int32, count >= length(nums)/2)
        filter!( (x) -> nthDigit(x, round, ndigits) != oneorzero, nums)
        @show nums
        round += 1
    end
    co2 = nums[1]
    return(oxygen * co2)
end