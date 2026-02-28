#!/usr/bin/python3
from flask import Flask, request, jsonify, render_template
import pymysql
from datetime import datetime, timezone
from moqpdbconfig import *

VERSION = '1.0.0'

app = Flask(__name__)

def get_db():
    return pymysql.connect(
        host=HOSTNAME,
        user=USER,
        password=PW,
        database=DBNAME,
        cursorclass=pymysql.cursors.DictCursor
    )

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/howto")
def howto():
    return render_template("howto.html")

@app.route("/tabular")
def tabular():
    return render_template("tabular.html")

@app.route("/api/savePlan", methods=["POST"])
def save_plan():
    data = request.json
    callsign = data['callsign']
    callsign = callsign.upper()

    conn = get_db()
    cur = conn.cursor()

    # if old data for this call exists, delete it.
    cur.execute(f"""
         select * from plans where callsign='{callsign}' LIMIT 1;
    """)
    plan = cur.fetchone()
    if (plan):
        # Delete old plan for this callsign.
        print(f'Deleting old data for {callsign}...')
        cur.execute(f"""delete from plans where callsign='{callsign}';""")

    cur.execute("""
        INSERT INTO plans (callsign, event, saved_at)
        VALUES (%s, %s, %s)
    """, (
        callsign,
        data["event"],
        datetime.now(timezone.utc)
    ))

    plan_id = cur.lastrowid

    #print(f'{data["counties"]=}')

    for c in data["counties"]:
        #print(f'{c=}')
        cur.execute("""
            INSERT INTO plan_counties
            (plan_id, stateFips, countyFips, name, type)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            plan_id,
            c["stateFips"],
            c["countyFips"],
            c["name"],
            c["type"]
        ))

    conn.commit()
    cur.close()
    conn.close()

    return jsonify({"ok": True, "planId": plan_id})

@app.route("/api/loadPlan")
def load_plan():
    callsign = request.args.get("callsign")
    callsign = callsign.upper()
    event = request.args.get("event")

    conn = get_db()
    cur = conn.cursor()

    cur.execute("""
        SELECT id FROM plans
        WHERE callsign=%s AND event=%s
        ORDER BY saved_at DESC
        LIMIT 1
    """, (callsign, event))

    plan = cur.fetchone()
    #print(f'{callsign=}\n{plan=}')

    if not plan:
        return jsonify([])

    cur.execute("""
        SELECT stateFips, countyFips, name, type
        FROM plan_counties
        WHERE plan_id=%s
    """, (plan["id"],))

    counties = cur.fetchall()
    #print(f'{counties=}')
    cur.close()
    conn.close()

    return jsonify(counties)

@app.route("/api/allActive")
def all_active():
    conn = get_db()
    cur = conn.cursor(pymysql.cursors.DictCursor)

    cur.execute("""
        SELECT pc.stateFips,
               pc.countyFips,
               GROUP_CONCAT(DISTINCT p.callsign) AS callsigns
        FROM plan_counties pc
        JOIN plans p ON pc.plan_id = p.id
        GROUP BY pc.stateFips, pc.countyFips
    """)

    rows = cur.fetchall()
    cur.close()
    conn.close()

    #print(f'{rows=}')

    return jsonify(rows)

@app.route("/api/allTabular")
def all_tabular():
    conn = get_db()
    cur = conn.cursor(pymysql.cursors.DictCursor)

    cur.execute("""
        SELECT pc.stateFips,
               pc.countyFips,
               pc.name,
               pc.type,
               GROUP_CONCAT(DISTINCT p.callsign) AS callsigns
        FROM plan_counties pc
        JOIN plans p ON pc.plan_id = p.id
        GROUP BY pc.stateFips, pc.countyFips, pc.name,pc.type;
    """)

    rows = cur.fetchall()
    cur.close()
    conn.close()

    #print(f'{rows=}')

    return jsonify(rows)




if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)

