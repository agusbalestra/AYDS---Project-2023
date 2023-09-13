class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "debe ser una dirección de correo electrónico válida" } # verifica que haya un caracter antes y dsp del @
  validates :password, presence: true, length: { minimum: 4, too_short: "te queres ir hackeado?" }
  
  validate :password_match
  after_initialize :set_default_points

  attr_accessor :reppw

  def password_match
    if password != reppw
      errors.add(:password_confirmation, "debe coincidir con la contraseña")
    end
  end

  def set_default_points
    self.points ||= 0
  end

  def points_treatment(correct, diff)
    if correct
      self.sum_points(diff)
    else
      self.rest_points(diff)
    end
  end


  def sum_points(diff)
    new_points = self.points
    if (diff == 1)
      new_points += 10
    elsif (diff == 2)
      new_points += 20
    elsif (diff == 3)
      new_points += 30 
    end
    self.update_attribute :points, new_points
  end
  
  def rest_points(diff)
    new_points = self.points
    if (diff == 1)
      new_points -= 10
    elsif (diff == 2)
      new_points -= 20
    elsif (diff == 3)
      new_points += 30 
    end
    self.update_attribute :points, new_points
  end

end
