from flask import Blueprint, render_template , request, redirect, url_for , session
import psycopg2
from datetime import datetime
user = Blueprint('user', __name__)

@user.route('/koszyk')
def koszyk():
    if not "user" in session:
         return redirect(url_for('views.home'))
    with psycopg2.connect(**db_params) as connection:
            with connection.cursor() as cursor:
                user_id = session["user"]
                query = "SELECT * FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s"
                cursor.execute(query, (str(user_id)))
                info = cursor.fetchall()
                query = "SELECT SUM(ks.price) FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s"
                cursor.execute(query, (str(user_id)))
                suma = cursor.fetchall()
                total = suma[0][0]
    



    return render_template('cart.html', info=info, total=total)
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

@user.route('/usun_przedmiot')
def remove_item_from_card():
    id = request.args.get('id', None)
    
    print(id + " to jest id")
    if id is not None:
        id = str(id)
        with psycopg2.connect(**db_params) as connection:
                    with connection.cursor() as cursor:
                        query = "DELETE FROM koszyk WHERE element_id = %s"
                        cursor.execute(query,(id,))
    
    return redirect(url_for('user.koszyk'))

@user.route('/profil')
def profil():
    id = str(session["user"])
    with psycopg2.connect(**db_params) as connection:
                    with connection.cursor() as cursor:
                        query = "SELECT * FROM konta AS ko INNER JOIN klienci AS kl ON ko.konto_id = kl.konto_id WHERE kl.klient_id = %s"
                        cursor.execute(query,(id,))
                        info = cursor.fetchall()
    print(info)
    return render_template('profile.html', info=info)


@user.route('/dodaj_komentarz')
def add_comment():
    id_book = session['item']
    id_user = session['user']
    print(f"Tutaj sprawdzam wartosci: {id_book} + {id_user}")
    data = request.form
    if (id_book is not None) and (id_user is not None):
        print("dziaa")
        tekst = data.get("komentarz")
        ocena = data.get("ocena")
        with psycopg2.connect(**db_params) as connection:
                with connection.cursor() as cursor:
                    query = "INSERT INTO opinie(klient_id,ksiazka_id,ocena_tekst,ocena) VALUES (%s,%s,%s,%s)"
                    cursor.execute(query,(id_user,id_book,tekst,ocena))
    return redirect(url_for('views.item',item_info=id_book))

