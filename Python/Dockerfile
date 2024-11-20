# python/Dockerfile
FROM python:3.11-slim

# 작업 디렉토리 설정
WORKDIR /app

# 시스템 패키지 및 cron 설치 & Oracle Instant Client 설치
RUN apt-get update && apt-get install -y libaio1 wget unzip cron \
    && wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
    && unzip instantclient-basiclite-linuxx64.zip \
    && rm -f instantclient-basiclite-linuxx64.zip \
    && cd instantclient* \
    && mv * /usr/lib \
    && cd .. \
    && rm -rf instantclient* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 환경 변수 설정
ENV LD_LIBRARY_PATH=/usr/lib
ENV PATH=$PATH:/usr/lib

# Python 패키지 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 애플리케이션 코드 복사
COPY . .

# 크론탭 설정
COPY news-cron /etc/cron.d/news-cron
RUN chmod 0644 /etc/cron.d/news-cron
RUN crontab /etc/cron.d/news-cron

# 시작 스크립트
COPY start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]