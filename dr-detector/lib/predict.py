import numpy as np
from PIL import Image
import tensorflow as tf

# Define the image preprocessing function
def preprocess_image(image_path):
    image = Image.open(image_path)
    image = image.resize((256, 256))  # Adjust based on your model input size
    image = np.array(image) / 255.0   # Normalize the image
    image = np.expand_dims(image, axis=0)
    return image

# Load the TFLite model
interpreter = tf.lite.Interpreter(model_path="model.tflite")
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Define the prediction function
def predict(image_path):
    # Preprocess the image
    image = preprocess_image(image_path)

    # Set the tensor to point to the input data to be inferred
    interpreter.set_tensor(input_details[0]['index'], image)

    # Run inference
    interpreter.invoke()

    # The function `get_tensor` returns a copy of the tensor data
    output_data = interpreter.get_tensor(output_details[0]['index'])

    # Assuming the output is a probability distribution over defect types
    defect_types = ['Normal', 'Cataract', 'Glaucoma', 'Diabetic Retinopathy']
    confidence_scores = output_data[0]

    # Get the defect type with the highest confidence score
    max_index = np.argmax(confidence_scores)
    defect_type = defect_types[max_index]
    confidence_score = confidence_scores[max_index]

    return defect_type, confidence_score

# Example usage:
# image_path = 'path/to/your/image.jpg'
# defect_type, confidence_score = predict(image_path)
# print(f"Defect Type: {defect_type}, Confidence Score: {confidence_score}")
