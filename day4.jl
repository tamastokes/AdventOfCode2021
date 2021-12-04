function getDrawnNumbers(s)
    numbers = split(s,",")
    return parse.(Int32,numbers)
end

function getBoards(lines)
    nboards = (length(lines)-1) ÷ 6
    boards = zeros(Int32,0)
    for i in 2:length(lines)
        if i % 6 != 2
            nums = parse.(Int32, filter(x->length(x)>0, split(lines[i], " ")))
            append!(boards, nums)
        end
    end
    # note that as Julia has column-major arrays,
    # my boards are transposed
    return (nboards, reshape(boards, (5, 5, nboards)))
end

function processInput(filename)
    lines = readlines(filename)
    return (getDrawnNumbers(lines[1]), getBoards(lines))
end

function isBingo(drawnNumbers, row)
    return issetequal(union(drawnNumbers, row), drawnNumbers)
end

function calcScore(board, drawnNumbers)
    return (sum(board) - sum(intersect(board,drawnNumbers))) * last(drawnNumbers)
end

function bingo(filename)
    (drawnNumbers, (nboards, boards)) = processInput(filename)
    for n in 1:length(drawnNumbers)
        for board in 1:nboards
            for row in 1:5
                # note our matrices are transcribed,
                # cols and rows are interpreded just the other way arond
                if isBingo(drawnNumbers[1:n], boards[:, row, board])
                    @show board, "row: ", row, n, 
                    return calcScore(boards[:, :, board], drawnNumbers[1:n])
                end
            end
            for col in 1:5
                # note our matrices are transcribed,
                # cols and rows are interpreded just the other way arond
                if isBingo(drawnNumbers[1:n], boards[col, :, board])
                    @show board, "col: ", col, n
                    return calcScore(boards[:, :, board], drawnNumbers[1:n])
                end
            end
        end
    end
end
