class RemovePayGradeFromAssignment < ActiveRecord::Migration[5.2]
  def change
    remove_reference :assignments, :pay_grade, foreign_key: true
  end
end
