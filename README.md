### Objective
Validate scalability, stability, and responsiveness of HTTPBin API under different load conditions using Apache JMeter.

### Tool selection
JMeter — open-source, scriptable, plugin-rich, and easy to integrate with CI/CD pipelines.

### API Used
http://localhost:8080 (HTTPBin via Docker)

### Test Scenarios
| **Test Type**  | **Description**                        | **Users**      | **Duration**|
|----------------|----------------------------------------|----------------|---------------|
| Load           | Sustained traffic at expected volume   | 100            | 5 min         |
| Stress         | Gradual increase until failure point   | 100–1000       | Variable      |
| Spike          | Sudden surge and recovery              | 10 → 300 → 10  | 2 min         |
| Endurance      | Stability over long duration           | 50             | 60 min        |

### Thresholds
Avg response time < 2s

Error rate < 1%

95th percentile < 3s

Results
Load Test: Avg 620ms, Throughput 65 req/s

Stress Test: Degradation beyond 700 users

Spike Test: Stable recovery post spike

Endurance Test: No memory leak observed after 1 hour

### How to Run
> docker run -p 8080:80 kennethreitz/httpbin

> jmeter -n -t HTTPBin_Performance_Tests.jmx -l results.jtl -e -o Reports/
