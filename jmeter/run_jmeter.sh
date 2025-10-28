#!/usr/bin/env bash
set -e
JMETER_HOME=${JMETER_HOME:-/opt/apache-jmeter-5.5}
TEST_PLAN=jmeter/httpbin_test_plan.jmx
OUT_DIR=reports/$(date +%Y%m%d_%H%M%S)
mkdir -p ${OUT_DIR}

# you can pass properties via -J
$JMETER_HOME/bin/jmeter \
  -n -t ${TEST_PLAN} \
  -l ${OUT_DIR}/results.jtl \
  -e -o ${OUT_DIR}/report \
  -Jbase_url=${BASE_URL:-http://localhost:8000} \
  -Jthreads=${THREADS:-50} \
  -Jrampup=${RAMP_UP:-30} \
  -Jduration=${DURATION:-300}
