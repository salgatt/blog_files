from flask import Flask, render_template, request, jsonify

app = Flask(__name__)


@app.errorhandler(405)
def method_not_allowed(error):
    return jsonify({"error": "Only POST requests allowed"}), 405


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/status")
def status():
    return jsonify({"status": "OK", "message": "System running"})


@app.route("/process-data", methods=["POST"])
def process_data():
    input_data = request.form  # Or use request.json for JSON data
    # Process the input data here (e.g., validation, saving)
    print(input_data)

    return jsonify({"result": "success"})


if __name__ == "__main__":
    app.run(port=8000)
