from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

class Goal(db.Model):
  __tablename__ = 'goal'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  user = db.Column(db.String, nullable=False)
  date = db.Column(db.String, nullable=False)
  description = db.Column(db.String, nullable=False)
  startDate = db.Column(db.String, nullable=False)
  endDate = db.Column(db.String, nullable=True)
  checkpoints = db.relationship('Checkpoint', cascade='delete')

  def __init__(self, **kwargs):
    self.name = kwargs.get('name', '')
    self.user = kwargs.get('user', '')
    self.date = kwargs.get('date', '')
    self.description = kwargs.get('description', '')
    self.startDate = kwargs.get('startDate', '')
    self.endDate = kwargs.get('endDate', '')

  def serialize(self):
    return {
        'id': self.id,
        'name': self.name,
        'user': self.user,
        'date': self.date,
        'description': self.description,
        'startDate': self.startDate,
        'endDate': self.endDate
    }

class Checkpoint(db.Model):
  __tablename__ = 'checkpoint'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  date = db.Column(db.String, nullable=False)
  isFinished = db.Column(db.Boolean, nullable=False)
  startDate = db.Column(db.String, nullable=False)
  endDate = db.Column(db.String, nullable=False)
  goal_id = db.Column(db.Integer, db.ForeignKey('goal.id'), nullable=False)

  def __init__(self, **kwargs):
    self.name = kwargs.get('name', '')
    self.date = kwargs.get('date', '')
    self.isFinished = kwargs.get('isFinished', False)
    self.startDate = kwargs.get('startDate', '')
    self.endDate = kwargs.get('endDate', None)
    self.goal_id = kwargs.get('goal_id')

  def serialize(self):
    return {
        'id': self.id,
        'name': self.name,
        'date': self.date,
        'isFinshed': self.isFinished,
        'startDate': self.startDate,
        'endDate': self.endDate
    }
