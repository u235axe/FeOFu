Observation: the amount of useful work (arithmetic ops) performed is constant.
What is variable is the inefficiencies (stalls, etc.) relative to the theoretical "ideal execution" where all resources are perfectly utilized.

## Inefficiencies

 - Not enough global memory bandwidth -> stall
 - Not enough local memory bandwidth -> stall
 - Bad global memory access pattern -> accesses serialized
 - Bad local memory access pattern ("bank conflict") -> accesses serialized
 - Divergence: inherent cost
 - Divergence: some threads are masked out and perform no useful work
 - Synchronization: some workgroups block waiting for others
 - Too many threads or workgroups -> competition for resources (registers, local memory), only some of them get to run a time
   - What about "individual threads or workgroups use too many registers or too much local memory"?
 - Not enough workgroups -> fails to mask global memory latency -> stall (rule of thumb: 4x overissue)
 - What about: Loop unrolling? Memory controller state, some operations from previous loop iteration still in flight during the next one, ...?
 - Anything else?
