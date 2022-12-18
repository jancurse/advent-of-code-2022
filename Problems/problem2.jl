function getScore(x,y)
    score = sum(y.=="R") + 2*sum(y.=="P") + 3*sum(y.=="S");
    res = RPS(x,y);
    score += 3*sum(res.==0) + 6*sum(res.==2);
    return score
end

# 0 = tie, 1 = 1st win, 2 = 2nd win
function RPS(x,y)
    firstWin =  (x.=="R" .&& y.=="S") .|| (x.=="S" .&& y.=="P") .|| (x.=="P" .&& y.=="R");
    out = 2 .- firstWin;
    out[x.==y] .= 0;
    return out;
end
    
function transformInput1(x)
    y = copy(x);
    keys = ["A" "R";"B" "P";"C" "S";"X" "R";"Y" "P";"Z" "S"];
    for i = 1:size(keys,1)
        y[y.==keys[i,1]] .= keys[i,2];
    end
    return y
end

function transformInput2(x)
    y = copy(x);
    y[:,1] .= transformInput(y[:,1]);
    y[y[:,2].=="X",2] .= getResponse.(y[y[:,2].=="X",1],"L");
    y[y[:,2].=="Y",2] .= getResponse.(y[y[:,2].=="Y",1],"D");
    y[y[:,2].=="Z",2] .= getResponse.(y[y[:,2].=="Z",1],"W");
    return y;
end

function getResponse(x,result)
    letters = ["R","P","S"];
    ix = indexin([x],letters);
    ix = getindex(ix,1);
    if result=="W"
        ix+=1;
    elseif result=="L"
        ix-=1;
    end
    return letters[mod(ix-1,3)+1]    
end

input = open("./Inputs/input2.txt") do file
    readlines(file);
end
input = split.(input);
input = permutedims(hcat(input...));

# Part 1
input1 = transformInput1(input);
println(getScore(input1[:,1],input1[:,2]))

# Part 2
input2 = transformInput2(input);
println(getScore(input2[:,1],input2[:,2]))