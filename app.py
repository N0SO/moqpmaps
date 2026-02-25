#!/usr/bin/python3
from flask import Flask, request, jsonify, render_template
import pymysql
from datetime import datetime
from moqpdbconfig import *

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

@app.route("/api/savePlan", methods=["POST"])
def save_plan():
    data = request.json

    conn = get_db()
    cur = conn.cursor()

    cur.execute("""
        INSERT INTO plans (callsign, event, saved_at)
        VALUES (%s, %s, %s)
    """, (
        data["callsign"],
        data["event"],
        datetime.utcnow()
    ))

    plan_id = cur.lastrowid

    for c in data["counties"]:
        cur.execute("""
            INSERT INTO plan_counties
            (plan_id, state_fips, county_fips, name, type)
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
    if not plan:
        return jsonify([])

    cur.execute("""
        SELECT state_fips, county_fips, name, type
        FROM plan_counties
        WHERE plan_id=%s
    """, (plan["id"],))

    counties = cur.fetchall()

    cur.close()
    conn.close()

    return jsonify(counties)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)

