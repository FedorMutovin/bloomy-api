SELECT id, 'Task' AS event_type, name AS name, initiated_at, user_id FROM tasks
UNION ALL
SELECT id, 'Wish' AS event_type, name AS name, initiated_at, user_id FROM wishes
UNION ALL
SELECT id, 'Thought' AS event_type, description AS name, initiated_at, user_id FROM thoughts
UNION ALL
SELECT id, 'Action' AS event_type, name AS name, initiated_at, user_id FROM actions
UNION ALL
SELECT id, 'Goal' AS event_type, name AS name, initiated_at, user_id FROM goals
UNION ALL
SELECT id, 'Decision' AS event_type, name AS name, initiated_at, user_id FROM decisions
UNION ALL
SELECT id, 'Activity' AS event_type, name AS name, initiated_at, user_id FROM activities
UNION ALL
SELECT id, 'Hobby' AS event_type, name AS name, initiated_at, user_id FROM hobbies
UNION ALL
SELECT id, 'Travel' AS event_type, destination AS name, initiated_at, user_id FROM travels
UNION ALL
SELECT id, 'Interest' AS event_type, name AS name, initiated_at, user_id FROM interests
UNION ALL
SELECT id, 'IndependentEvent' AS event_type, name AS name, occurred_at as initiated_at, user_id FROM independent_events
UNION ALL
SELECT id, 'Travel' AS event_type, destination AS name, initiated_at, user_id FROM travels
UNION ALL
SELECT id, 'Incident' AS event_type, name AS name, initiated_at, user_id FROM incidents;
