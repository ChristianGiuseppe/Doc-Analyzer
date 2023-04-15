from model import evaluate
from flask import Flask
from flask import request
import base64

app = Flask(__name__)

@app.route("/analyze", methods=["POST"])
def analyze():
    json = request.json

    image = json["image"]

    #decode base64 string data
    decoded_data=base64.b64decode((image))
    #write the decoded data back to original format in  file
    img_file = open('_input.tif', 'wb')
    img_file.write(decoded_data)
    img_file.close()

    evaluate()
    my_string = ""
    with open("_cam.jpg", "rb") as img_file:
        my_string = base64.b64encode(img_file.read())

    return my_string


@app.route("/info")
def info():
    return "info"


app.run(host='0.0.0.0', port=3000)