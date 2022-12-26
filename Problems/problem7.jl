include("../Utilities/Tree.jl")
using Printf

T = open("./Inputs/input7.txt") do file
    T = Tree();
    T.nodes[1].type = "dir";
    current = T.nodes[1];
    for line = readlines(file);
        if startswith(line,"\$ cd")
            folder = replace(line,"\$ cd "=>"");
            if folder=="/"
                current = T.nodes[1];
            elseif folder==".."
                current = current.parent;
            else
                id = only([x.id for x in current.children if (x.name==folder) && (x.type=="dir")]);
                current = T.nodes[id];
            end
        elseif startswith(line,"\$")
            # nothing to do
        elseif startswith(line,"dir")
            new = replace(line,"dir "=>"");
            addNode!(T,Node(new,parent=current,type="dir"));
        else
            (size,name) = split(line); size = parse(Int,size);
            addNode!(T,Node(name,parent=current,value=size,type="file"));
        end
    end
    return T;
end

getTreeValue!(T.nodes[1]);
@printf("Part1: %d\nPart 2: %d",sum(x.value for x in values(T.nodes) if (x.type=="dir") && (x.value<=100000)),
                                minimum(x.value for x in values(T.nodes) if (T.nodes[1].value-x.value)<=40e6));