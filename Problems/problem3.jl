# Common
function getPriority(l) # Returns the priority of the unique common item
    dup = only(intersect(l...));
    return char2Num(dup);
end

function char2Num(c::Char) # Returns the priotity of a single character
    return 1+Int(c)-ifelse(islowercase(c),Int('a'),Int('A')-26);
end

# Part 1
function splitBackpack(contents)
    n = div(length(contents),2);
    [contents[1:n],contents[n+1:end]];
end

priority = open("./Inputs/input3.txt") do file
    pri = sum(getPriority(splitBackpack(l)) for l in readlines(file));
    return pri;
end
println(priority);

# Part 2
priority = open("./Inputs/input3.txt") do file
    pri = 0; i = 0; backpacks = [];
    for line in readlines(file)
        push!(backpacks,line);
        i+=1;
        if mod(i,3)==0
            pri+=getPriority(backpacks);
            backpacks = [];
        end
    end
    return pri;
end
println(priority);
