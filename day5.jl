function getLinesFromInput(input)
    lines = zeros(Int32, 0)
    splitInput = split.(input, " ")
    for i in splitInput
        (x1, y1) = parse.(Int32, split(i[1],","))
        (x2, y2) = parse.(Int32, split(i[3],","))
        append!(lines, [x1, y1, x2, y2,]) 
    end
    return transpose(reshape(lines, 4, :))
end

function processInput(filename)
    input = readlines(filename)
    return getLinesFromInput(input)
end

function getSequence(n1, n2)
    if n1 < n2
        return range(n1,n2)
    else
        return range(start=n1, step=-1, stop=n2)
    end
end

function getPointsInLine(line)
    points = zeros(typeof(l[1]),0)
    if line[1] == line[3]
        for i in getSequence(line[2],line[4])
            append!(points, line[1])
            append!(points, i)
        end
    elseif line[2] == line[4]
        for i in getSequence(line[1],line[3])
            append!(points, i)
            append!(points, line[2])
        end
    else # only for part 2, delete the else case for part 1
        xs = getSequence(line[1],line[3])
        ys = getSequence(line[2],line[4])
        for i in 1:length(xs)
            append!(points, xs[i])
            append!(points, ys[i])
        end
     end
     return transpose(reshape(points, 2, :))
end

function fillGrid(lines)
    size = convert(Int64,maximum(lines)) + 1
    grid = reshape(zeros(typeof(lines[1]), size^2), size, :)
    for i in 1:length(lines[:,1])
        points = getPointsInLine(lines[i,:])
        for point in eachrow(points)
            grid[point[1]+1,point[2]+1] += 1
        end
    end
    return grid
end

function findOverlaps(filename)
    lines = processInput(filename)
    return count(x->x>1,fillGrid(lines))
end