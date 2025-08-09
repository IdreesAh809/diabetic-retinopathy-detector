<<<<<<< HEAD
# ViT Flask App

A Flask web application for image classification using Vision Transformer (ViT) models.

## Project Structure

```
vit-flask-app/
│
├── app.py                   # Flask application
├── requirements.txt         # Dependencies list
├── README.md               # Project documentation
├── my_model/               # Folder for your SavedModel
│   ├── saved_model.pb      # TensorFlow SavedModel file
│   └── variables/          # Model variables directory
├── uploads/                # To save uploaded images
│   └── .gitkeep           # Keeps directory in git
├── templates/              # HTML templates
│   └── index.html         # Main application interface
└── .gitignore             # Git ignore rules
```

## Setup Instructions

1. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Add your model:**
   - Place your TensorFlow SavedModel files in the `my_model/` directory
   - Ensure you have `saved_model.pb` and the `variables/` folder

3. **Run the application:**
   ```bash
   python app.py
   ```

4. **Access the application:**
   - Open your browser and go to `http://localhost:5000`

## Features

- Image upload interface
- Real-time image classification
- Modern, responsive UI
- Support for various image formats

## Model Requirements

Your SavedModel should:
- Accept image inputs (typically 224x224 or 384x384 pixels)
- Output classification predictions
- Be compatible with TensorFlow 2.x

## File Descriptions

- `app.py`: Main Flask application with image processing and prediction logic
- `requirements.txt`: Python dependencies for the project
- `templates/index.html`: Web interface for image upload and results display
- `uploads/`: Directory for temporary storage of uploaded images
- `my_model/`: Directory containing your trained ViT model
- `.gitignore`: Excludes unnecessary files from version control

=======
# diabetic-retinopathy-detector
Deep learning-based detector for diabetic retinopathy using ResNet and ViT, with TFLite models and sample app integration.
>>>>>>> 4fce15f9c86fd1e4ee43154f0505ce9ec8581a3f
