class ValidateCheckConstraintsAndSetNotNull < ActiveRecord::Migration[7.2]
  def up
    # Validate check constraints
    validate_check_constraint :actions, name: "actions_user_id_null"
    validate_check_constraint :decisions, name: "decisions_user_id_null"
    validate_check_constraint :event_relationships, name: "event_relationships_triggerable_id_null"
    validate_check_constraint :event_relationships, name: "event_relationships_triggerable_type_null"
    validate_check_constraint :event_relationships, name: "event_relationships_impactable_id_null"
    validate_check_constraint :event_relationships, name: "event_relationships_impactable_type_null"
    validate_check_constraint :hobbies, name: "hobbies_user_id_null"

    # After validation, change column to NOT NULL
    change_column_null :actions, :user_id, false
    change_column_null :decisions, :user_id, false
    change_column_null :event_relationships, :triggerable_id, false
    change_column_null :event_relationships, :triggerable_type, false
    change_column_null :event_relationships, :impactable_id, false
    change_column_null :event_relationships, :impactable_type, false
    change_column_null :hobbies, :user_id, false

    # Remove check constraints after making the columns NOT NULL
    remove_check_constraint :actions, name: "actions_user_id_null"
    remove_check_constraint :decisions, name: "decisions_user_id_null"
    remove_check_constraint :event_relationships, name: "event_relationships_triggerable_id_null"
    remove_check_constraint :event_relationships, name: "event_relationships_triggerable_type_null"
    remove_check_constraint :event_relationships, name: "event_relationships_impactable_id_null"
    remove_check_constraint :event_relationships, name: "event_relationships_impactable_type_null"
    remove_check_constraint :hobbies, name: "hobbies_user_id_null"
  end

  def down
    # Re-add check constraints if needed for rollback
    add_check_constraint :actions, "user_id IS NOT NULL", name: "actions_user_id_null", validate: false
    add_check_constraint :decisions, "user_id IS NOT NULL", name: "decisions_user_id_null", validate: false
    add_check_constraint :event_relationships, "triggerable_id IS NOT NULL", name: "event_relationships_triggerable_id_null", validate: false
    add_check_constraint :event_relationships, "triggerable_type IS NOT NULL", name: "event_relationships_triggerable_type_null", validate: false
    add_check_constraint :event_relationships, "impactable_id IS NOT NULL", name: "event_relationships_impactable_id_null", validate: false
    add_check_constraint :event_relationships, "impactable_type IS NOT NULL", name: "event_relationships_impactable_type_null", validate: false
    add_check_constraint :hobbies, "user_id IS NOT NULL", name: "hobbies_user_id_null", validate: false

    # Allow NULL values again
    change_column_null :actions, :user_id, true
    change_column_null :decisions, :user_id, true
    change_column_null :event_relationships, :triggerable_id, true
    change_column_null :event_relationships, :triggerable_type, true
    change_column_null :event_relationships, :impactable_id, true
    change_column_null :event_relationships, :impactable_type, true
    change_column_null :hobbies, :user_id, true
  end
end