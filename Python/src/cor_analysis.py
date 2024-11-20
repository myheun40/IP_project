import oracledb
import requests
import time
from datetime import datetime
import os
import logging

# 로깅 설정
log_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'logs')
os.makedirs(log_dir, exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(os.path.join(log_dir, f'news_collection_{datetime.now().strftime("%Y%m%d")}.log')),
        logging.StreamHandler()
    ]
)

# 오라클 DB 연결 설정
def connect_to_db():
    try:
        # 오라클 데이터베이스 연결 (호스트, 사용자, 비밀번호, SID 또는 서비스 이름)
        oracledb.init_oracle_client(lib_dir=r"C:\Users\USER\Oracle\instantclient_19_24")
        # DSN 설정: 호스트 주소, 포트, 서비스 이름
        dsn = oracledb.makedsn("project-db-stu3.smhrd.com", "1524", sid="xe")
        conn = oracledb.connect(user='Insa5_SpringA_final_1', password='aischool1', dsn=dsn)
        cursor = conn.cursor()
        logging.info("DB 연결 성공")
        # print("DB 연결 성공")
        return conn, cursor
    except oracledb.DatabaseError as e:
        logging.error(f"DB 연결 실패: {e}")
        # print(f"DB 연결 실패: {e}")
        return None, None


def get_news(query):
    # 뉴스 API 키
    try:
        with open(r"/Python/api_key.txt", "r") as f:
            api_key = f.read().strip()
    except FileNotFoundError:
        logging.error("API 키 파일을 찾을 수 없습니다.")
        return []

    # 검색할 키워드 query = "기업명"
    # NewsAPI 엔드포인트 (한국어로 설정) url
    query= query.replace('(주)', '')  # (주) 제거하고 뉴스 검색
    url = f"https://newsapi.org/v2/everything?q={query}&language=ko&pageSize=10&apiKey={api_key}"

    # API url 요청 보내기

    try:
        response = requests.get(url)
        news_data = response.json()

        if response.status_code != 200:
            logging.error(f"API 호출 실패: {news_data.get('message', '알 수 없는 오류')}")
            return []

        # 뉴스 데이터 처리
        articles = []
        if news_data.get("articles"):
            for article in news_data['articles']:
                articles.append({
                    'title': article['title'],
                    'description': article['description'].strip(),
                    "date": article['publishedAt'][:10],
                    'url': article['url'],
                    'image_url': article['urlToImage']
                })
        return articles
    except Exception as e:
        logging.error(f"뉴스 데이터 수집 중 오류 발생: {e}")
        return []


# 뉴스 데이터를 DB에 삽입하는 함수
def insert_news_into_db(conn, cursor, articles, company_idx):
    try:
        # 기존 뉴스 삭제
        cursor.execute("DELETE FROM NEWS WHERE COMPANY_IDX = :1", [company_idx])
        print(f"기업 {company_idx}에 대한 기존 뉴스 데이터를 삭제했습니다.")

        for article in articles:
            # print(f"Inserting news for {company_idx}: {article['title']}, {article['date']}, {article['url']}, {article['image_url']}, {article['description']}")

            cursor.execute("""
                INSERT INTO NEWS (NEWS_TITLE, NEWS_DESCRIPTION, NEWS_DATE, NEWS_URL, NEWS_IMAGE, COMPANY_IDX)
                VALUES (:1, :2, TO_DATE(:3, 'YYYY-MM-DD'), :4, :5, :6)
            """, [
                article['title'],
                article['description'],
                article['date'],
                article['url'],
                article['image_url'],
                company_idx
            ])

        conn.commit()  # 트랜잭션 커밋
        print("뉴스 기사를 DB에 성공적으로 삽입했습니다.")
    except oracledb.DatabaseError as e:
        print(f"DB 삽입 실패: {e}")
        conn.rollback()  # 오류 발생 시 롤백


# 기업 목록을 DB에서 가져와서 뉴스 처리
def fetch_and_store_news():
    conn, cursor = connect_to_db()
    if conn and cursor:
        try:
            cursor.execute("SELECT COMPANY_IDX, COMPANY_NAME FROM COMPANY")
            companies = cursor.fetchall()

            for company in companies:
                company_idx, company_name = company
                # print(f"기업명: {company_name}, Idx: {company_idx}")

                news_articles = get_news(company_name)
                if news_articles:
                    insert_news_into_db(conn, cursor, news_articles, company_idx)
                time.sleep(1)  # API 호출 간 딜레이 추가
        finally:
            cursor.close()
            conn.close()


if __name__ == '__main__':
    fetch_and_store_news()
