import oracledb
from pjfunction import get_interview_questions, get_personality_questions
import os
from dotenv import load_dotenv
import concurrent.futures
import sys
import io

# 표준 출력 인코딩 설정
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')

load_dotenv()

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

def get_data_parallel(self_idx):
    """병렬로 회사 정보와 자기소개서 데이터 가져오기"""
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT sb.SELF_COMPANY, sb.SELF_POSITION, 
                       si.INTRO_QUESTION, si.INTRO_ANSWER
                FROM SELF_BOARD sb
                LEFT JOIN SELF_INTRODUCTION si ON sb.SELF_IDX = si.SELF_IDX
                WHERE sb.SELF_IDX = :1
            """, [self_idx])
            results = cursor.fetchall()

            if not results:
                print(f"데이터를 찾을 수 없습니다. self_idx: {self_idx}")
                return None, None, None

            company_name = results[0][0]
            job_position = results[0][1]
            intro_text = "\n\n".join([f" {row[2]}\nA: {row[3]}" for row in results if row[2] and row[3]])

            print(f"데이터 조회 성공 - 회사: {company_name}, 직무: {job_position}")
            return company_name, job_position, intro_text
    except Exception as e:
        print(f"데이터 조회 오류: {str(e)}")
        raise
    finally:
        connection.close()

def generate_and_save_questions(self_idx, company_name, job_position, intro_text, username):
    """질문 생성 및 저장"""
    try:
        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as executor:
            print("질문 생성 시작...")
            job_future = executor.submit(get_interview_questions, company_name, job_position)
            personality_future = executor.submit(get_personality_questions, intro_text)

            job_questions = job_future.result()
            personality_questions = personality_future.result()

        # 질문 리스트를 분리하고 정리
        all_questions = []

        if isinstance(job_questions, str):
            job_questions_list = [q.strip() for q in job_questions.split('\n') if q.strip()]
        else:
            job_questions_list = job_questions

        if isinstance(personality_questions, str):
            personality_questions_list = [q.strip() for q in personality_questions.split('\n') if q.strip()]
        else:
            personality_questions_list = personality_questions

        print(f"생성된 직무 질문 수: {len(job_questions_list)}, 인성 질문 수: {len(personality_questions_list)}")

        # 질문 저장
        connection = get_db_connection()
        try:
            with connection.cursor() as cursor:
                print("기존 질문 삭제 중...")
                cursor.execute("DELETE FROM INTERVIEW_PRO WHERE SELF_IDX = :1", [self_idx])

                print("새 질문 저장 중...")
                # 직무 질문 저장
                for question in job_questions_list:
                    cursor.execute("""
                        INSERT INTO INTERVIEW_PRO (IPRO_IDX, IPRO_QUESTION, IPRO_TYPE, SELF_IDX, USERNAME, CREATED_AT)
                        VALUES ((SELECT NVL(MAX(IPRO_IDX), 0) + 1 FROM INTERVIEW_PRO), :1, 'position', :2, :3, SYSDATE)
                    """, [question, self_idx, username])

                # 인성 질문 저장
                for question in personality_questions_list:
                    cursor.execute("""
                        INSERT INTO INTERVIEW_PRO (IPRO_IDX, IPRO_QUESTION, IPRO_TYPE, SELF_IDX, USERNAME, CREATED_AT)
                        VALUES ((SELECT NVL(MAX(IPRO_IDX), 0) + 1 FROM INTERVIEW_PRO), :1, 'personal', :2, :3, SYSDATE)
                    """, [question, self_idx, username])

                connection.commit()
                print("질문 저장 완료")
        finally:
            connection.close()

    except Exception as e:
        print(f"질문 생성/저장 오류: {str(e)}")
        raise


def main(self_idx, username):
    try:
        print(f"처리 시작 - self_idx: {self_idx}, username: {username}")

        company_name, job_position, intro_text = get_data_parallel(self_idx)
        if not all([company_name, job_position, intro_text]):
            print("필요한 데이터가 없습니다")
            return False

        generate_and_save_questions(self_idx, company_name, job_position, intro_text, username)
        print("처리 완료")
        return True

    except Exception as e:
        print(f"오류 발생: {str(e)}")
        return False

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Error: self_idx and username arguments are required")
        sys.exit(1)

    try:
        self_idx = int(sys.argv[1])
        username = sys.argv[2]
        success = main(self_idx, username)
        sys.exit(0 if success else 1)
    except Exception as e:
        print(f"Fatal error: {str(e)}")
        sys.exit(1)