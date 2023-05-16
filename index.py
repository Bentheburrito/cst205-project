"""
CST 205 Spring 2023
A Python + Flask website to host quizzes

Authors:
Yuki Okamoto
Ben Woodward
Elijah Garza
"""

from flask import Flask, render_template
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
  return 'Hello World'

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

@app.route('/quiz/<id>')
def get_quiz(id):
  sql.execute(f"SELECT * FROM questions WHERE quiz_id = {id}")
  questions = sql.fetchall()

  return render_template('quiz-page.html', questions=questions)