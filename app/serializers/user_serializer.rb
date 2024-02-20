class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :username,
             :age,
             :email,
             :created_at,
             :updated_at,
             :permission

  has_many :annotations

  def annotations
    object.annotations&.map do |note|
      {
        id: note.id,
        title: note.title,
        body: note.body,
        created_at: note.created_at,
        updated_at: note.updated_at
      } 
    end
  end
end
