export CVMRDMA_REMOTE_ADDR="192.4.0.3:3456" CVMRDMA_BIND_ADDR="*:3456"

modprobe ib_umad
modprobe mlx5_ib