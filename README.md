# PHP8.0 JIT Benchmarks for Async PHP

Set of pure Async PHP http server implementations has been tested with and without JIT enabled in new PHP 8.0 alpha.

There was tested [pure PHP implementation](https://github.com/IvanChepurnyi/jit-php-async/blob/main/bin/amphp-http-server.php) of async framework with regular `stream_select` event loop implementation, no additional PHP extensions to boost non-blocking I/O were used.

There is still planned tests runs for ReactPHP, but still looking for best configuration for it, as it was cutoff much earlier than AMPHP.

## Results 
The test has been performed with [wrk2](https://github.com/giltene/wrk2) load testing tool that was configured to run benchmark in the following request throughput modes:

- `500` open connections and `5k 10k 15k 19k 20k 21k 22k 23k` throughput backpressures.  
- `800` open connections and `10k 15k 20k 21k 22k` throughput backpressures.
- `1000` open connections and `15k 20k 21k 22k` throughput backpressures.

Latency measured in the test is a time since anticipated request till it was [competed by client](https://github.com/giltene/wrk2/issues/81#issuecomment-547471210). It is a good indication how long clients wait till their next request gets processed by the non-blocking application. 
Latency in area of 1ms is not representative of how fast PHP JIT or OpCache, only major latency drift can indicate improvement.          

All async apps run in single threaded mode and attached to the same logical CPU core. Wrk2 was running from separate logical CPU pool.
CPU has been set into performance governor mode and its frequency has been fixed at 3.80 GHz with `./maxout-cpu.sh` script.
Each test run have been increased to 40 seconds from 30 seconds as first 10 seconds of the run is calibration by wrk2.

### Runs

#### 500 open connections

##### 5k Backpressure
Opcache and JIT version in this run are in the margin of the error from each other
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.57ms    1.31ms   7.28ms   82.41%
    Req/Sec   528.29    650.55     5.55k    97.45%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.16ms
 75.000%    1.85ms
 90.000%    3.71ms
 99.000%    5.72ms
 99.900%    6.50ms
 99.990%    6.98ms
 99.999%    7.25ms
100.000%    7.29ms
#[Mean    =        1.569, StdDeviation   =        1.314]
#[Max     =        7.284, Total count    =       148679]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.19ms  733.29us   4.19ms   71.97%
    Req/Sec   526.61    525.32     5.55k    86.98%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.05ms
 75.000%    1.51ms
 90.000%    2.27ms
 99.000%    3.46ms
 99.900%    3.88ms
 99.990%    4.07ms
 99.999%    4.17ms
100.000%    4.19ms
#[Mean    =        1.193, StdDeviation   =        0.733]
#[Max     =        4.188, Total count    =       148695]
```
##### 10k Backpressure
Opcache and JIT version in this run are in the margin of the error from each other

```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.81ms    1.17ms   6.84ms   69.18%
    Req/Sec     1.05k   653.18     5.55k    89.20%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.51ms
 75.000%    2.49ms
 90.000%    3.57ms
 99.000%    5.39ms
 99.900%    5.95ms
 99.990%    6.22ms
 99.999%    6.46ms
100.000%    6.84ms
#[Mean    =        1.811, StdDeviation   =        1.174]
#[Max     =        6.836, Total count    =       297500]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.66ms    1.12ms   6.55ms   77.71%
    Req/Sec     1.05k   668.82     5.55k    87.59%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.41ms
 75.000%    1.99ms
 90.000%    3.37ms
 99.000%    5.23ms
 99.900%    5.57ms
 99.990%    5.96ms
 99.999%    6.20ms
100.000%    6.55ms
#[Mean    =        1.661, StdDeviation   =        1.124]
#[Max     =        6.548, Total count    =       297500]
```
##### 15k Backpressure
Opcache and JIT version in this run are in the margin of the error from each other

```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.98ms    1.28ms   6.29ms   68.61%
    Req/Sec     1.58k   328.15     2.67k    71.22%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.63ms
 75.000%    2.63ms
 90.000%    4.13ms
 99.000%    5.28ms
 99.900%    5.63ms
 99.990%    5.82ms
 99.999%    6.07ms
100.000%    6.29ms
#[Mean    =        1.980, StdDeviation   =        1.276]
#[Max     =        6.288, Total count    =       446217]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.97ms    1.25ms   7.64ms   69.96%
    Req/Sec     1.58k     0.87k    5.55k    84.02%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.73ms
 75.000%    2.69ms
 90.000%    3.78ms
 99.000%    5.57ms
 99.900%    6.36ms
 99.990%    7.11ms
 99.999%    7.58ms
100.000%    7.64ms
#[Mean    =        1.974, StdDeviation   =        1.247]
#[Max     =        7.640, Total count    =       446155]
```
##### 19k Backpressure
Opcache and JIT version in this run are in the margin of the error from each other

```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.58ms    1.79ms  10.34ms   63.57%
    Req/Sec     2.00k   620.47     4.17k    88.81%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.46ms
 75.000%    4.87ms
 90.000%    6.15ms
 99.000%    7.55ms
 99.900%    8.66ms
 99.990%    9.89ms
 99.999%   10.19ms
100.000%   10.35ms
#[Mean    =        3.581, StdDeviation   =        1.786]
#[Max     =       10.344, Total count    =       565224]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.93ms    1.81ms   9.67ms   66.70%
    Req/Sec     1.99k     0.91k    5.55k    86.47%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.59ms
 75.000%    4.00ms
 90.000%    5.66ms
 99.000%    7.78ms
 99.900%    8.46ms
 99.990%    8.84ms
 99.999%    9.38ms
100.000%    9.68ms
#[Mean    =        2.931, StdDeviation   =        1.809]
#[Max     =        9.672, Total count    =       565199]
```
##### 20k Backpressure
Total completed number of requests is within a margin of error from each other for both setups, but Opcache version shows noticeable increase in the latency.
This indicates that http server under opcache starts to be too busy in parsing new HTTP requests.
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    50.51ms   13.68ms  90.50ms   64.00%
    Req/Sec     2.01k    12.26     2.05k    74.35%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%   50.72ms
 75.000%   60.16ms
 90.000%   68.48ms
 99.000%   82.24ms
 99.900%   88.00ms
 99.990%   90.24ms
 99.999%   90.50ms
100.000%   90.56ms
#[Mean    =       50.508, StdDeviation   =       13.683]
#[Max     =       90.496, Total count    =       595147]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.79ms    1.45ms   8.96ms   65.48%
    Req/Sec     2.11k   480.55     4.22k    75.22%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.60ms
 75.000%    3.83ms
 90.000%    4.82ms
 99.000%    6.39ms
 99.900%    7.38ms
 99.990%    8.18ms
 99.999%    8.77ms
100.000%    8.97ms
#[Mean    =        2.785, StdDeviation   =        1.450]
#[Max     =        8.960, Total count    =       594985]
```
##### 21k Backpressure
This run is a breaking point for opcache as it can't cope with processing requests in a timely manner so latency goes through the roof. 
OpCache version did process 596,422 http requests while JIT processed 624,732 within 30 second window without a noticeable drop in latency.  
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.06s   386.29ms   1.92s    58.27%
    Req/Sec     2.01k    10.47     2.05k    86.52%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.05s 
 75.000%    1.39s 
 90.000%    1.61s 
 99.000%    1.74s 
 99.900%    1.76s 
 99.990%    1.87s 
 99.999%    1.91s 
100.000%    1.92s 
#[Mean    =     1061.814, StdDeviation   =      386.286]
#[Max     =     1918.976, Total count    =       596422]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.96ms    1.54ms   9.74ms   70.70%
    Req/Sec     2.21k   582.85     4.17k    87.35%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.68ms
 75.000%    3.86ms
 90.000%    5.17ms
 99.000%    7.22ms
 99.900%    7.94ms
 99.990%    8.61ms
 99.999%    9.10ms
100.000%    9.74ms
#[Mean    =        2.962, StdDeviation   =        1.540]
#[Max     =        9.736, Total count    =       624732]
```
##### 22k Backpressure
This run shows a beginning of a breaking point for JIT http server as 99.9 pct latency increases to 200ms and 90.0 pct at 39ms. Similar to 20k result of opcache but with better latency for 90% of requests served.   

```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.99s   710.77ms   3.71s    57.91%
    Req/Sec     2.02k     7.19     2.04k    74.42%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.00s 
 75.000%    2.61s 
 90.000%    2.96s 
 99.000%    3.17s 
 99.900%    3.49s 
 99.990%    3.65s 
 99.999%    3.70s 
100.000%    3.71s 
#[Mean    =     1990.286, StdDeviation   =      710.766]
#[Max     =     3706.880, Total count    =       600770]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    25.69ms   12.95ms 208.51ms   75.81%
    Req/Sec     2.21k    20.38     2.31k    81.70%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%   25.33ms
 75.000%   32.10ms
 90.000%   39.17ms
 99.000%   48.93ms
 99.900%  151.55ms
 99.990%  203.65ms
 99.999%  208.26ms
100.000%  208.64ms
#[Mean    =       25.690, StdDeviation   =       12.954]
#[Max     =      208.512, Total count    =       654408]
```
#### 800 open connections
##### 10k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.63ms    0.99ms   6.56ms   72.91%
    Req/Sec     1.06k     0.86k    8.89k    90.27%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.43ms
 75.000%    2.07ms
 90.000%    2.99ms
 99.000%    4.83ms
 99.900%    5.72ms
 99.990%    6.28ms
 99.999%    6.51ms
100.000%    6.57ms
#[Mean    =        1.629, StdDeviation   =        0.988]
#[Max     =        6.564, Total count    =       296000]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.18ms    1.89ms  10.55ms   83.32%
    Req/Sec     1.05k     0.88k    7.27k    84.96%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.52ms
 75.000%    2.38ms
 90.000%    5.30ms
 99.000%    8.51ms
 99.900%    9.71ms
 99.990%   10.18ms
 99.999%   10.45ms
100.000%   10.56ms
#[Mean    =        2.179, StdDeviation   =        1.892]
#[Max     =       10.552, Total count    =       296000]
```
##### 15k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.97ms    2.05ms  11.28ms   69.98%
    Req/Sec     1.58k   776.18     6.15k    85.69%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.47ms
 75.000%    4.26ms
 90.000%    5.89ms
 99.000%    8.88ms
 99.900%   10.10ms
 99.990%   10.74ms
 99.999%   11.04ms
100.000%   11.29ms
#[Mean    =        2.975, StdDeviation   =        2.048]
#[Max     =       11.280, Total count    =       443981]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.47ms    2.89ms  13.87ms   75.85%
    Req/Sec     1.58k     0.87k    5.71k    83.23%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.50ms
 75.000%    4.94ms
 90.000%    8.23ms
 99.000%   11.52ms
 99.900%   12.69ms
 99.990%   13.34ms
 99.999%   13.74ms
100.000%   13.88ms
#[Mean    =        3.474, StdDeviation   =        2.888]
#[Max     =       13.872, Total count    =       443970]
```
##### 20k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   603.85ms  241.69ms   1.05s    58.16%
    Req/Sec     1.95k    28.11     2.00k    89.75%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%  606.72ms
 75.000%  811.01ms
 90.000%  936.96ms
 99.000%    1.02s 
 99.900%    1.04s 
 99.990%    1.05s 
 99.999%    1.06s 
100.000%    1.06s 
#[Mean    =      603.848, StdDeviation   =      241.693]
#[Max     =     1054.720, Total count    =       575169]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.61ms    2.06ms  11.99ms   69.06%
    Req/Sec     2.10k     1.05k    5.71k    75.91%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.20ms
 75.000%    4.88ms
 90.000%    6.43ms
 99.000%    9.39ms
 99.900%   11.22ms
 99.990%   11.61ms
 99.999%   11.79ms
100.000%   12.00ms
#[Mean    =        3.607, StdDeviation   =        2.057]
#[Max     =       11.992, Total count    =       591999]
```
##### 21k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.77s   632.60ms   3.62s    58.25%
    Req/Sec     1.95k     5.35     1.98k    87.65%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.77s 
 75.000%    2.31s 
 90.000%    2.64s 
 99.000%    2.84s 
 99.900%    3.28s 
 99.990%    3.52s 
 99.999%    3.60s 
100.000%    3.62s 
#[Mean    =     1770.418, StdDeviation   =      632.597]
#[Max     =     3616.768, Total count    =       575682]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     3.85ms    2.18ms  12.87ms   68.70%
    Req/Sec     2.20k     0.96k    5.33k    76.85%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.54ms
 75.000%    5.03ms
 90.000%    6.88ms
 99.000%   10.03ms
 99.900%   11.74ms
 99.990%   12.41ms
 99.999%   12.74ms
100.000%   12.88ms
#[Mean    =        3.847, StdDeviation   =        2.177]
#[Max     =       12.872, Total count    =       621588]
```
##### 22k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.82s     1.13s    7.17s    61.46%
    Req/Sec     1.94k     7.44     1.97k    76.13%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.81s 
 75.000%    3.72s 
 90.000%    4.24s 
 99.000%    5.76s 
 99.900%    6.74s 
 99.990%    7.05s 
 99.999%    7.14s 
100.000%    7.18s 
#[Mean    =     2824.892, StdDeviation   =     1126.944]
#[Max     =     7172.096, Total count    =       572972]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     7.12ms    3.04ms  18.29ms   65.70%
    Req/Sec     2.25k   586.69     4.00k    90.49%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    6.97ms
 75.000%    9.17ms
 90.000%   11.25ms
 99.000%   14.69ms
 99.900%   16.35ms
 99.990%   17.18ms
 99.999%   17.90ms
100.000%   18.30ms
#[Mean    =        7.123, StdDeviation   =        3.039]
#[Max     =       18.288, Total count    =       651149]
```
#### 1000 open connections

##### 15k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.95ms    4.12ms  20.46ms   73.47%
    Req/Sec     1.54k   763.86     4.76k    82.70%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    3.70ms
 75.000%    7.48ms
 90.000%   11.37ms
 99.000%   16.20ms
 99.900%   18.32ms
 99.990%   19.22ms
 99.999%   20.06ms
100.000%   20.48ms
#[Mean    =        4.955, StdDeviation   =        4.118]
#[Max     =       20.464, Total count    =       442351]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     4.00ms    3.58ms  17.94ms   79.61%
    Req/Sec     1.55k     1.04k    7.69k    84.13%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    2.54ms
 75.000%    5.94ms
 90.000%    9.88ms
 99.000%   13.95ms
 99.900%   15.81ms
 99.990%   17.22ms
 99.999%   17.87ms
100.000%   17.95ms
#[Mean    =        4.001, StdDeviation   =        3.580]
#[Max     =       17.936, Total count    =       442388]
```
##### 20k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    98.18ms   23.98ms 160.51ms   59.74%
    Req/Sec     2.00k    64.10     2.28k    91.61%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%   99.33ms
 75.000%  118.46ms
 90.000%  129.02ms
 99.000%  144.51ms
 99.900%  154.11ms
 99.990%  159.10ms
 99.999%  160.26ms
100.000%  160.64ms
#[Mean    =       98.178, StdDeviation   =       23.977]
#[Max     =      160.512, Total count    =       589366]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     7.19ms    4.00ms  23.22ms   66.09%
    Req/Sec     2.05k   838.09     4.35k    83.78%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    6.95ms
 75.000%    9.88ms
 90.000%   12.57ms
 99.000%   17.53ms
 99.900%   20.77ms
 99.990%   22.32ms
 99.999%   23.01ms
100.000%   23.23ms
#[Mean    =        7.195, StdDeviation   =        3.999]
#[Max     =       23.216, Total count    =       590000]
```
##### 21k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.38s   568.69ms   4.57s    67.31%
    Req/Sec     1.98k     7.49     2.00k    70.96%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.35s 
 75.000%    1.78s 
 90.000%    2.02s 
 99.000%    3.35s 
 99.900%    4.20s 
 99.990%    4.47s 
 99.999%    4.55s 
100.000%    4.57s 
#[Mean    =     1380.486, StdDeviation   =      568.691]
#[Max     =     4567.040, Total count    =       585319]

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     7.42ms    3.46ms  19.36ms   67.40%
    Req/Sec     2.18k     1.15k    9.09k    88.94%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    7.14ms
 75.000%    9.55ms
 90.000%   12.25ms
 99.000%   16.21ms
 99.900%   17.89ms
 99.990%   18.67ms
 99.999%   19.07ms
100.000%   19.38ms
#[Mean    =        7.416, StdDeviation   =        3.459]
#[Max     =       19.360, Total count    =       619416]
```
##### 22k Backpressure
```

opcache-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.88s   912.59ms   6.72s    76.69%
    Req/Sec     2.03k     7.07     2.05k    76.76%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%    1.79s 
 75.000%    2.39s 
 90.000%    2.74s 
 99.000%    5.32s 
 99.900%    6.30s 
 99.990%    6.60s 
 99.999%    6.70s 
100.000%    6.73s 
#[Mean    =     1875.113, StdDeviation   =      912.589]
#[Max     =     6721.536, Total count    =       599450]
  Socket errors: connect 0, read 0, write 0, timeout 12

jit-amphp
=============================================

  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    46.18ms   17.85ms  85.95ms   59.94%
    Req/Sec     2.21k   122.99     2.42k    78.85%
  Latency Distribution (HdrHistogram - Recorded Latency)
 50.000%   46.27ms
 75.000%   62.01ms
 90.000%   69.38ms
 99.000%   78.85ms
 99.900%   84.10ms
 99.990%   85.57ms
 99.999%   85.89ms
100.000%   86.01ms
#[Mean    =       46.184, StdDeviation   =       17.852]
#[Max     =       85.952, Total count    =       648932]
```


## System Info

Linux Distro
```
Linux 5.6.16-1-MANJARO #1 SMP PREEMPT x86_64 GNU/Linux
```

CPU Setup
```
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   43 bits physical, 48 bits virtual
CPU(s):                          12
On-line CPU(s) list:             0-11
Thread(s) per core:              1
Core(s) per socket:              12
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       AuthenticAMD
CPU family:                      23
Model:                           113
Model name:                      AMD Ryzen 9 3900X 12-Core Processor
```  
