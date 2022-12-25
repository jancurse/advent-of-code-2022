isUnique(x) = length(unique(x))==length(x);

function firstUniqueEnd(x,k)
    idx = k;
    while true
        if isUnique(x[idx-k+1:idx])
            break;
        else
            idx+=1;
        end
    end
    return idx
end

res1 = open("./Inputs/input6.txt") do file
    s = read(file);
    println(firstUniqueEnd(s,4));
    println(firstUniqueEnd(s,14));
end
