# create new namespaces
ip netns add node1_net
ip netns add node2_net
ip netns add node3_net
ip netns add node4_net
ip netns add router_net

# create bridges
ip link add br1 type bridge
ip link add br2 type bridge

# create veth interfaces
ip link add veth1 type veth peer name br1-veth1 # node1-br1
ip link add veth2 type veth peer name br1-veth2 # node2-br1
ip link add veth3 type veth peer name br1-veth3 # router-br1
ip link add veth4 type veth peer name br2-veth1 # node3-br2
ip link add veth5 type veth peer name br2-veth2 # node4-br2
ip link add veth6 type veth peer name br2-veth3 # router-br2

# set namespaces of each interface
ip link set veth1 netns node1_net
ip link set veth2 netns node2_net
ip link set veth3 netns router_net
ip link set veth4 netns node3_net
ip link set veth5 netns node4_net
ip link set veth6 netns router_net

# set master of bridge veths
ip link set br1-veth1 master br1
ip link set br1-veth2 master br1
ip link set br1-veth3 master br1
ip link set br2-veth1 master br2
ip link set br2-veth2 master br2
ip link set br2-veth3 master br2

# assign ip address to interfaces
ip netns exec node1_net ip addr add 172.0.0.2/24 dev veth1
ip netns exec node2_net ip addr add 172.0.0.3/24 dev veth2
ip netns exec router_net ip addr add 172.0.0.1/24 dev veth3
ip netns exec node3_net ip addr add 10.10.0.2/24 dev veth4
ip netns exec node4_net ip addr add 10.10.0.3/24 dev veth5
ip netns exec router_net ip addr add 10.10.0.1/24 dev veth6

# set bridges up
ip link set br1 up
ip link set br2 up

# set the veths up
ip link set br1-veth1 up
ip link set br1-veth2 up
ip link set br1-veth3 up
ip link set br2-veth1 up
ip link set br2-veth2 up
ip link set br2-veth3 up
ip netns exec node1_net ip link set veth1 up
ip netns exec node2_net ip link set veth2 up
ip netns exec router_net ip link set veth3 up
ip netns exec node3_net ip link set veth4 up
ip netns exec node4_net ip link set veth5 up
ip netns exec router_net ip link set veth6 up

# add gateway to nodes
ip netns exec node1_net ip route add default via 172.0.0.1
ip netns exec node2_net ip route add default via 172.0.0.1
ip netns exec node3_net ip route add default via 10.10.0.1
ip netns exec node4_net ip route add default via 10.10.0.1

