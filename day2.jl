function getCourseFromLine(l)
    (direction, distanceS) = split(l, " ")
    distance = parse(Int32, distanceS)
    return (direction, distance)
end

function calcpos(filename)
    lines = readlines(filename)
    coursePlan = getCourseFromLine.(lines)
    horizontalPos = 0
    depth = 0
    for step in coursePlan
        if step[1] == "forward"
            horizontalPos += step[2]
        elseif step[1] == "up"
            depth -= step[2]
        elseif step[1] == "down"
            depth += step[2]
        else
            throw(AssertionError(step))
        end
    end
    return horizontalPos * depth
end
