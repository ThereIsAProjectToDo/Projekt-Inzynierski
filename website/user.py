from flask import Blueprint, render_template , request, redirect, url_for , session
import psycopg2
from datetime import datetime
user = Blueprint('user', __name__)
db_params = {
    'dbname': 'postgres',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'ksiengarnia-db.cshzuj1alait.eu-north-1.rds.amazonaws.com',
    'port': '5432'
}
@user.route('/koszyk')
def koszyk():
    if not "user" in session:
         return redirect(url_for('views.home'))
    with psycopg2.connect(**db_params) as connection:
            with connection.cursor() as cursor:
                user_id = session["user"]
                query = "SELECT *,ko.ilosc * ks.price AS calosc FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s ORDER BY ko.data_dodania ASC"
                cursor.execute(query, (str(user_id)))
                info = cursor.fetchall()
                query = "SELECT SUM(ks.price * ko.ilosc) FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s"
                cursor.execute(query, (str(user_id)))
                suma = cursor.fetchall()
                total = suma[0][0]
    



    return render_template('cart.html', info=info, total=total, liczba=5)


@user.route('/logowanie', methods=['GET','POST'])
def login():
    print("logowanie")
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
    print("asdasd")
    if request.method == "POST":
        data = request.form
        email = data.get("email")
        imie = data.get("imie")
        nazwisko = data.get("nazwisko")
        haslo1 = data.get("haslo1")
        haslo2 = data.get("haslo2")
        print(haslo1 + " " + haslo2)
        if haslo1!=haslo2:
             return render_template('sign_up.html',message="Błędny hasło lub email")
        else:
            with psycopg2.connect(**db_params) as connection:
                    with connection.cursor() as cursor:
                        query = "WITH new_user AS (INSERT INTO konta (email,haslo,data_utworzenia,status_konta) VALUES (%s,%s,CURRENT_TIMESTAMP,'aktywne') RETURNING konto_id) INSERT INTO klienci(klient_id,imie,nazwisko) VALUES ((SELECT konto_id FROM new_user),%s,%s)"
                        cursor.execute(query, (email, haslo1, imie, nazwisko))
        return render_template('sign_up.html',message="Poprawnie utworzono konto")       
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
                        cursor.execute(query,(id))
                        info = cursor.fetchall()
    print(info)
    return render_template('profile.html', info=info)
@user.route('/profil_edycja',methods=['GET','POST'])
def profil_edycja():
    id = str(session["user"])
    if request.method == "POST":
        data = request.form
        email = data.get("email")
        imie = data.get("imie")
        nazwisko = data.get("nazwisko")
        telefon = data.get("telefon")
        adres = data.get("adres")
        with psycopg2.connect(**db_params) as connection:
                    with connection.cursor() as cursor:
                        query = "Update konta SET email = %s WHERE konto_id = %s"
                        cursor.execute(query, (email,id))
                        query = "Update klienci SET imie = %s, nazwisko = %s, telefon = %s, adres = %s WHERE konto_id = %s"
                        cursor.execute(query, (imie,nazwisko,telefon,adres,id))
        return redirect(url_for('user.profil'))
    with psycopg2.connect(**db_params) as connection:
                    with connection.cursor() as cursor:
                        query = "SELECT * FROM konta AS ko INNER JOIN klienci AS kl ON ko.konto_id = kl.konto_id WHERE kl.klient_id = %s"
                        cursor.execute(query,(id))
                        info = cursor.fetchall()
    print(info)
    
    return render_template('edit_profile.html', info=info)


@user.route('/przetwarzanie_zamowienia',methods=['GET','POST'])
def przetwarzanie_zamowienia():
    if not "user" in session:
         return redirect(url_for('views.home'))
    with psycopg2.connect(**db_params) as connection:
            with connection.cursor() as cursor:
                user_id = session["user"]
                query = "SELECT * FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s ORDER BY ko.data_dodania ASC"
                cursor.execute(query, (str(user_id)))
                info = cursor.fetchall()
                query = "SELECT SUM(ks.price * ko.ilosc) FROM koszyk AS ko INNER JOIN klienci AS kl ON ko.klient_id = kl.klient_id INNER JOIN ksiazki AS ks ON ko.ksiazka_id = ks.ksiazka_id WHERE kl.klient_id = %s"
                cursor.execute(query, (str(user_id)))
                suma = cursor.fetchall()
                total = suma[0][0]
                query = "INSERT INTO zamowienia (klient_id, data_zamowienia, cena) VALUES (%s, CURRENT_TIMESTAMP, %s) RETURNING zamowienie_id"
                cursor.execute(query, (str(user_id),total))
                zamowienie_id = cursor.fetchone()[0]
                for row in info:
                      query = "INSERT INTO zamowienia_przedmioty (ksiazka_id,zamowienie_id,ilosc,cena) VALUES (%s,%s,%s,%s)" 
                      cursor.execute(query,(row[1],zamowienie_id,row[3],row[15]))
                query = "DELETE FROM koszyk WHERE klient_id = %s"
                cursor.execute(query,str(user_id))

    return redirect(url_for('user.koszyk'))


@user.route('/historia_zamowien',methods=['GET','POST'])
def historia_zamowien():
    with psycopg2.connect(**db_params) as connection:
            with connection.cursor() as cursor:
                query = "SELECT * FROM zamowienia_przedmioty as zp INNER JOIN ksiazki as ks ON zp.ksiazka_id = ks.ksiazka_id INNER JOIN zamowienia as za ON za.zamowienie_id = zp.zamowienie_id WHERE za.klient_id = %s ORDER BY za.zamowienie_id"
                cursor.execute(query, (str(session['user'])))
                data = cursor.fetchall()


    return render_template('history.html')