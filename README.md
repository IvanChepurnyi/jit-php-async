# PHP8.0 JIT Benchmarks for Async PHP

Set of pure Async PHP http server implementations has been tested with and without JIT enabled in new PHP 8.0 alpha.

There were tested 2 pure PHP implementations of async frameworks with standart `stream_select` event loop implementation, no additional PHP extensions to boost non-blocking I/O were used.
 

## Results 
The test has been performed with [wrk2](https://github.com/giltene/wrk2) load testing tool that was configured to run benchmark in the following request throughput modes from 500 open tcp connections:
- 1,000 req/s  
- 5,000 req/s
- 10,000 req/s
- 15,000 req/s 
- 17,000 req/s
- 18,000 req/s
- 20,000 req/s 
- 21,000 req/s
- 22,000 req/s 

Latency measured in the test is a time since anticipated request till it was [competed by client](https://github.com/giltene/wrk2/issues/81#issuecomment-547471210). It is a good indication how long clients wait till their next request gets processed by the non-blocking application. 
Latency accuracy is +/- 1ms due to wrk2 thread sync and sleep operations on OS level.   

All async apps run in single threaded mode and attached to the same logical CPU core. Wrk2 was running from separate logical CPU pool.

CPU has been set into performance governor mode and its frequency has been fixed at 3.80 GHz with `./maxout-cpu.sh` script.

### Summary

Latency diff of <5ms are not compared due to wrk2 limitations described earlier.
  
AMPHP numbers are the following:
- 1k backpressure - JIT and opcache are processing requests faster than different can be reported by tool
- 5k backpressure - JIT and opcache are processing requests faster than different can be reported by tool
- 10k backpressure - JIT and opcache are processing requests faster than different can be reported by tool
- 15k backpressure - Opcache 90pct increases for more than 5ms comparing to previous run


### Latency Distribution per run
```
======================
Results for opcache-amphp: 
======================


1k Backpressure (opcache-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.35ms    0.91ms   4.89ms   71.15%
    Req/Sec    87.06    231.45     4.55k    94.16%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.10ms
 75.000%    1.79ms
 90.000%    2.77ms
 99.000%    3.97ms
 99.900%    4.37ms
 99.990%    4.71ms
 99.999%    4.89ms
100.000%    4.89ms

5k Backpressure (opcache-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.62ms    1.06ms   5.88ms   68.90%
    Req/Sec   438.50    575.77     4.55k    96.57%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.31ms
 75.000%    2.30ms
 90.000%    3.23ms
 99.000%    4.51ms
 99.900%    5.05ms
 99.990%    5.38ms
 99.999%    5.81ms
100.000%    5.88ms

10k Backpressure (opcache-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.08ms    1.32ms   8.46ms   67.03%
    Req/Sec     0.88k   784.86     4.55k    76.74%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.78ms
 75.000%    3.07ms
 90.000%    3.87ms
 99.000%    5.59ms
 99.900%    6.24ms
 99.990%    6.88ms
 99.999%    8.26ms
100.000%    8.47ms

15k Backpressure (opcache-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.97ms    2.70ms  13.90ms   59.95%
    Req/Sec     1.30k   384.59     2.25k    73.00%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.64ms
 75.000%    5.91ms
 90.000%    7.96ms
 99.000%   10.13ms
 99.900%   11.07ms
 99.990%   11.84ms
 99.999%   12.83ms
100.000%   13.91ms

17k Backpressure (opcache-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.38ms    2.34ms  14.18ms   62.58%
    Req/Sec     1.45k   280.87     2.17k    64.83%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    4.24ms
 75.000%    6.01ms
 90.000%    7.68ms
 99.000%    9.66ms
 99.900%   10.61ms
 99.990%   12.09ms
 99.999%   13.65ms
100.000%   14.18ms

18k Backpressure (opcache-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.75ms    2.70ms  13.51ms   62.63%
    Req/Sec     1.55k   282.02     2.31k    75.03%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    4.36ms
 75.000%    6.61ms
 90.000%    8.91ms
 99.000%   10.56ms
 99.900%   11.84ms
 99.990%   12.69ms
 99.999%   13.23ms
100.000%   13.52ms

20k Backpressure (opcache-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   960.52ms  431.00ms   2.67s    62.85%
    Req/Sec     1.62k    14.13     1.67k    89.20%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%  968.70ms
 75.000%    1.29s 
 90.000%    1.48s 
 99.000%    2.19s 
 99.900%    2.51s 
 99.990%    2.63s 
 99.999%    2.66s 
100.000%    2.67s 

======================
Results for jit-amphp: 
======================


1k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.30ms    0.89ms   4.76ms   72.79%
    Req/Sec    87.06    170.93     1.55k    92.90%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.06ms
 75.000%    1.66ms
 90.000%    2.69ms
 99.000%    4.00ms
 99.900%    4.37ms
 99.990%    4.70ms
 99.999%    4.76ms
100.000%    4.76ms

5k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.98ms    1.48ms   7.65ms   72.76%
    Req/Sec   439.14    404.43     2.33k    75.51%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.47ms
 75.000%    2.84ms
 90.000%    4.24ms
 99.000%    6.01ms
 99.900%    6.66ms
 99.990%    7.09ms
 99.999%    7.46ms
100.000%    7.65ms

10k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.25ms  662.99us   4.64ms   68.19%
    Req/Sec     0.88k   578.76     4.55k    84.65%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.14ms
 75.000%    1.63ms
 90.000%    2.22ms
 99.000%    3.10ms
 99.900%    3.54ms
 99.990%    3.91ms
 99.999%    4.31ms
100.000%    4.64ms

15k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.49ms    1.48ms   8.97ms   64.35%
    Req/Sec     1.32k   728.57     4.55k    75.33%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.21ms
 75.000%    3.53ms
 90.000%    4.74ms
 99.000%    6.03ms
 99.900%    7.06ms
 99.990%    7.90ms
 99.999%    8.29ms
100.000%    8.98ms

17k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.94ms    2.55ms  14.56ms   61.63%
    Req/Sec     1.47k   707.34     4.55k    88.39%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.60ms
 75.000%    5.71ms
 90.000%    7.61ms
 99.000%   10.27ms
 99.900%   11.02ms
 99.990%   11.59ms
 99.999%   12.87ms
100.000%   14.57ms

18k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.01ms    2.17ms  12.16ms   63.09%
    Req/Sec     1.56k   709.03     4.55k    87.77%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.87ms
 75.000%    5.59ms
 90.000%    6.88ms
 99.000%    9.43ms
 99.900%   10.61ms
 99.990%   11.45ms
 99.999%   11.86ms
100.000%   12.17ms

20k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.53ms    2.56ms  12.69ms   67.00%
    Req/Sec     1.70k   142.70     3.28k    80.92%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    4.27ms
 75.000%    6.08ms
 90.000%    7.99ms
 99.000%   11.16ms
 99.900%   11.77ms
 99.990%   12.17ms
 99.999%   12.45ms
100.000%   12.69ms

21k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     7.29ms    2.80ms  19.47ms   68.40%
    Req/Sec     1.76k    42.15     1.93k    72.64%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    7.14ms
 75.000%    9.07ms
 90.000%   11.07ms
 99.000%   14.30ms
 99.900%   16.70ms
 99.990%   17.98ms
 99.999%   18.66ms
100.000%   19.49ms

22k Backpressure (jit-amphp)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.77s   710.42ms   4.40s    66.17%
    Req/Sec     1.76k    26.49     1.87k    90.38%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.81s 
 75.000%    2.25s 
 90.000%    2.59s 
 99.000%    3.72s 
 99.900%    4.20s 
 99.990%    4.35s 
 99.999%    4.40s 
100.000%    4.41s 

======================
Results for opcache-react: 
======================


1k Backpressure (opcache-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.22ms    1.42ms   5.68ms   61.21%
    Req/Sec    87.87    253.57     4.55k    94.12%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.76ms
 75.000%    3.50ms
 90.000%    4.32ms
 99.000%    5.20ms
 99.900%    5.49ms
 99.990%    5.62ms
 99.999%    5.68ms
100.000%    5.68ms

5k Backpressure (opcache-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.12ms    1.77ms   7.43ms   57.82%
    Req/Sec   437.71    611.92     4.55k    84.92%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.22ms
 75.000%    4.49ms
 90.000%    5.60ms
 99.000%    6.60ms
 99.900%    6.95ms
 99.990%    7.16ms
 99.999%    7.42ms
100.000%    7.43ms

10k Backpressure (opcache-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     5.28ms    3.87ms  12.68ms   49.86%
    Req/Sec     0.85k   420.53     2.16k    79.23%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.38ms
 75.000%    9.39ms
 90.000%   10.41ms
 99.000%   11.05ms
 99.900%   11.45ms
 99.990%   11.81ms
 99.999%   12.63ms
100.000%   12.69ms

15k Backpressure (opcache-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     5.83s     2.39s    9.99s    57.56%
    Req/Sec     1.04k     2.87     1.05k    90.62%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    5.83s 
 75.000%    7.91s 
 90.000%    9.13s 
 99.000%    9.87s 
 99.900%    9.95s 
 99.990%    9.96s 
 99.999%    9.98s 
100.000%    9.99s 

======================
Results for jit-react: 
======================


1k Backpressure (jit-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.56ms    1.74ms   7.09ms   64.82%
    Req/Sec    87.47    262.80     4.55k    94.16%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.28ms
 75.000%    3.45ms
 90.000%    5.40ms
 99.000%    6.49ms
 99.900%    6.81ms
 99.990%    6.95ms
 99.999%    7.09ms
100.000%    7.09ms

5k Backpressure (jit-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.57ms    0.86ms   4.31ms   64.55%
    Req/Sec   439.77    217.47     1.11k    63.02%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.33ms
 75.000%    2.19ms
 90.000%    2.94ms
 99.000%    3.56ms
 99.900%    3.86ms
 99.990%    4.03ms
 99.999%    4.28ms
100.000%    4.32ms

10k Backpressure (jit-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.52ms    2.00ms   8.96ms   56.06%
    Req/Sec     0.87k   577.18     2.50k    57.37%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.54ms
 75.000%    4.99ms
 90.000%    6.43ms
 99.000%    7.30ms
 99.900%    7.86ms
 99.990%    8.34ms
 99.999%    8.57ms
100.000%    8.97ms

15k Backpressure (jit-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     8.04s     3.26s   13.70s    57.65%
    Req/Sec     0.97k     1.51     0.97k    81.82%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    8.03s 
 75.000%   10.86s 
 90.000%   12.56s 
 99.000%   13.57s 
 99.900%   13.67s 
 99.990%   13.70s 
 99.999%   13.71s 
100.000%   13.71s 

17k Backpressure (jit-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    10.68s     4.38s   18.28s    57.74%
    Req/Sec     0.98k     2.98     0.99k    86.46%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%   10.70s 
 75.000%   14.47s 
 90.000%   16.76s 
 99.000%   18.14s 
 99.900%   18.27s 
 99.990%   18.28s 
 99.999%   18.30s 
100.000%   18.30s 

18k Backpressure (jit-react)
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     7.75s     2.44s   12.03s    57.62%
    Req/Sec     0.97k     2.04     0.97k    91.89%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    7.77s 
 75.000%    9.88s 
 90.000%   11.12s 
 99.000%   11.89s 
 99.900%   11.98s 
 99.990%   12.03s 
 99.999%   12.03s 
100.000%   12.04s
```

## System Info

Linux Distro
```
Linux 5.6.16-1-MANJARO #1 SMP PREEMPT x86_64 GNU/Linux
```
CPU
```
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   43 bits physical, 48 bits virtual
CPU(s):                          24
On-line CPU(s) list:             0-23
Thread(s) per core:              2
Core(s) per socket:              12
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       AuthenticAMD
CPU family:                      23
Model:                           113
Model name:                      AMD Ryzen 9 3900X 12-Core Processor
```  
