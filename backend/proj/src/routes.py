import json
from db import db, Goal, Checkpoint
from flask import Flask, request

db_filename = "info.db"
app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
  db.create_all()

@app.route('/api/goals/')
def get_goals():
  """Return all currently stored goals."""
  goals = Goal.query.all()
  res = {'success': True, 'data': [goal.serialize() for goal in goals]}
  return json.dumps(res), 200

@app.route('/api/goals/', methods=['POST'])
def create_goal():
  """Create a new goal."""
  goal_body = json.loads(request.data)
  if 'name' not in goal_body or 'date' not in goal_body or 'description' not in goal_body or 'startDate' not in goal_body or 'endDate' not in goal_body:
    return json.dumps({'success': False, 'error': 'Missing fields. Make sure all of the following fields are present: name, date, description, startDate, endDate.'}), 404
  goal = Goal(
      name=goal_body.get('name'),
      date=goal_body.get('date'),
      description=goal_body.get('description'),
      startDate=goal_body.get('startDate'),
      endDate=goal_body.get('endDate'),
  )
  db.session.add(goal)
  db.session.commit()
  return json.dumps({'success': True, 'data': goal.serialize()}), 201


@app.route('/api/goal/<int:goal_id>/')
def get_goal(goal_id):
  """Return the goal specified by the goal id."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    return json.dumps({'success': True, 'data': goal.serialize()}), 200
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404

@app.route('/api/goal/<int:goal_id>/', methods=['POST'])
def update_goal(goal_id):
  """Update the specified goal."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    goal_body = json.loads(request.data)
    goal.name = goal_body.get('name', goal.name)
    goal.date = goal_body.get('date', goal.date)
    goal.description = goal_body.get('description', goal.description)
    goal.startDate = goal_body.get('startDate', goal.startDate)
    goal.endDate = goal_body.get('endDate', goal.endDate)
    db.session.commit()
    return json.dumps({'success': True, 'data': goal.serialize()}), 200
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404

@app.route('/api/goal/<int:goal_id>/', methods=['DELETE'])
def delete_goal(goal_id):
  """Delete the goal specified by the goal id."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    db.session.delete(goal)
    db.session.commit()
    return json.dumps({'success': True, 'data': goal.serialize()}), 200
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404



@app.route('/api/goal/<int:goal_id>/checkpoints/')
def get_checkpoints(goal_id):
  """Return the checkpoints for a specified goal."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    checkpoints = [checkpoint.serialize() for checkpoint in goal.checkpoints]
    return json.dumps({'success': True, 'data': checkpoints}), 200
  return json.dumps({'success': False, 'error': 'Checkpoint not found!'}), 404


@app.route('/api/goal/<int:goal_id>/checkpoint/', methods=['POST'])
def create_checkpoint(goal_id):
  """Create a new checkpoint for a specified goal."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is None:
    return json.dumps({'success': False, 'error': 'Goal not found!'}), 404
  checkpoint_body = json.loads(request.data)
  if 'name' not in checkpoint_body or 'date' not in checkpoint_body or 'isFinished' not in checkpoint_body or 'startDate' not in checkpoint_body or 'endDate' not in checkpoint_body:
    return json.dumps({'success': False, 'error': 'Missing fields. Make sure all of the following fields are present: name, date, isFinished, startDate, endDate.'}), 404
  checkpoint = Checkpoint(
      name=checkpoint_body.get('name'),
      date=checkpoint_body.get('date'),
      isFinished=bool(checkpoint_body.get('isFinished')),
      startDate=checkpoint_body.get('startDate'),
      endDate=checkpoint_body.get('endDate'),
      goal_id=goal.id
  )
  goal.checkpoints.append(checkpoint)
  db.session.add(checkpoint)
  db.session.commit()
  return json.dumps({'success': True, 'data': checkpoint.serialize()}), 201

@app.route('/api/goal/<int:goal_id>/checkpoint/<int:checkpoint_id>/', methods=['POST'])
def update_checkpoint(goal_id, checkpoint_id):
  """Update a specified checkpoint within a specified goal."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    checkpoint = Checkpoint.query.filter_by(id=checkpoint_id, goal_id=goal_id).first()
    if checkpoint is not None:
      checkpoint_body = json.loads(request.data)
      checkpoint.name = checkpoint_body.get('name', checkpoint.name)
      checkpoint.date = checkpoint_body.get('date', checkpoint.date)
      checkpoint.description = checkpoint_body.get('isFinished', checkpoint.isFinished)
      checkpoint.startDate = checkpoint_body.get('startDate', checkpoint.startDate)
      checkpoint.endDate = checkpoint_body.get('endDate', checkpoint.endDate)
      db.session.commit()
      return json.dumps({'success': True, 'data': checkpoint.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Checkpoint not found!'}), 404
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404

@app.route('/api/goal/<int:goal_id>/checkpoint/<int:checkpoint_id>/', methods=['DELETE'])
def delete_checkpoint(goal_id, checkpoint_id):
  """Delete specified checkpoint for a specified goal"""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    checkpoint = Checkpoint.query.filter_by(id=checkpoint_id, goal_id=goal_id).first()
    if checkpoint is not None:
      db.session.delete(checkpoint)
      db.session.commit()
      return json.dumps({'success': True, 'data': checkpoint.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Checkpoint not found!'}), 404
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404


if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5000, debug=True)
