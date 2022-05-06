class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :major, :instructor_id
end
