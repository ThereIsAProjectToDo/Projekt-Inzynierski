from flask import Blueprint, render_template , request, redirect, url_for , session
import psycopg2

user = Blueprint('user', __name__)


@user.route('/profil')
def profil():
    query = "SELECT  FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s}"
    return render_template('profile.html')

@user.route('/koszyk')
def koszyk():
    with psycopg2.connect(**db_params) as connection:
            with connection.cursor() as cursor:
                user_id = session["user"]
                query = "SELECT * FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s"
                cursor.execute(query, (str(user_id)))
                info = cursor.fetchall()
                print(info)
    



    return render_template('cart.html', info=info)
db_params = {
    'dbname': 'ksiegarnia',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'localhost',
    'port': '5432'
}

@user.route('/logowanie', methods=['GET','POST'])
def login():
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
            session["user"] = info[0][0]
            return redirect(url_for('views.books'))  
        else:
            return redirect(url_for('user.login'))         
    

    return render_template('login.html')

@user.route('/wyloguj')
def logout():
    session.pop("user",None)
    session.pop("list",None)
    return redirect(url_for('views.home'))

@user.route('/rejestracja', methods=['GET','POST'])
def sign_up():
    return render_template('sign_up.html')