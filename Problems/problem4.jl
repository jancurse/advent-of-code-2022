isSubset(a,b)   = (a[1]>=b[1]) && (a[2]<=b[2]);
isDisjoint(a,b) = (a[2]<b[1]) || (a[1]>b[2]);
parseLine(l)    = [parse.(Int64,x) for x in split.(split(l,","),"-")];

function main(file)
    count1 = 0; count2 = 0;
    for line = readlines(file)
        x = parseLine(line);
        count1 += isSubset(x[1],x[2]) || isSubset(x[2],x[1]);
        count2 += ~isDisjoint(x[1],x[2]);
    end
    return count1,count2;
end

main(open("./Inputs/input4.txt"))