"""
CST 205 Spring 2023
A Python + Flask website to host quizzes

Authors:
Yuki Okamoto: Backend and Frontend
Ben Woodward: Backend and Database
Elijah Garza: Frontend
"""
from flask import Flask, render_template, request
from flask_bootstrap import Bootstrap5
import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()


mydb = mysql.connector.connect(
  host=os.environ['DB_HOST'],
  user=os.environ['DB_USER'],
  password=os.environ['DB_PASS'],
  database=os.environ['DB_NAME']
)

sql = mydb.cursor()

app = Flask(__name__)
bootstrap = Bootstrap5(app)

@app.route('/')
def hello():
  return render_template('home.html')

@app.route('/links')
def links():
  sql.execute("SELECT * FROM links")
  links = sql.fetchall()
  print(links)
  return render_template('links.html', links=links)

@app.route('/quizzes')
def quiz_summary():
  sql.execute("""
  SELECT 
    quizzes.id as quiz_id, 
    quizzes.name as quiz_name,
    subjects.id as subject_id,
    subjects.name as subject_name,
    subjects.image_url as subject_image 
  FROM quizzes JOIN subjects ON subjects.id = quizzes.subject_id
  """)
  quizzes = sql.fetchall()

  quizzes_by_subject = {}
  for (quiz_id, quiz_name, subject_id, subject_name, subject_image) in quizzes:
    quiz = (quiz_id, quiz_name, subject_name, subject_image)
    if subject_id in quizzes_by_subject:
      quizzes_by_subject[subject_id].append(quiz)
    else:
      quizzes_by_subject[subject_id] = [quiz]
  
  return render_template('quizzes.html', quizzes_by_subject=quizzes_by_subject)

@app.route('/quiz/<int:quiz_id>')
def get_quiz(quiz_id):
  sql.execute(f"SELECT * FROM questions WHERE quiz_id = {quiz_id}")
  questions = sql.fetchall()

  return render_template('quiz-page.html', questions=questions)

@app.route('/submit_quiz', methods=['POST'])
def submit_quiz():
    user_answers = request.form
    score = 0
    results = []

    for question_id, user_answer in user_answers.items():
        # Extract the actual question id from the form input name
        question_id = int(question_id.split('_')[1])
        # Fetch the correct answer and question text from the database
        sql.execute(f"SELECT question_text, answer, option_1, option_2, option_3 FROM questions WHERE id = {question_id}")
        question_text, correct_answer, option_1, option_2, option_3 = sql.fetchone()
        
        result = {
            "question": question_text,
            "your_answer": user_answer,
            "correct_answer": correct_answer,
            "opt1": option_1,
            "opt2": option_2,
            "opt3": option_3,
            "is_correct": int(user_answer) == correct_answer
        }
        results.append(result)

        if result["is_correct"]:
            score += 10

    return render_template('quiz_results.html', score=score, results=results)
