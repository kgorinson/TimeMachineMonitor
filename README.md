# TimeMachineMonitor
A Mac OS X Time Machine monitoring script. Running this shell script will let you monitor your Time Machine backup in real-time.


usage: 
```
./tmpct.sh <sleep time in seconds> KB|MB
```

Output:
```
Total number of iterations is 1 and the time between is 5 seconds.
The new percentage is 7.02996% 
The difference is 0.00201% 
Average Difference: 0.00201% 
New MBs transferred:  5 MB
Total MBs transferred:  19282 MB
Avg MB transferred b/w runs: 5 MB 
-----------------

Total number of iterations is 2 and the time between is 5 seconds.
The new percentage is 7.03368% 
The difference is 0.00372% 
Average Difference: 0.002865% 
New MBs transferred:  10 MB
Total MBs transferred:  19292 MB
Avg MB transferred b/w runs: 7.5 MB 
-----------------

```

It's not perfect, but it gets the job done and can be useful.
