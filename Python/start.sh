#!/bin/bash
# start.sh

# 크론 데몬 시작
service cron start

# 로그 파일 생성
touch /app/logs/news_cron.log

# 로그 출력을 위한 tail
tail -f /app/logs/news_cron.log