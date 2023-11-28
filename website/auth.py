from flask import Blueprint, render_template, redirect, url_for, request, session
auth = Blueprint('auth', __name__)
import psycopg2

db_params = {
    'dbname': 'ksiegarnia',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'localhost',
    'port': '5432'
}

@auth.route('/login', methods=['GET','POST'])
def login():
    # if request.method == "POST":
    #     session.permanent = True
    #     user = request.form["login"]
    #     session["user"] = user
    #     return redirect(url_for('views.books'))
    # else:
    #     if "user" in session:
    #         return redirect(url_for('views.books'))
    
    if request.method == "POST":
        data = request.form
        email = data.get("email")
        haslo = data.get("haslo1")
        with psycopg2.connect(**db_params) as connection:
                with connection.cursor() as cursor:
                    query = "SELECT * FROM konta WHERE email = %s AND haslo = %s"
                    cursor.execute(query, (email, haslo))
                    info = cursor.fetchall()
                    print(info)

        if info:
            session.permanent = True
            session["user"] = info[0][1]
            return redirect(url_for('views.books'))  
        else:
            return redirect(url_for('auth.login'))         
    

    return render_template('login.html')

@auth.route('/logout')
def logout():
    session.pop("user",None)
    return redirect(url_for('views.home'))

@auth.route('/sign_up', methods=['GET','POST'])
def sign_up():
    return render_template('sign_up.html')

 #     email = data.get("email")
    #     haslo = data.get("haslo1")
    #     connection = psycopg2.connect(**db_params)
    #     cursor = connection.cursor()
    #     query = f"SELECT * FROM konta WHERE email = {email} AND haslo = {haslo}"
    #     cursor.execute(query)
    #     info = cursor.fetchall()
    #     cursor.close()
    #     connection.close()
    #     print(info)
    #     if info:
    #         print("Logowanie zakończone sukcesem")
    #     else:
    #         print("nie udało się zalogować")