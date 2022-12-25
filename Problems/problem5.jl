popMany!(x,n) = [pop!(x) for _ = 1:n];

function moveCrates!(state,moves,isRev)
    for move = moves
        x = popMany!(state[move[2]],move[1]);
        append!(state[move[3]],ifelse(isRev,reverse(x),x));
    end
    return state;
end

function parseFile(file)
    lines = readlines(file);
    maxHeight = 0; n = 0;
    for line = lines
        if startswith(line," 1")
            n = parse(Int64,split(line)[end]);
            break
        end
        maxHeight+=1;
    end

    state = [];
    for i = 1:n
        stack = [];
        for j = 1:maxHeight
            c = lines[maxHeight-j+1][4*i-2];
            if c==' '
                break
            else
                push!(stack,c);
            end
        end
        push!(state,stack);
    end
    moves = [parse.(Int,split(strip(replace(x,r"[a-z]"=>"")))) for x in lines[maxHeight+3:end]];
    return state,moves;
end

(state,moves) = parseFile(open("./Inputs/input5.txt"));
res1 = String(last.(moveCrates!(state,moves,false)));
(state,moves) = parseFile(open("./Inputs/input5.txt"));
res2 = String(last.(moveCrates!(state,moves,true)))
println(res1,"\n",res2)