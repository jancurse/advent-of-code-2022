function maxSupply(supplies,k)
    return sum(maxk(sum.(supplies),k));
end

function maxk(l,k)
    out = [];
    for i = 1:k
        max,iMax = findmax(l);
        push!(out,max);
        deleteat!(l,iMax);
    end
    return out
end

input = open("./Inputs/input1.txt") do file
    allElfs = [];
    thisElf = [];
    for l in eachline(file)
        if l==""
            push!(allElfs,thisElf);
            thisElf = [];
        else
            push!(thisElf,parse(Int64,l));
        end
    end
    return allElfs;
end

println(maxSupply(input,1))
println(maxSupply(input,3))