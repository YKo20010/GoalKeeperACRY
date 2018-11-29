from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

class Goal(db.Model):
  __tablename__ = 'goal'
  id = db.Column(db.Integer, primary_key=True)
  text = db.Column(db.String, nullable=False)
  subgoals = db.relationship('Subgoal', cascade='delete')

  def __init__(self, **kwargs):
    self.text = kwargs.get('text', '')

  def serialize(self):
    return {
        'id': self.id,
        'text': self.text
    }

class Subgoal(db.Model):
  __tablename__ = 'subgoal'
  id = db.Column(db.Integer, primary_key=True)
  text = db.Column(db.String, nullable=False)
  goal_id = db.Column(db.Integer, db.ForeignKey('goal.id'), nullable=False)

  def __init__(self, **kwargs):
    self.text = kwargs.get('text', '')
    self.goal_id = kwargs.get('goal_id')

  def serialize(self):
    return {
        'id': self.id,
        'text': self.text
    }
