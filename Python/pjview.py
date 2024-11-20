from langchain.chains import RetrievalQA
from langchain_openai import ChatOpenAI
from langchain_pinecone import PineconeVectorStore
from langchain_openai import OpenAIEmbeddings
from langchain import hub

# 직무관련 면접질문 추출
def get_interview_questions(company_name, job_position):
    embedding = OpenAIEmbeddings(model='text-embedding-3-large')

    index_name = 'project'
    # 이미 저장된 index를 사용하기 때문에 from_existing_index를 사용한다.
    database = PineconeVectorStore.from_existing_index(embedding=embedding, index_name=index_name)

    llm = ChatOpenAI(model='gpt-4o')
    prompt = hub.pull("rlm/rag-prompt")
    retriever = database.as_retriever(search_kwargs={'k': 4})

    # 쿼리 생성 - 프롬프트 개선
    query = f"{company_name}의 {job_position} 직무 면접에서 물어볼 수 있는 직무 관련 질문 4개를 작성해주세요. 설명이나 부가적인 문구 없이 질문만 작성해주세요."

    # QA 체인 설정
    qa_chain = RetrievalQA.from_chain_type(
        llm,
        retriever=retriever,
        chain_type="stuff",
    )

    # 질문 생성
    ai_message = qa_chain({"query": query})

    # 결과 반환: 질문들을 리스트로 변환하여 반환
    if ai_message and 'result' in ai_message:
        return ai_message['result']
    else:
        return ["검색 결과가 없습니다."]

def get_personality_questions(user_introduction):
    embedding = OpenAIEmbeddings(model='text-embedding-3-large')

    index_name = 'personal'

    # 이미 저장된 index를 사용하기 때문에 from_existing_index를 사용한다.
    database = PineconeVectorStore.from_existing_index(embedding=embedding, index_name=index_name)

    llm = ChatOpenAI(model='gpt-4o')
    prompt = hub.pull("rlm/rag-prompt")
    retriever = database.as_retriever(search_kwargs={'k': 4})

    # 쿼리 생성 - 프롬프트 개선
    query = f"다음 자기소개서 내용을 바탕으로 물어볼 수 있는 인성 면접 질문 4개를 작성해주세요. 설명이나 부가적인 문구 없이 질문만 작성해주세요: {user_introduction}"

    # Pinecone에서 데이터 검색을 위한 리트리버 설정
    retriever = database.as_retriever(search_kwargs={'k': 4})

    # LLM 모델 초기화
    llm = ChatOpenAI(model='gpt-4o')

    # QA 체인 설정
    qa_chain = RetrievalQA.from_chain_type(
        llm,
        retriever=retriever,
        chain_type="stuff",
    )

    # 질문 생성
    ai_message = qa_chain({"query": query})

    # 결과 반환: 질문들을 리스트로 변환하여 반환
    if ai_message and 'result' in ai_message:
        return ai_message['result']
    else:
        return ["검색 결과가 없습니다."]