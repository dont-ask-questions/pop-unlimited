from flask import Flask, jsonify
import json

app = Flask(__name__)

# Load merged JSON
with open("merged_data.json", "r", encoding="utf-8") as file:
    merged_data = json.load(file)

@app.route('/get_character_data')
def get_character_data():
    return jsonify(merged_data)

if __name__ == '__main__':
    app.run(debug=True)