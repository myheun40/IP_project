import streamlit as st
from pjfunction import get_interview_questions, get_personality_questions

def main():
    st.set_page_config(
        page_title="AI 면접 질문 생성기",
        page_icon="🤖",
        layout="wide"
    )

    st.title("🎯 AI 면접 질문 생성기")

    with st.form("interview_form"):
        col1, col2 = st.columns(2)

        with col1:
            company_name = st.text_input("지원 회사명", placeholder="예: 삼성전자")
            job_position = st.text_input("지원 직무", placeholder="예: 백엔드 개발자")

        with col2:
            introduction = st.text_area("자기소개서", placeholder="자기소개서 내용을 입력해주세요...",height=150)

        submit_button = st.form_submit_button("질문 생성하기")

    if submit_button and company_name and job_position and introduction:
        with st.spinner("AI가 맞춤형 면접 질문을 생성하고 있습니다..."):
            try:
                # 직무 관련 질문 생성
                job_questions = get_interview_questions(company_name, job_position)
                if isinstance(job_questions, str):
                    job_questions = [q.strip() for q in job_questions.split('\n')
                                     if q.strip() and not q.startswith('다음') and not q.startswith('1.')]

                # 인성 질문 생성
                personality_questions = get_personality_questions(introduction)
                if isinstance(personality_questions, str):
                    personality_questions = [q.strip() for q in personality_questions.split('\n')
                                             if q.strip() and not q.startswith('다음') and not q.startswith('1.')]

                st.success("면접 질문이 생성되었습니다! 🎉")

                # 직무 관련 질문 출력
                st.subheader(f"📋 {job_position} 직무 관련 질문")
                for q in job_questions[:4]:
                    st.write(q)

                # 인성 질문 출력
                st.subheader("🎭 인성 면접 질문")
                for q in personality_questions[:4]:
                    st.write(q)

            except Exception as e:
                st.error(f"오류가 발생했습니다: {str(e)}")

    elif submit_button:
        st.warning("모든 필드를 입력해주세요!")

if __name__ == "__main__":
    main()