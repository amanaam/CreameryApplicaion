class AddPayGradeToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_reference :assignments, :PayGrade, foreign_key: true
  end
end
