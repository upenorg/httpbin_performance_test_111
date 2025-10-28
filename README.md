# HTTPBin Performance Test — Complete Solution

This repo contains a performance testing framework for the HTTPBin API (local Docker instance), including JMeter test plans, scripts for running Load/Stress/Spike/Soak scenarios, reporting, and a GitHub Actions pipeline for running smoke performance tests on every push.

## Contents
- `jmeter/`
  - `httpbin_test_plan.jmx` — main JMeter test plan with parameterization and assertions
  - `users.csv` — (optional) user data or variable CSV for parameterization
  - `env.properties` — environment-specific values (base URL, thread counts, durations)
  - `run_jmeter.sh` — helper script to run JMeter in non-GUI mode and generate HTML report
- `.github/workflows/`
  - `performance-smoke.yml` — GitHub Actions pipeline to run a smoke performance test and upload report
- `docker/`
  - `docker-compose.yml` — starts httpbin locally via official image for testing
- `reports/` — generated JMeter HTML reports (gitignored)
- `README.md` — this file

---

## Quick start (local)

### Prerequisites
- Java 8+ (for JMeter)
- Apache JMeter (recommended 5.5+)
- Docker & docker-compose
- Git
- (Optional) curl, unzip

### 1) Start the HTTPBin API locally
We use the official httpbin Docker image.

```bash
# from repo root
cd docker
docker-compose up -d
# confirm it's up:
curl http://localhost:8000/get
```


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
