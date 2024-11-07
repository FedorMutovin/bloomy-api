# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_07_204611) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "actions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "goal_id"
    t.uuid "user_id", null: false
    t.uuid "task_id"
    t.datetime "initiated_at", null: false
    t.string "name", null: false
    t.index ["goal_id"], name: "index_actions_on_goal_id"
    t.index ["task_id"], name: "index_actions_on_task_id"
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "initiated_at", null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "decisions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.datetime "initiated_at", null: false
    t.string "name", null: false
    t.index ["user_id"], name: "index_decisions_on_user_id"
  end

  create_table "event_engagement_changes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "target_type", null: false
    t.uuid "target_id", null: false
    t.integer "value", null: false
    t.text "reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id"], name: "index_event_engagement_changes_on_target"
  end

  create_table "event_reflections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reflectable_type", null: false
    t.uuid "reflectable_id", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reflectable_type", "reflectable_id"], name: "index_event_reflections_on_reflectable"
  end

  create_table "event_relationships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "triggerable_type", null: false
    t.uuid "triggerable_id", null: false
    t.string "impactable_type", null: false
    t.uuid "impactable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["impactable_type", "impactable_id"], name: "index_event_relationships_on_impactable"
    t.index ["triggerable_type", "triggerable_id"], name: "index_event_relationships_on_triggerable"
  end

  create_table "event_schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "scheduable_type", null: false
    t.uuid "scheduable_id", null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.jsonb "details"
    t.boolean "completed", default: false
    t.index ["scheduable_type", "scheduable_id"], name: "index_event_schedules_on_scheduable"
    t.index ["user_id"], name: "index_event_schedules_on_user_id"
  end

  create_table "goals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending", null: false
    t.datetime "closed_at"
    t.datetime "started_at"
    t.integer "priority", default: 0
    t.datetime "initiated_at", null: false
    t.datetime "postponed_at"
    t.datetime "postponed_until"
    t.text "description"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "hobbies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.integer "skill_level", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.integer "engagement_level", default: 0
    t.datetime "initiated_at", null: false
    t.index ["user_id"], name: "index_hobbies_on_user_id"
  end

  create_table "interests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "engagement_level", default: 0
    t.datetime "initiated_at", null: false
    t.index ["user_id"], name: "index_interests_on_user_id"
  end

  create_table "movies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name", null: false
    t.string "rating"
    t.datetime "completed_at"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_movies_on_user_id"
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "goal_id"
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending", null: false
    t.integer "priority", default: 0
    t.datetime "initiated_at", null: false
    t.datetime "closed_at"
    t.datetime "postponed_at"
    t.datetime "postponed_until"
    t.datetime "started_at"
    t.index ["goal_id"], name: "index_tasks_on_goal_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "thoughts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "initiated_at", null: false
    t.index ["user_id"], name: "index_thoughts_on_user_id"
  end

  create_table "travels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "description"
    t.string "destination", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "vacation_id"
    t.datetime "initiated_at", null: false
    t.index ["user_id"], name: "index_travels_on_user_id"
    t.index ["vacation_id"], name: "index_travels_on_vacation_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vacations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "initiated_at", null: false
    t.index ["user_id"], name: "index_vacations_on_user_id"
  end

  create_table "versions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "whodunnit"
    t.datetime "created_at"
    t.string "item_id", null: false
    t.string "item_type", null: false
    t.string "event", null: false
    t.text "object"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "wishes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 0
    t.datetime "initiated_at", null: false
    t.datetime "activated_at"
    t.string "name", null: false
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "actions", "goals"
  add_foreign_key "actions", "tasks"
  add_foreign_key "actions", "users"
  add_foreign_key "activities", "users"
  add_foreign_key "decisions", "users"
  add_foreign_key "event_schedules", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "hobbies", "users"
  add_foreign_key "interests", "users"
  add_foreign_key "movies", "users"
  add_foreign_key "tasks", "goals"
  add_foreign_key "tasks", "users"
  add_foreign_key "thoughts", "users"
  add_foreign_key "travels", "users"
  add_foreign_key "vacations", "users"
  add_foreign_key "wishes", "users"

  create_view "events", sql_definition: <<-SQL
      SELECT tasks.id,
      'Task'::text AS event_type,
      tasks.name,
      tasks.initiated_at,
      tasks.user_id
     FROM tasks
  UNION ALL
   SELECT wishes.id,
      'Wish'::text AS event_type,
      wishes.name,
      wishes.initiated_at,
      wishes.user_id
     FROM wishes
  UNION ALL
   SELECT thoughts.id,
      'Thought'::text AS event_type,
      thoughts.description AS name,
      thoughts.initiated_at,
      thoughts.user_id
     FROM thoughts
  UNION ALL
   SELECT actions.id,
      'Action'::text AS event_type,
      actions.name,
      actions.initiated_at,
      actions.user_id
     FROM actions
  UNION ALL
   SELECT goals.id,
      'Goal'::text AS event_type,
      goals.name,
      goals.initiated_at,
      goals.user_id
     FROM goals
  UNION ALL
   SELECT decisions.id,
      'Decision'::text AS event_type,
      decisions.name,
      decisions.initiated_at,
      decisions.user_id
     FROM decisions
  UNION ALL
   SELECT activities.id,
      'Activity'::text AS event_type,
      activities.name,
      activities.initiated_at,
      activities.user_id
     FROM activities
  UNION ALL
   SELECT hobbies.id,
      'Hobby'::text AS event_type,
      hobbies.name,
      hobbies.initiated_at,
      hobbies.user_id
     FROM hobbies
  UNION ALL
   SELECT travels.id,
      'Travel'::text AS event_type,
      travels.destination AS name,
      travels.initiated_at,
      travels.user_id
     FROM travels
  UNION ALL
   SELECT interests.id,
      'Interest'::text AS event_type,
      interests.name,
      interests.initiated_at,
      interests.user_id
     FROM interests;
  SQL
end
