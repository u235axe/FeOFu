Observation: the amount of useful work (arithmetic ops) performed is constant.
What is variable is the inefficiencies (stalls, etc.) relative to the theoretical "ideal execution" where all resources are perfectly utilized.

## Inefficiencies

 - Not enough global memory bandwidth -> stall
 - Not enough local memory bandwidth -> stall
 - Bad global memory access pattern -> accesses serialized
 - Bad local memory access pattern ("bank conflict") -> accesses serialized
 - Divergence: inherent cost
 - Divergence: some threads are masked out and perform no useful work
 - Synchronization: some threads block waiting for others
 - Too many threads or workgroups -> competition for resources (registers, local memory), only some of them get to run at a time
   - What about "individual threads or workgroups use too many registers or too much local memory"?
 - Not enough workgroups -> fails to mask global memory latency -> stall (rule of thumb: 4x overissue)
 - What about: Loop unrolling? Memory controller state
  Some memory operations from previous loop iteration still in flight during the next one and affect latency masking.
 - Anything else?


Bank conflict video:
https://www.youtube.com/watch?v=CZgM3DEBplE

Additional resources on costs:
http://on-demand.gputechconf.com/gtc/2016/presentation/s6382-karthik-ravi-Perf-considerations-for-OpenCL.pdf (also the references on page 7)

Information on the most recent limitations and development directions, see e.g. in CUDA:
https://docs.nvidia.com/cuda/volta-tuning-guide/index.html#volta-tuning

Similar for AMD, see especially section 2.4 for bandwidth and 2.6 on latency hiding:
https://rocm-documentation.readthedocs.io/en/latest/Programming_Guides/Opencl-optimization.html
