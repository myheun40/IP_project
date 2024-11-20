from flask import Flask, render_template, request
import requests

app = Flask(__name__)


def get_news(query):
    # NewsAPI 키
    api_key = "6a21cbc4bbce4a03aaf8f646b96b004a"

    # 검색할 키워드
    # query = "당근마켓"
    # NewsAPI 엔드포인트 (한국어로 설정)
    url = f"https://newsapi.org/v2/everything?q={query}&language=ko&pageSize=10&apiKey={api_key}"

    # API 요청 보내기
    response = requests.get(url)
    news_data = response.json()

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

@app.route('/')
def home():
    return render_template('main.html')

# 뉴스 데이터를 반환하는 API 엔드포인트
@app.route('/news', methods=['GET'])
def news():
    corp_name = request.args.get('corp')  # 사용자가 입력한 기업명 가져오기
    if corp_name:
        news_articles = get_news(corp_name)  # 기업명으로 뉴스 검색
        return render_template('corp.html', articles=news_articles)
    else:
        return render_template('corp.html', articles=[])  # 기업명이 없을 경우 빈 리스트 반환
    # news_articles = get_news()
    # return render_template('corp.html', articles=news_articles)


if __name__ == '__main__':
    app.run(debug=True)