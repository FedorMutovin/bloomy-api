SELECT id, 'Task' AS root_type, name, initiated_at, user_id FROM tasks
UNION ALL
SELECT id, 'Wish' AS root_type, name, initiated_at, user_id FROM wishes
UNION ALL
SELECT id, 'Thought' AS root_type, description AS name, initiated_at, user_id FROM thoughts
UNION ALL
SELECT id, 'Action' AS root_type, name, initiated_at, user_id FROM actions
UNION ALL
SELECT id, 'Goal' AS root_type, name, initiated_at, user_id FROM goals
UNION ALL
SELECT id, 'Decision' AS root_type, name, initiated_at, user_id FROM decisions
UNION ALL
SELECT id, 'Activity' AS root_type, name, initiated_at, user_id FROM activities
UNION ALL
SELECT id, 'Hobby' AS root_type, name, initiated_at, user_id FROM hobbies
UNION ALL
SELECT id, 'Travel' AS root_type, destination AS name, initiated_at, user_id FROM travels
UNION ALL
SELECT id, 'Interest' AS root_type, name, initiated_at, user_id FROM interests
UNION ALL
SELECT id, 'IndependentEvent' AS root_type, name, occurred_at as initiated_at, user_id FROM independent_events
UNION ALL
SELECT id, 'Incident' AS root_type, name, initiated_at, user_id FROM incidents
UNION ALL
SELECT id, 'Movie' AS root_type, name, initiated_at, user_id FROM incidents
UNION ALL
SELECT id, 'Conflict' AS root_type, "with" AS name, initiated_at, user_id FROM conflicts;
