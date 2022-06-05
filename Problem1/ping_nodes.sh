node_ip="" # ip of second node
namespace="" # namespace of first node

# find namespace of first node
if [ "$1" == "node1" ]; then
    namespace="node1_net"
elif [ "$1" == "node2" ]; then
    namespace="node2_net"
elif [ "$1" == "node3" ]; then
    namespace="node3_net"
elif [ "$1" == "node4" ]; then
    namespace="node4_net"
else [ "$1" == "router" ]
    namespace="router_net"
fi

# find ip of second node
if [ "$2" == "node1" ]; then
    node_ip="172.0.0.2"
elif [ "$2" == "node2" ]; then
    node_ip="172.0.0.3"
elif [ "$2" == "node3" ]; then
    node_ip="10.10.0.2"
elif [ "$2" == "node4" ]; then
    node_ip="10.10.0.3"
else [ "$2" == "router" ]
    node_ip="172.0.0.1"
fi

# start pinging
ip netns exec $namespace ping $node_ip