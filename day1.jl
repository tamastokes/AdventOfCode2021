function countincrements(filename)
    words = readlines(filename)
    nums = parse.(Int32, words)
    cnt = 0
    for i = 2:length(nums)
        if nums[i] > nums[i-1]
            cnt += 1
        end
    end
    return cnt
end

function countwindowincrements(filename)
    words = readlines(filename)
    nums = parse.(Int32, words)
    cnt = 0
    for i = 1:(length(nums)-3)
        if (nums[i+1] + nums[i+2] + nums[i+3]) > (nums[i] + nums[i+1] + nums[i+2])
            cnt += 1
        end
    end
    return cnt
end

function countwindowincrements2(filename)
    words = readlines(filename)
    nums = parse.(Int32, words)
    cnt = 0
    for i = 1:(length(nums)-3)
        if nums[i+3] > nums[i]
            cnt += 1
        end
    end
    return cnt
end