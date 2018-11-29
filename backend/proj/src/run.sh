export FLASK_APP=routes.py # point the Flask app at routes.py
export FLASK_ENV=development # tell Flask we want debugging
flask run --host=0.0.0.0 # make the app accessible externally
