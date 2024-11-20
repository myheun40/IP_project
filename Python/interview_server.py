from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import subprocess
import sys
from fastapi.middleware.cors import CORSMiddleware
import os
from interview_feedback import process_feedback
import logging
from fastapi.responses import JSONResponse

# 로깅 설정
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

app = FastAPI()

sys.stdin.reconfigure(encoding='utf-8')
sys.stdout.reconfigure(encoding='utf-8')

# CORS 미들웨어 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8081"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class FeedbackRequest(BaseModel):
    self_idx: int
    answer: str
    question: str
    isJobQuestion: str

    class Config:
        json_encoders = {
            str: lambda v: v.encode('utf-8').decode('utf-8') if isinstance(v, str) else v
        }

class FeedbackResponse(BaseModel):
    feedback: str

class InterviewRequest(BaseModel):
    self_idx: int
    username: str

@app.post("/generate-interview")
async def generate_interview(request: InterviewRequest):
    try:
        current_dir = os.path.dirname(os.path.abspath(__file__))
        script_path = os.path.join(current_dir, "interview_generator.py")
        logger.info(f"스크립트 경로: {script_path}")

        # 환경변수 설정
        my_env = os.environ.copy()
        my_env["PYTHONIOENCODING"] = "cp949"

        # 명령어 실행
        process = subprocess.Popen(
            [sys.executable, script_path, str(request.self_idx), request.username],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            env=my_env,
            encoding='cp949',  # Windows 한글 인코딩
            text=True
        )

        stdout, stderr = process.communicate()

        logger.info(f"프로세스 출력: {stdout}")
        if stderr:
            logger.error(f"프로세스 오류: {stderr}")

        if process.returncode != 0:
            raise HTTPException(
                status_code=500,
                detail={
                    "message": "면접 질문 생성 중 오류가 발생했습니다",
                    "stdout": stdout,
                    "stderr": stderr
                }
            )

        return {
            "status": "success",
            "message": "면접 질문이 성공적으로 생성되었습니다",
            "output": stdout
        }

    except Exception as e:
        logger.error(f"오류 발생: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail=str(e)
        )

@app.post("/feedback-interview", response_model=FeedbackResponse)
async def feedback_interview(request: FeedbackRequest):
    try:
        logger.info(f"요청 받음: {request}")

        # 문자열 인코딩 처리
        question = request.question
        answer = request.answer
        is_job_question = request.isJobQuestion.lower() == 'position'

        # 피드백 생성
        feedback = process_feedback(
            request.self_idx,
            question,
            answer,
            is_job_question
        )

        logger.info(f"생성된 피드백: {feedback}")

        if isinstance(feedback, dict) and "error" in feedback:
            raise HTTPException(status_code=400, detail=feedback)

        # 응답 반환 추가
        return JSONResponse(
            content={"feedback": feedback["feedback"]},
            headers={"Content-Type": "application/json; charset=utf-8"}
        )

    except Exception as e:
        logger.error(f"서버 오류: {str(e)}")
        raise HTTPException(
            status_code=500,
            detail={"error": "서버에서 오류가 발생했습니다.", "details": str(e)}
        )

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        app,
        host="127.0.0.1",
        port=8000,
        reload=True
    )