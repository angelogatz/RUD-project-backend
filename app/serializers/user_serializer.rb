class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :age,
             :email,
             :permission

  has_many :annotations

  def annotations
    object.annotations&.map do |note|
      {
        id: note.id,
        title: note.title,
        body: note.body,
      } 
    end
  end
end
