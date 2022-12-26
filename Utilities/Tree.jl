mutable struct Node
    id::Int
    name::String
    parent::Node
    children::Vector{Node}
    value::Float64
    type::String
    function Node(name;id=0,parent=nothing,children=[],value=NaN,type="")
        node          = new();
        node.id       = id;
        node.name     = name;
        node.children = children;
        node.value    = value; 
        node.type     = type;
        if ~isnothing(parent)
            node.parent = parent;
        end
        return node;
    end
end

mutable struct Tree
    nodes::Dict
    maxId::Int
    function Tree()
        tree = new();
        tree.nodes = Dict(1=>Node("root",id=1));
        tree.maxId = 1;
        return tree;
    end
end

function addNode!(tree::Tree,node::Node)
    if node.id==0;
        node.id = tree.maxId+1;
    end
    @assert ~haskey(tree.nodes,node.id) ("Id "*node.id*" already exists in tree")
    tree.nodes[node.id] = node;
    tree.maxId = max(tree.maxId,node.id);
    if haskey(tree.nodes,node.parent.id)
        push!(tree.nodes[node.parent.id].children,node);
    end
end

function getTreeValue!(node)
    if isnan(node.value)
        node.value = sum([getTreeValue!(x) for x in node.children]);
    end
    return node.value;
end

function printTree(T)
    for node in values(T.nodes)
        printNode(node);
    end
end

printNode(node) = println("Id: ",node.id, ", name: ",node.name,", type: ",node.type, ", value: ",node.value, ", children: ",join([x.id for x in node.children]," "));

# T = Tree();
# node = Node("a",parent=T.nodes[1],value=13);
# addNode!(T,node);
# node = Node("b",parent=T.nodes[1],value=13);
# addNode!(T,node);
# getTreeValue!(T.nodes[1]);
# 
# printTree(T)