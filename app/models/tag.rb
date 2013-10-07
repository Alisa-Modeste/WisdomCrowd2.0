class Tag < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many(
    :question_rows,
    class_name: "Taggings",
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(
    :questions,
    through: :question_rows
  )
end