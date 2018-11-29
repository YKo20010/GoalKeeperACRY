import json
from db import db, Goal, Subgoal
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
  """Create new goal specified by the user's text."""
  goal_body = json.loads(request.data)
  if 'text' not in goal_body:
    return json.dumps({'success': False, 'error': 'Needs text.'}), 404
  goal = Goal(
      text=goal_body.get('text'),
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
def update_goal(goal):
  """Update the goal specified by the user's text."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    goal_body = json.loads(request.data)
    if 'text' not in goal_body:
      return json.dumps({
          'success': False,
          'error': 'Invalid goal! An updated goal requires a text field.'
      })
    goal.text = goal_body.get('text', goal.text)
    db.session.commit()
    return json.dumps({'success': True, 'data': goal.serialize()}), 200
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404

@app.route('/api/goal/<int:goal_id>/', methods=['DELETE'])
def delete_goal(goal_id):
  """Delete the goal specified by the goal id."""
  goal = Goal.query.filter_by(id=post_id).first()
  if goal is not None:
    db.session.delete(goal)
    db.session.commit()
    return json.dumps({'success': True, 'data': goal.serialize()}), 200
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404

@app.route('/api/goal/<int:goal_id>/subgoals/')
def get_subgoals(goal_id):
  """Return the subgoals for the specified goal."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    subgoals = [subgoal.serialize() for subgoal in goal.subgoals]
    return json.dumps({'success': True, 'data': subgoals}), 200
  return json.dumps({'success': False, 'error': 'Subgoal not found!'}), 404


@app.route('/api/goal/<int:goal_id>/subgoal/', methods=['POST'])
def create_subgoal(goal_id):
  """Create a new subgoal for a specified goal."""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is None:
    return json.dumps({'success': False, 'error': 'Goal not found!'}), 404
  subgoal_body = json.loads(request.data)
  if 'text' not in subgoal_body:
    return json.dumps({'success': False, 'error': 'Needs text.'}), 404
  subgoal = Subgoal(
      text=subgoal_body.get('text'),
      goal_id=goal.id
  )
  goal.subgoals.append(subgoal)
  db.session.add(subgoal)
  db.session.commit()
  return json.dumps({'success': True, 'data': subgoal.serialize()}), 201


@app.route('/api/goal/<int:goal_id>/subgoal/<int:subgoal_id>/', methods=['DELETE'])
def delete_subgoal(goal_id, subgoal_id):
  """Delete specified subgoal for a specified goal"""
  goal = Goal.query.filter_by(id=goal_id).first()
  if goal is not None:
    subgoal = Subgoal.query.filter_by(id=subgoal_id, goal_id=goal_id).first()
    if subgoal is not None:
      db.session.delete(subgoal)
      db.session.commit()
      return json.dumps({'success': True, 'data': subgoal.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Subgoal not found!'}), 404
  return json.dumps({'success': False, 'error': 'Goal not found!'}), 404


if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5000, debug=True)
