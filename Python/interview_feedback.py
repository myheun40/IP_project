import oracledb
from pjfunction import get_answer_feedback
import os
from dotenv import load_dotenv
import sys
import io
import logging


# 표준 출력 인코딩 설정
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')

# 환경변수 로드
load_dotenv()

logging.basicConfig(level=logging.DEBUG)
#
# def get_db_connection():
#     try:
#         # 기본 Oracle 클라이언트 초기화
#         oracledb.init_oracle_client()
#
#         connection = oracledb.connect(
#             user=os.getenv('DB_USER'),
#             password=os.getenv('DB_PASSWORD'),
#             dsn=f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_SERVICE')}"
#         )
#         print("DB 연결 성공")
#         return connection
#     except Exception as e:
#         print(f"DB 연결 오류: {str(e)}")
#         raise

def get_db_connection():
    try:
        # 디버그 정보 출력
        print("=== 연결 디버그 정보 ===")
        oracle_client_path = r"C:\Users\USER\Oracle\instantclient_23_6"
        print(f"Oracle Client 경로: {oracle_client_path}")
        print(f"환경변수 확인:")
        print(f"DB_HOST: {os.getenv('DB_HOST')}")
        print(f"DB_PORT: {os.getenv('DB_PORT')}")
        print(f"DB_SERVICE: {os.getenv('DB_SERVICE')}")
        print(f"DB_USER: {os.getenv('DB_USER')}")
        print(f"ORACLE_HOME: {os.environ.get('ORACLE_HOME')}")
        print(f"TNS_ADMIN: {os.environ.get('TNS_ADMIN')}")

        # Oracle 클라이언트 초기화
        try:
            oracledb.init_oracle_client(lib_dir=oracle_client_path)
        except Exception as init_error:
            print(f"Oracle 클라이언트 초기화 오류: {str(init_error)}")
            raise

        # 연결 시도
        dsn = f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_SERVICE')}"
        print(f"연결 문자열: {dsn}")

        connection = oracledb.connect(
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD'),
            dsn=dsn
        )
        print("DB 연결 성공")
        return connection
    except Exception as e:
        print(f"DB 연결 오류 상세:")
        print(f"오류 타입: {type(e)}")
        print(f"오류 메시지: {str(e)}")
        raise


def get_job_from_db(self_idx):
    """DB에서 데이터 가져오기"""
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT sb.SELF_COMPANY, sb.SELF_POSITION
                FROM SELF_BOARD sb
                LEFT JOIN SELF_INTRODUCTION si ON sb.SELF_IDX = si.SELF_IDX
                WHERE sb.SELF_IDX = :1
            """, [self_idx])
            result = cursor.fetchone()

            if result:
                company_name, job_position = result
                print(f"DB에서 직무 정보 조회 성공: 회사={company_name}, 직무={job_position}")
                return company_name, job_position
            else:
                print(f"selfIdx {self_idx}에 대한 데이터가 없습니다.")
                return None, None

    except Exception as e:
        print(f"DB 조회 오류: {str(e)}")
        raise
    finally:
        connection.close()


def generate_feedback(question, answer, job_position, is_job_question=False):
    try:
        # 피드백 생성
        feedback = get_answer_feedback(question, answer, job_position, is_job_question)
        return {"feedback": feedback}

    except Exception as e:
        logging.error(f"인터뷰 피드백 처리 중 오류 발생: {str(e)}")
        return {"error": "피드백 생성에 실패했습니다.", "details": str(e)}


# FastAPI와 통합될 함수
def process_feedback(self_idx, question, answer, is_job_question=False):
    try:
        logging.info(f"처리 시작 - self_idx: {self_idx}")

        # DB에서 직무 정보 조회
        company_name, job_position = get_job_from_db(self_idx)
        if not company_name or not job_position:
            logging.error("필요한 직무 정보가 없습니다")
            return {"error": "필요한 직무 정보가 없습니다."}

        # 피드백 생성
        feedback = generate_feedback(question, answer, job_position, is_job_question)
        logging.info(f"피드백 생성 완료: {feedback}")
        return feedback

    except Exception as e:
        logging.error(f"오류 발생: {str(e)}")
        return {"error": str(e)}


# FastAPI와 연동된 엔드포인트에서 호출할 부분
if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Error: self_idx, question, and answer arguments are required")
        sys.exit(1)

    try:
        # 명령어 인자로 self_idx, question, answer, is_job_question 전달
        self_idx = int(sys.argv[1])
        question = sys.argv[2]
        answer = sys.argv[3]
        is_job_question = sys.argv[4].lower() == 'position' if len(sys.argv) > 4 else False

        feedback = process_feedback(self_idx, question, answer, is_job_question)
        print(feedback)
        sys.exit(0)

    except Exception as e:
        logging.error(f"Fatal error: {str(e)}")
        sys.exit(1)