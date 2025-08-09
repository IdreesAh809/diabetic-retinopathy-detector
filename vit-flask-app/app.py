import os
from flask import Flask, render_template, request, redirect, url_for
from PIL import Image
import numpy as np
import tensorflow as tf

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'static/uploads'

# Load your TensorFlow saved model once at startup
model_path = 'my_model'
model = tf.saved_model.load(model_path)
infer = model.signatures['serving_default']

# Class names for prediction
class_names = ['No DR', 'Mild', 'Moderate', 'Severe', 'Proliferative']

def predict(image_path):
    img = Image.open(image_path).convert('RGB')
    img = img.resize((224, 224))  # Change if your model expects other size
    img_array = np.array(img) / 255.0
    img_array = img_array.astype(np.float32)
    img_array = np.expand_dims(img_array, axis=0)
    
    input_key = list(infer.structured_input_signature[1].keys())[0]
    input_tensor = tf.convert_to_tensor(img_array)
    
    predictions = infer(**{input_key: input_tensor})
    output_key = list(predictions.keys())[0]
    preds = predictions[output_key].numpy()
    
    predicted_class = np.argmax(preds, axis=1)[0]
    return class_names[predicted_class]

@app.route('/', methods=['GET', 'POST'])
def index():
    prediction = None
    filename = None
    if request.method == 'POST':
        if 'file' not in request.files:
            return redirect(request.url)
        file = request.files['file']
        if file.filename == '':
            return redirect(request.url)
        if file:
            filename = file.filename
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            # Make sure upload folder exists
            os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
            file.save(filepath)
            prediction = predict(filepath)
            return render_template('index.html', prediction=prediction, filename=filename)
    return render_template('index.html')

if __name__ == '__main__':
    os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
    app.run(debug=True)
